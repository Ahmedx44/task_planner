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
    return ViewModelBuilder.nonReactive(
      viewModelBuilder: () => MainViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
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
                    _taskCardDisplayer(context),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.03,
                    ),

                    //Current Inprogress Tasks
                    _inProgressTasks(context),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),

                    //Completed Tasks
                    _completedTask(context),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),

                    //Missed Tasks
                    _lateTasks(context)
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
        );
      },
    );
  }

  _taskCardDisplayer(context) {
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
                Text(
                  '2/7 tasks',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onPrimary),
                )
              ],
            ),
          ),
          ExtendedImage.asset(
              height: MediaQuery.sizeOf(context).height * 0.2, AppImage.task)
        ],
      ),
    );
  }

  _inProgressTasks(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      onViewModelReady: (viewModel) => viewModel.getInCompeleteTasks(context),
      builder: (context, viewModel, child) {
        if (viewModel.isBusy) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.hasError) {
          return Center(child: Text('Error: ${viewModel.error}'));
        }

        List<TaskModel> tasks = viewModel.inCompleteTasks;

        if (tasks.isEmpty) {
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
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskCard(task: task);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _completedTask(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      onViewModelReady: (viewModel) => viewModel.getCompeleteTasks(context),
      builder: (context, viewModel, child) {
        if (viewModel.isBusy) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.hasError) {
          return Center(child: Text('Error: ${viewModel.error}'));
        }

        List<TaskModel> tasks = viewModel.completeTasks;

        if (tasks.isEmpty) {
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
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return MiniCard(task: task);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _lateTasks(context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      onViewModelReady: (viewModel) => viewModel.getLateTasks(context),
      builder: (context, viewModel, child) {
        if (viewModel.isBusy) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.hasError) {
          return Center(child: Text('Error: ${viewModel.error}'));
        }

        List<TaskModel> tasks = viewModel.completeTasks;

        if (tasks.isEmpty) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.16,
              child: const Center(child: Text('No Late tasks.')));
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
                    'Completed',
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
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return MiniCard(task: task);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Expanded(
//               child: DefaultTabController(
//                 length: Category.values.length,
//                 child: Column(
//                   children: [
//                     ButtonsTabBar(
//                       radius: 20,
//                       borderWidth: 0.1,
//                       buttonMargin: EdgeInsets.symmetric(
//                           horizontal: MediaQuery.sizeOf(context).width * 0.05),
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 15,
//                       ),
//                       backgroundColor: Theme.of(context).colorScheme.primary,
//                       unselectedBackgroundColor:
//                           Theme.of(context).colorScheme.onPrimary,
//                       unselectedLabelStyle: TextStyle(
//                           color: Theme.of(context).colorScheme.onSecondary),
//                       labelStyle: TextStyle(
//                           color: Theme.of(context).colorScheme.onPrimary),
//                       tabs: const [
//                         Tab(text: 'All Tasks'),
//                         Tab(text: 'Personal'),
//                         Tab(text: 'Work'),
//                         Tab(text: 'Study'),
//                       ],
//                     ),
//                     SizedBox(
//                       height: MediaQuery.sizeOf(context).height * 0.02,
//                     ),
//                     // TabBarView to display content for each tab
//                     const Expanded(
//                       child: TabBarView(
//                         children: [
//                           Center(child: Text('All Tasks Content')),
//                           Center(child: Text('Personal Tasks Content')),
//                           Center(child: Text('Work Tasks Content')),
//                           Center(child: Text('Study Tasks Content')),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
