import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todoapp_algoriza/businesslogic/cubit/cubit.dart';
import 'package:todoapp_algoriza/businesslogic/cubit/states.dart';

class Schedulescreen extends StatelessWidget {
  static const String ROUTE_NAME = 'schedule screen';
  var list = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<Appcubit>(context);

          return Scaffold(
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios_sharp,
                            size: 18,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Schedule',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TableCalendar(
                    weekendDays: [DateTime.friday, DateTime.saturday],
                    calendarFormat: CalendarFormat.week,
                    headerVisible: false,
                    calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(color: Colors.green),
                      isTodayHighlighted: true,
                      todayDecoration: BoxDecoration(color: Colors.green),
                    ),
                    firstDay: DateTime.now().subtract(Duration(days: 300)),
                    lastDay: DateTime(2023),
                    focusedDay: DateTime.now(),
                    selectedDayPredicate: (day) {
                      return isSameDay(cubit.selectedday, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      cubit.changedaysstate(selectedDay, focusedDay);
                      cubit.onselectedda=  cubit.alltasks.where((element) =>isSameDay(element['day'], selectedDay)).toList();
                      // update `_focusedDay` here as well
                    },
                    onPageChanged: (focusedDay) {
                      cubit.focusedday = focusedDay;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return
                          Container(
                          height: 100,
                          margin:
                              EdgeInsets.only(left: 15, right: 15, bottom: 15),
                          decoration: BoxDecoration(
                              color: cubit.getbordercolor(
                                  cubit.alltasks[index]['color']),
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cubit.alltasks[index]['starttime'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(cubit.alltasks[index]['tittle'],
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: cubit.alltasks.length,
                    ),
                  )
                ]),
          );
        });
  }
}
