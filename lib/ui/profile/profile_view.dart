import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
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
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
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
                            horizontal:
                                MediaQuery.sizeOf(context).width * 0.04),
                        margin: EdgeInsets.symmetric(
                            vertical: MediaQuery.sizeOf(context).height * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(CupertinoIcons.person,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                SizedBox(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.02,
                                ),
                                Text(
                                  'Personal Detail',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
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
                            horizontal:
                                MediaQuery.sizeOf(context).width * 0.04),
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
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.02,
                                ),
                                Text(
                                  'Change Password',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
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
              )
            ],
          ),
        ));
  }
}
