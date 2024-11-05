import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final Color color;
  const TaskCard({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.onPrimary),
      width: MediaQuery.sizeOf(context).width * 0.9,
      height: MediaQuery.sizeOf(context).height * 0.15,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            width: MediaQuery.sizeOf(context).width * 0.03,
            height: MediaQuery.sizeOf(context).height * 0.15,
          )
        ],
      ),
    );
  }
}
