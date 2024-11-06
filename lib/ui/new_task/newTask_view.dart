import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/ui/new_task/newTask_view_model.dart';

class NewtaskView extends StatelessWidget {
  const NewtaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => NewtaskViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            leading: Icon(
              Icons.arrow_back_ios_outlined,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            title: Text(
              'Create New Task',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Theme.of(context).colorScheme.onSecondary),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.1),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                  TextField(
                    decoration: InputDecoration(
                        fillColor: Theme.of(context).colorScheme.onPrimary,
                        filled: true,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none)),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
