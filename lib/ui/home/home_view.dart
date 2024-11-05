import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/ui/audio/audio_view.dart';
import 'package:todo_app/ui/calender/calender_view.dart';
import 'package:todo_app/ui/home/home_view_model.dart';
import 'package:todo_app/ui/main/main_view.dart';
import 'package:todo_app/ui/profile/profile_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) => Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          bottomNavigationBar: BottomBarDefault(
              items: const [
                TabItem(title: 'Home', icon: CupertinoIcons.home),
                TabItem(title: 'Calendar', icon: CupertinoIcons.calendar),
                TabItem(title: 'Audio', icon: CupertinoIcons.mic),
                TabItem(title: 'Profile', icon: CupertinoIcons.person),
              ],
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              color: Theme.of(context).colorScheme.onSecondary,
              indexSelected: viewModel.selectedIndex,
              colorSelected: Theme.of(context).colorScheme.primary,
              onTap: (int index) => viewModel.setSelectedIndex(index)),
          body: selectedPage(viewModel.selectedIndex)),
    );
  }

  selectedPage(index) {
    if (index == 0) {
      return MainView();
    } else if (index == 1) {
      return CalenderView();
    } else if (index == 2) {
      return AudioView();
    } else if (index == 3) {
      return ProfileView();
    }
  }
}
