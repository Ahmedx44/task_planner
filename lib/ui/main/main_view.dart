import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Main'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
