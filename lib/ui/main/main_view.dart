import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/assets/app_image.dart';
import 'package:todo_app/ui/main/widget/mini_card.dart';
import 'package:todo_app/ui/main/widget/task_card.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
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
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontSize: 22),
                          ),
                          Text(
                            'Ahmed',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.time,
                            color: Theme.of(context).colorScheme.onSecondary,
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

                //All Tasks
                _allTask(context),
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

  _inProgressTasks(context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.05),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Inprogress',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondary),
              ),
              const Row(
                children: [Text('6'), Icon(Icons.navigate_next_rounded)],
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.35,
            child: ListView(
              children: const [
                TaskCard(
                  color: Colors.red,
                ),
                TaskCard(
                  color: Colors.blue,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _allTask(context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.05),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondary),
              ),
              const Row(
                children: [Text('10'), Icon(Icons.navigate_next_rounded)],
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.16,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                MiniCard(),
                MiniCard(),
                MiniCard(),
              ],
            ),
          )
        ],
      ),
    );
  }

  _completedTask(context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.05),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Compeleted',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondary),
              ),
              const Row(
                children: [Text('10'), Icon(Icons.navigate_next_rounded)],
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.16,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                MiniCard(),
                MiniCard(),
                MiniCard(),
              ],
            ),
          )
        ],
      ),
    );
  }

  _lateTasks(context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.05),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Late Task',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Row(
                children: [Text('6'), Icon(Icons.navigate_next_rounded)],
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.16,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                MiniCard(),
                MiniCard(),
                MiniCard(),
              ],
            ),
          )
        ],
      ),
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
