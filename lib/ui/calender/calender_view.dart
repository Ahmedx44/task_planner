import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todo_app/model/task_model.dart';

import 'package:todo_app/ui/calender/calender_view_model.dart';
import 'package:todo_app/ui/calender/data%20source/calender_data_source.dart';

class CalendarVieww extends StatelessWidget {
  const CalendarVieww({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CalendarViewModel>.reactive(
      viewModelBuilder: () => CalendarViewModel(),
      onViewModelReady: (model) => model.loadUserTasks(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            title: const Text("Calendar"),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const SizedBox(height: 16),
              // Calendar View (Displays tasks)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SfCalendar(
                    dataSource: TaskCalendarDataSource(model.appointments),
                    view: CalendarView.week,
                    initialSelectedDate: DateTime.now(),
                    initialDisplayDate: model.selectedDate,
                    showDatePickerButton: true,
                    appointmentTextStyle:
                        Theme.of(context).textTheme.bodyLarge!,
                    todayHighlightColor: Theme.of(context).colorScheme.primary,
                    headerStyle: CalendarHeaderStyle(
                      textAlign: TextAlign.center,
                      textStyle: Theme.of(context).textTheme.titleMedium!,
                    ),
                    timeSlotViewSettings: TimeSlotViewSettings(
                      timeTextStyle: Theme.of(context).textTheme.titleSmall!,
                    ),
                    onTap: (calendarTapDetails) {
                      if (calendarTapDetails.targetElement ==
                          CalendarElement.appointment) {
                        final task = calendarTapDetails.appointments?.first;
                        model.onTaskTapped(
                            task as TaskModel); // Ensure it's a TaskModel
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getWeekdayAbbreviation(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return "Mon";
      case DateTime.tuesday:
        return "Tue";
      case DateTime.wednesday:
        return "Wed";
      case DateTime.thursday:
        return "Thu";
      case DateTime.friday:
        return "Fri";
      case DateTime.saturday:
        return "Sat";
      case DateTime.sunday:
        return "Sun";
      default:
        return "";
    }
  }
}
