import 'package:flutter_sound/flutter_sound.dart';
import 'package:stacked/stacked.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class AudioViewModel extends BaseViewModel {
  bool _isRecording = false;
  bool get isRecording => _isRecording;

  final recorder = FlutterSoundRecorder();
  final player = FlutterSoundPlayer();

  bool _isRecorderInitialized = false;
  String? _currentRecordingPath;
  List<String> recordedFiles = [];
  String? _currentlyPlayingPath;

  String? get currentlyPlayingPath => _currentlyPlayingPath;
  String? get currentRecordingPath => _currentRecordingPath;

  @override
  void dispose() {
    recorder.closeRecorder();
    player.closePlayer();
    super.dispose();
  }

  Future<bool> requestPermissions() async {
    // Request microphone permission
    final microphoneStatus = await Permission.microphone.request();
    if (microphoneStatus != PermissionStatus.granted) {
      return false;
    }

    // For Android 13 and above (API level 33+)
    if (Platform.isAndroid) {
      final audioStatus = await Permission.audio.request();
      if (audioStatus != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  Future<void> initRecorder() async {
    final hasPermission = await requestPermissions();

    if (!hasPermission) {
      throw 'Permissions not granted';
    }

    await recorder.openRecorder();
    await player.openPlayer();
    await recorder.setSubscriptionDuration(const Duration(milliseconds: 100));
    _isRecorderInitialized = true;
    await loadRecordedFiles();
    notifyListeners();
  }

  Future<String> getRecordingPath() async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String recordingsDir = '${appDir.path}/recordings';
    await Directory(recordingsDir).create(recursive: true);
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return path.join(recordingsDir, 'recording_$timestamp.aac');
  }

  Future<void> loadRecordedFiles() async {
    try {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String recordingsDir = '${appDir.path}/recordings';
      if (await Directory(recordingsDir).exists()) {
        final List<FileSystemEntity> files = Directory(recordingsDir)
            .listSync()
            .where((entity) => entity.path.endsWith('.aac'))
            .toList();
        recordedFiles = files.map((file) => file.path).toList();
        // Sort files by creation time (newest first)
        recordedFiles.sort((a, b) => b.compareTo(a));
        notifyListeners();
      }
    } catch (e) {
      print('Error loading recorded files: $e');
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Required'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> getAudioPermission(BuildContext context) async {
    try {
      await initRecorder();
    } catch (e) {
      print('Error initializing recorder: $e');
      showErrorDialog(
        context,
        'This app needs microphone and storage permissions to record audio. Please grant these permissions in settings.',
      );
    }
  }

  Future<void> changeRecordingState() async {
    if (!_isRecorderInitialized) return;
    try {
      if (recorder.isRecording) {
        final String? path = await recorder.stopRecorder();
        _isRecording = false;
        if (path != null) {
          recordedFiles.insert(0, path); // Add at the beginning of the list
          print('Audio saved to: $path');
        }
      } else {
        // Stop any playing audio before starting a new recording
        if (player.isPlaying) {
          await stopPlayback();
        }
        _currentRecordingPath = await getRecordingPath();
        await recorder.startRecorder(
          toFile: _currentRecordingPath,
          codec: Codec.aacADTS,
        );
        _isRecording = true;
      }
      notifyListeners();
    } catch (e) {
      print('Error during recording: $e');
    }
  }

  Future<void> deleteRecording(String filePath) async {
    try {
      if (_currentlyPlayingPath == filePath) {
        await stopPlayback();
      }
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        recordedFiles.remove(filePath);
        notifyListeners();
      }
    } catch (e) {
      print('Error deleting recording: $e');
    }
  }

  Future<void> playRecording(String filePath) async {
    try {
      if (_currentlyPlayingPath == filePath && player.isPlaying) {
        await stopPlayback();
      } else {
        if (player.isPlaying) {
          await stopPlayback();
        }
        _currentlyPlayingPath = filePath;
        await player.startPlayer(
          fromURI: filePath,
          codec: Codec.aacADTS,
          whenFinished: () {
            _currentlyPlayingPath = null;
            notifyListeners();
          },
        );
        notifyListeners();
      }
    } catch (e) {
      print('Error playing recording: $e');
      _currentlyPlayingPath = null;
      notifyListeners();
    }
  }

  Future<void> stopPlayback() async {
    try {
      await player.stopPlayer();
      _currentlyPlayingPath = null;
      notifyListeners();
    } catch (e) {
      print('Error stopping playback: $e');
    }
  }

  String getFormattedDate(String filePath) {
    try {
      final fileName = path.basename(filePath);
      final timestamp = int.tryParse(fileName.split('_')[1].split('.')[0]);
      if (timestamp != null) {
        final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
        // Pad minutes with leading zero if needed
        final minutes = date.minute.toString().padLeft(2, '0');
        return '${date.day}/${date.month}/${date.year} ${date.hour}:$minutes';
      }
    } catch (e) {
      print('Error formatting date: $e');
    }
    return 'Unknown date';
  }
}
