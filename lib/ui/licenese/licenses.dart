import 'package:flutter/material.dart';

class PackagesPage extends StatelessWidget {
  PackagesPage({Key? key}) : super(key: key);

  // List of packages with their names and links
  final List<Map<String, String>> packages = [
    {'name': 'Flutter', 'link': 'https://flutter.dev'},
    {'name': 'Firebase Auth', 'link': 'https://pub.dev/packages/firebase_auth'},
    {'name': 'Stacked', 'link': 'https://pub.dev/packages/stacked'},
    {'name': 'GoRouter', 'link': 'https://pub.dev/packages/go_router'},
    {
      'name': 'Syncfusion Flutter Calendar',
      'link': 'https://pub.dev/packages/syncfusion_flutter_calendar',
    },
    {'name': 'Intl', 'link': 'https://pub.dev/packages/intl'},
    {'name': 'FL Chart', 'link': 'https://pub.dev/packages/fl_chart'},
    {
      'name': 'Awesome Bottom Bar',
      'link': 'https://pub.dev/packages/awesome_bottom_bar'
    },
    {
      'name': 'Cupertino Icons',
      'link': 'https://pub.dev/packages/cupertino_icons'
    },
    {
      'name': 'Google Sign In',
      'link': 'https://pub.dev/packages/google_sign_in'
    },
    {
      'name': 'Extended Image',
      'link': 'https://pub.dev/packages/extended_image'
    },
    {
      'name': 'Shared Preferences',
      'link': 'https://pub.dev/packages/shared_preferences'
    },
    {'name': 'Firebase Core', 'link': 'https://pub.dev/packages/firebase_core'},
    {
      'name': 'Cloud Firestore',
      'link': 'https://pub.dev/packages/cloud_firestore'
    },
    {'name': 'GetIt', 'link': 'https://pub.dev/packages/get_it'},
    {'name': 'Dartz', 'link': 'https://pub.dev/packages/dartz'},
    {'name': 'Injectable', 'link': 'https://pub.dev/packages/injectable'},
    {'name': 'Phonenumbers', 'link': 'https://pub.dev/packages/phonenumbers'},
    {'name': 'Flagkit', 'link': 'https://pub.dev/packages/flagkit'},
    {'name': 'Flutter Hooks', 'link': 'https://pub.dev/packages/flutter_hooks'},
    {'name': 'Path Provider', 'link': 'https://pub.dev/packages/path_provider'},
    {'name': 'Path', 'link': 'https://pub.dev/packages/path'},
    {'name': 'Uuid', 'link': 'https://pub.dev/packages/uuid'},
    {
      'name': 'Permission Handler',
      'link': 'https://pub.dev/packages/permission_handler'
    },
    {'name': 'Flutter Sound', 'link': 'https://pub.dev/packages/flutter_sound'},
    {
      'name': 'Buttons TabBar',
      'link': 'https://pub.dev/packages/buttons_tabbar'
    },
  ];

  // Function to open the package URL
  // void _launchUrl(String url) async {
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Packages Used'),
      ),
      body: ListView.builder(
        itemCount: packages.length,
        itemBuilder: (context, index) {
          final package = packages[index];
          return ListTile(
            title: Text(package['name']!),
            trailing: IconButton(
              icon: const Icon(Icons.open_in_new),
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }
}
