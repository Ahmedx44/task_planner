import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/assets/app_image.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/ui/main/main_view_model.dart';
import 'package:todo_app/ui/main/widget/mini_card.dart';
import 'package:todo_app/ui/main/widget/task_card.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MainViewModel(),
      onViewModelReady: (viewModel) => viewModel.initializeData(),
      builder: (context, viewModel, child) {
        return RefreshIndicator(
          onRefresh: viewModel.refreshContent,
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Welcome, ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                      fontSize: 22),
                                ),
                                Text(
                                  'Ahmed',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary),
                                )
                              ],
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  CupertinoIcons.time,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ))
                          ],
                        ),
                      ),

                      //Task current
                      _taskCardDisplayer(context, viewModel),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.03,
                      ),

                      //Current Inprogress Tasks
                      _inProgressTasks(context, viewModel),
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.03),

                      //Completed Tasks
                      _completedTask(context, viewModel),
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.03),

                      //Missed Tasks
                      _lateTasks(context, viewModel)
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                viewModel.showCreateNewTask(context);
              },
              shape: const CircleBorder(),
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(
                CupertinoIcons.add,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  _taskCardDisplayer(context, MainViewModel viewModel) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.95,
      height: MediaQuery.sizeOf(context).height * 0.12,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.pink),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Today\'s Task',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                Text('1${viewModel.allTasks.length} Tasks')
              ],
            ),
          ),
          ExtendedImage.asset(
              height: MediaQuery.sizeOf(context).height * 0.2, AppImage.task)
        ],
      ),
    );
  }

  _inProgressTasks(BuildContext context, MainViewModel viewModel) {
    if (viewModel.inCompleteTasks.isEmpty) {
      return Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
          ),
          height: MediaQuery.of(context).size.height * 0.35,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'In Progress',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.1,
              ),
              const Center(child: Text('No tasks in progress.')),
            ],
          ));
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'In Progress',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              Row(
                children: [
                  Text('${viewModel.inCompleteTasks.length}'),
                  const Icon(Icons.navigate_next_rounded),
                ],
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.33,
            child: ListView.builder(
              itemCount: viewModel.inCompleteTasks.length,
              itemBuilder: (context, index) {
                final task = viewModel.inCompleteTasks[index];
                return TaskCard(task: task);
              },
            ),
          ),
        ],
      ),
    );
  }

  _completedTask(BuildContext context, MainViewModel viewModel) {
    if (viewModel.completeTasks.isEmpty) {
      return Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
          ),
          height: MediaQuery.of(context).size.height * 0.35,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.022,
              ),
              Text(
                'Compeleted',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.1,
              ),
              const Center(child: Text('No tasks in progress.')),
            ],
          ));
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Compeleted',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              Row(
                children: [
                  Text('${viewModel.completeTasks.length}'),
                  const Icon(Icons.navigate_next_rounded),
                ],
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: viewModel.completeTasks.length,
              itemBuilder: (context, index) {
                final task = viewModel.completeTasks[index];
                return MiniCard(task: task);
              },
            ),
          ),
        ],
      ),
    );
  }

  _lateTasks(context, MainViewModel viewModel) {
    if (viewModel.lateTasks.isEmpty) {
      return Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
          ),
          height: MediaQuery.of(context).size.height * 0.35,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.022,
              ),
              Text(
                'Late',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.1,
              ),
              const Center(child: Text('No late Task.')),
            ],
          ));
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Late ',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              Row(
                children: [
                  Text('${viewModel.lateTasks.length}'),
                  const Icon(Icons.navigate_next_rounded),
                ],
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: viewModel.lateTasks.length,
              itemBuilder: (context, index) {
                final task = viewModel.lateTasks[index];
                return MiniCard(task: task);
              },
            ),
          ),
        ],
      ),
    );
  }
}
