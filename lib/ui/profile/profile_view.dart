import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:todo_app/assets/app_image.dart';
import 'package:todo_app/theme/theme.dart';
import 'package:todo_app/theme/theme_view_Model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          centerTitle: true,
          title: Text(
            'Profile',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.sizeOf(context).height * 0.03,
                horizontal: MediaQuery.sizeOf(context).width * 0.05),
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ExtendedImage.asset(
                        shape: BoxShape.circle,
                        height: MediaQuery.sizeOf(context).height * 0.07,
                        AppImage.task),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ahmed Gemechu',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onSecondary),
                        ),
                        Text(
                          'AhmedGemechu14@gmail.com',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.02,
                ),
                _profileSection(context),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.02,
                ),
                _settingSection(context),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.02,
                ),
                _aboutSection(context),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.02,
                ),
                _accountSection(context)
              ],
            ),
          ),
        ));
  }
}

Widget _profileSection(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'My Account',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Theme.of(context).colorScheme.onSecondary),
      ),
      SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.02,
      ),
      Container(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.sizeOf(context).height * 0.01),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.onPrimary),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.04),
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.sizeOf(context).height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(CupertinoIcons.person,
                            color: Theme.of(context).colorScheme.primary),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.02,
                        ),
                        Text(
                          'Personal Detail',
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Icon(Icons.navigate_next_outlined)
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.04),
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.sizeOf(context).height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.lock,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.02,
                        ),
                        Text(
                          'Change Password',
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Icon(Icons.navigate_next_outlined)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ],
  );
}

Widget _settingSection(BuildContext context) {
  final themeManager = getThemeManager(context);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Setting',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
      SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.02,
      ),
      Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        child: Column(
          children: [
            // Language Setting Option
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.04,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.sizeOf(context).height * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.globe,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.02,
                        ),
                        Text(
                          'Language',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.navigate_next_outlined),
                  ],
                ),
              ),
            ),
            // Dark Mode Setting Option
            ViewModelBuilder.reactive(
              viewModelBuilder: () => ThemeViewModel(),
              builder: (context, viewModel, child) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.04,
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.sizeOf(context).height * 0.02,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.moon,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.02,
                          ),
                          Text(
                            'Dark Mode',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      CupertinoSwitch(
                        // Ensure the switch is updated based on the current theme state
                        value: themeManager.isDarkMode,
                        onChanged: (value) {
                          themeManager
                              .toggleDarkLightTheme(); // This will toggle the theme
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _aboutSection(context) {
  bool toggleON = true;
  switchToggle() {
    toggleON = !toggleON;
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'About',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Theme.of(context).colorScheme.onSecondary),
      ),
      SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.02,
      ),
      Container(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.sizeOf(context).height * 0.01),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.onPrimary),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.04),
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.sizeOf(context).height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(CupertinoIcons.exclamationmark_circle,
                            color: Theme.of(context).colorScheme.primary),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.02,
                        ),
                        Text(
                          'About App',
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Icon(Icons.navigate_next_outlined)
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.04),
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.sizeOf(context).height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.health_and_safety_sharp,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.02,
                        ),
                        Text(
                          'Privacy Policy',
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Icon(Icons.navigate_next_outlined)
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.04),
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.sizeOf(context).height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.square_list,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.02,
                        ),
                        Text(
                          'Term & Condition',
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Icon(Icons.navigate_next_outlined)
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.04),
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.sizeOf(context).height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.question_circle,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.02,
                        ),
                        Text(
                          'Help',
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Icon(Icons.navigate_next_outlined)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ],
  );
}

Widget _accountSection(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.sizeOf(context).height * 0.01),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.onPrimary),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.04),
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.sizeOf(context).height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.02,
                        ),
                        const Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Icon(Icons.navigate_next_outlined)
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.04),
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.sizeOf(context).height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.delete_outline_outlined,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.02,
                        ),
                        const Text(
                          'Delete Account',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Icon(Icons.navigate_next_outlined)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ],
  );
}
