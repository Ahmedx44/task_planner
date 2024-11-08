import 'package:stacked/stacked.dart';

class AudioViewModel extends BaseViewModel {
  bool _isRecording = false;
  bool get isRecording => _isRecording;

  changeRecordingState() {
    _isRecording = !_isRecording;
    notifyListeners();
  }
}
