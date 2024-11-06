import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app/ui/new_task/newTask_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_app/utils/category_enum.dart';

class NewtaskView extends HookWidget {
  const NewtaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final startTime = useState<DateTime>(DateTime.now());
    final endTime =
        useState<DateTime>(DateTime.now().add(const Duration(days: 1)));
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final additionalInfoController = useTextEditingController();
    final selectedCategory = useState<Category?>(null);
    final selectedPriority = useState<String?>(null);
    final selectedColor = useState<Color?>(null);

    return ViewModelBuilder<NewtaskViewModel>.reactive(
      viewModelBuilder: () => NewtaskViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
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
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),

                    // Title
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).colorScheme.onPrimary,
                        filled: true,
                        hintText: 'Title',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),

                    // Description
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.sizeOf(context).height * 0.01,
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 17,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                                hintText: 'Text Description',
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 0.5,
                            indent: MediaQuery.sizeOf(context).width * 0.05,
                            endIndent: MediaQuery.sizeOf(context).width * 0.05,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.sizeOf(context).height * 0.01,
                            ),
                            child: TextField(
                              maxLines: 3,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintStyle: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                                hintText: 'Provide additional details',
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.02),
                        ],
                      ),
                    ),

                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),

                    // Start and End Time
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    FirebaseAuth.instance.signOut();
                                  },
                                  child: Text(
                                    'Starts',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => viewModel.showDatePicker(
                                          context, startTime),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface),
                                        child: Text(
                                          DateFormat("d MMM y")
                                              .format(startTime.value),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 0.5,
                            indent: MediaQuery.sizeOf(context).width * 0.05,
                            endIndent: MediaQuery.sizeOf(context).width * 0.05,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ends',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => viewModel.showDatePicker(
                                          context, endTime),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface),
                                        child: Text(
                                          DateFormat("d MMM y")
                                              .format(endTime.value),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Category
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.02,
                    ),
                    Text(
                      'Category',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),

                    SizedBox(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: Category.values.map((cat) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                selectedCategory.value = cat;
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: selectedCategory.value == cat
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.onPrimary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  cat.name,
                                  style: TextStyle(
                                    color: selectedCategory.value == cat
                                        ? Colors.white
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    //Priority
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.02,
                    ),
                    Text(
                      'Priority Level',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: viewModel.priorities.entries.map((entry) {
                          final priority = entry.key;
                          final borderColor = entry.value;

                          return GestureDetector(
                            onTap: () {
                              selectedPriority.value = priority;
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.01),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 10),
                              decoration: BoxDecoration(
                                color: selectedPriority.value == priority
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: selectedPriority.value == priority
                                      ? Theme.of(context).colorScheme.primary
                                      : borderColor, // Border color for unselected
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                priority,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: selectedPriority.value == priority
                                      ? Colors.white
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    //Colors
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.02,
                    ),
                    Text(
                      'Priority Level',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.05,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: viewModel.colors.entries.map((entry) {
                          final color = entry.value;

                          return GestureDetector(
                            onTap: () {
                              selectedColor.value = color;
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.sizeOf(context).width * 0.01,
                              ),
                              height: MediaQuery.sizeOf(context).height * 0.2,
                              width: MediaQuery.sizeOf(context).width * 0.1,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: selectedColor.value == color
                                      ? Colors.black
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    //Create Task Button
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.08,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.7,
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.sizeOf(context).height * 0.02,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).colorScheme.primary),
                          child: Center(
                            child: Text(
                              'Create Task',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
