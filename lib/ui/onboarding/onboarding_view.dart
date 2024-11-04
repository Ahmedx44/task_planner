import 'package:cupertino_onboarding/cupertino_onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/ui/onboarding/onboarding_view_model.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => OnboardingViewModel(),
      builder: (context, viewModel, child) {
        return CupertinoOnboarding(
          onPressedOnLastPage: () {
            viewModel.navigatetosignup(context);
          },
          pages: [
            WhatsNewPage(
              title: const Text("Welcome to TODO"),
              features: [
                WhatsNewFeature(
                  icon: Icon(
                    CupertinoIcons.check_mark_circled,
                    color: CupertinoColors.activeGreen.resolveFrom(context),
                  ),
                  title: const Text('Stay Organized'),
                  description: const Text(
                    'Manage your tasks efficiently and stay on top of your daily schedule with organized to-do lists.',
                  ),
                ),
                WhatsNewFeature(
                  icon: Icon(
                    CupertinoIcons.time,
                    color: CupertinoColors.activeBlue.resolveFrom(context),
                  ),
                  title: const Text('Set Reminders'),
                  description: const Text(
                    'Add due dates and reminders to never miss an important task or deadline.',
                  ),
                ),
                WhatsNewFeature(
                  icon: Icon(
                    CupertinoIcons.star_fill,
                    color: CupertinoColors.systemYellow.resolveFrom(context),
                  ),
                  title: const Text('Prioritize Tasks'),
                  description: const Text(
                    'Highlight high-priority tasks and focus on what matters most each day.',
                  ),
                ),
              ],
            ),
            const CupertinoOnboardingPage(
              title: Text('Organize Your Life'),
              body: Icon(
                CupertinoIcons.square_stack_3d_down_right,
                size: 200,
              ),
            ),
            const CupertinoOnboardingPage(
              title: Text('Works in Light and Dark Mode'),
              body: Icon(
                CupertinoIcons.moon_fill,
                size: 200,
              ),
            ),
          ],
        );
      },
    );
  }
}
