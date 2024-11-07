import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/assets/app_image.dart';

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
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.sizeOf(context).height * 0.03,
              horizontal: MediaQuery.sizeOf(context).width * 0.05),
          color: Theme.of(context).colorScheme.surface,
          child: Column(
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
                      const Text(
                        'Ahmed Gemechu',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'AhmedGemechu14@gmail.com',
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
