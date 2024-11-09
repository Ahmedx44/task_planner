// audio_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:stacked/stacked.dart';
import 'package:path/path.dart' as path;
import 'package:todo_app/ui/audio/audio_view_model.dart';

class AudioView extends StatelessWidget {
  const AudioView({super.key});

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) => viewModel.getAudioPermission(context),
      viewModelBuilder: () => AudioViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.7,
                color: Theme.of(context).colorScheme.surface,
                child: viewModel.recordedFiles.isEmpty
                    ? Center(
                        child: Text(
                          'No recordings yet',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 18,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: viewModel.recordedFiles.length,
                        itemBuilder: (context, index) {
                          final filePath = viewModel.recordedFiles[index];
                          final isPlaying =
                              viewModel.currentlyPlayingPath == filePath;
                          return Dismissible(
                            key: Key(filePath),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20.0),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              viewModel.deleteRecording(filePath);
                            },
                            child: ListTile(
                              title: Text(
                                'Recording ${viewModel.recordedFiles.length - index}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary),
                              ),
                              subtitle: Text(
                                viewModel.getFormattedDate(filePath),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  isPlaying ? Icons.stop : Icons.play_arrow,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                                onPressed: () =>
                                    viewModel.playRecording(filePath),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.06,
              ),
              StreamBuilder<RecordingDisposition>(
                stream: viewModel.recorder.onProgress,
                builder: (context, snapshot) {
                  final duration = snapshot.hasData
                      ? snapshot.data!.duration
                      : Duration.zero;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        formatDuration(duration),
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: viewModel.changeRecordingState,
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.1,
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 235, 235, 235),
                          ),
                          child: Center(
                            child: Container(
                              height: MediaQuery.sizeOf(context).height * 0.06,
                              width: MediaQuery.sizeOf(context).width * 0.12,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: viewModel.isRecording
                                    ? BoxShape.rectangle
                                    : BoxShape.circle,
                                borderRadius: viewModel.isRecording
                                    ? BorderRadius.circular(10)
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
