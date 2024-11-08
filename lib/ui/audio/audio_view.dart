import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/ui/audio/audio_view_model.dart';

class AudioView extends StatelessWidget {
  const AudioView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AudioViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.7,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.04,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          viewModel.changeRecordingState();
                        },
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
                                    ? BoxShape.circle
                                    : BoxShape.rectangle,
                                borderRadius: viewModel.isRecording
                                    ? null
                                    : BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
