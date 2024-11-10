import 'package:extended_image/extended_image.dart';
import 'package:fl_chart/fl_chart.dart';
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
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      onViewModelReady: (viewModel) => viewModel.initializeData(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                await viewModel.initializeData();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    _buildHeader(context),
                    const SizedBox(height: 16),
                    _buildTaskSummaryCard(context, viewModel),
                    const SizedBox(height: 24),
                    _buildTaskSection(
                      context: context,
                      viewModel: viewModel,
                      title: 'In Progress',
                      tasks: viewModel.incompleteTasks,
                      emptyMessage: 'No tasks in progress.',
                      isVerticalList: true,
                    ),
                    const SizedBox(height: 24),
                    _buildTaskSection(
                      context: context,
                      viewModel: viewModel,
                      title: 'Completed',
                      tasks: viewModel.completeTasks,
                      emptyMessage: 'No completed tasks.',
                      isVerticalList: false,
                    ),
                    const SizedBox(height: 24),
                    _buildTaskSection(
                      context: context,
                      viewModel: viewModel,
                      title: 'Late',
                      tasks: viewModel.lateTasks,
                      emptyMessage: 'No late tasks.',
                      isVerticalList: false,
                      titleColor: Colors.red,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => viewModel.showCreateNewTask(context),
            shape: const CircleBorder(),
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(CupertinoIcons.add, color: Colors.white),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
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
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 22,
                ),
              ),
              Text(
                'Ahmed',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskSummaryCard(BuildContext context, MainViewModel viewModel) {
    final totalTasks = viewModel.allTasks.length;

    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.17,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.pink,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tasks',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: _buildPieChart(viewModel, totalTasks),
                ),
              ],
            ),
          ),
          ExtendedImage.asset(
            AppImage.task,
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.4,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(MainViewModel viewModel, int totalTasks) {
    return PieChart(
      PieChartData(
        sections: [
          _buildPieChartSection(
            value: viewModel.completeTasks.length.toDouble(),
            title: 'Complete\n${viewModel.completeTasks.length}',
            color: Colors.green,
          ),
          _buildPieChartSection(
            value: viewModel.incompleteTasks.length.toDouble(),
            title: 'Incomplete\n${viewModel.incompleteTasks.length}',
            color: Colors.blue,
          ),
          _buildPieChartSection(
            value: viewModel.lateTasks.length.toDouble(),
            title: 'Late\n${viewModel.lateTasks.length}',
            color: Colors.orange,
          ),
        ],
        sectionsSpace: 4,
        centerSpaceRadius: 20,
        borderData: FlBorderData(show: false),
      ),
    );
  }

  PieChartSectionData _buildPieChartSection({
    required double value,
    required String title,
    required Color color,
  }) {
    return PieChartSectionData(
      value: value,
      color: color,
      radius: 20,
      title: title,
      titleStyle: const TextStyle(
        fontSize: 7,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildTaskSection({
    required BuildContext context,
    required MainViewModel viewModel,
    required String title,
    required List<TaskModel> tasks,
    required String emptyMessage,
    required bool isVerticalList,
    Color? titleColor,
  }) {
    if (tasks.isEmpty) {
      return _buildEmptyTaskSection(
        context: context,
        title: title,
        message: emptyMessage,
        titleColor: titleColor,
      );
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
                title,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color:
                      titleColor ?? Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: isVerticalList
                ? MediaQuery.of(context).size.height * 0.33
                : MediaQuery.of(context).size.height * 0.15,
            child: ListView.builder(
              scrollDirection: isVerticalList ? Axis.vertical : Axis.horizontal,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return isVerticalList
                    ? GestureDetector(
                        onTap: () => viewModel.navigateToDetail(context, task),
                        child: TaskCard(task: task),
                      )
                    : MiniCard(task: task);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyTaskSection({
    required BuildContext context,
    required String title,
    required String message,
    Color? titleColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: titleColor ?? Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          const SizedBox(height: 80),
          Center(child: Text(message)),
        ],
      ),
    );
  }
}
