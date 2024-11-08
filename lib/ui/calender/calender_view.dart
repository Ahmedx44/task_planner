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
        final textColor = Theme.of(context).colorScheme.onBackground;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            title: Text(
              "Calendar",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SfCalendar(
              blackoutDatesTextStyle:
                  TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              dataSource: TaskCalendarDataSource(model.appointments),
              view: CalendarView.month,
              headerStyle: CalendarHeaderStyle(
                  textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.bold),
                  backgroundColor: Theme.of(context).colorScheme.surface),
              initialSelectedDate: DateTime.now(),
              showTodayButton: true,
              initialDisplayDate: model.selectedDate,
              weekNumberStyle: const WeekNumberStyle(
                  textStyle: TextStyle(color: Colors.white)),
              todayTextStyle:
                  TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              viewHeaderStyle: ViewHeaderStyle(
                  dayTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary),
                  dateTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary)),
              appointmentTextStyle: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
              todayHighlightColor: Theme.of(context).colorScheme.secondary,
              cellBorderColor: Colors.transparent,
              monthViewSettings: MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                dayFormat: 'EEE',
                showAgenda: true,
                showTrailingAndLeadingDates: true,
                agendaStyle: AgendaStyle(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  appointmentTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  dateTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  dayTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
              onTap: (calendarTapDetails) {
                if (calendarTapDetails.targetElement ==
                    CalendarElement.appointment) {
                  final task = calendarTapDetails.appointments?.first;
                  model.onTaskTapped(task as TaskModel);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
