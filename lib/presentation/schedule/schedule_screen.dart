import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:date_picker_timeline/extra/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:todoapp_algoriza/businesslogic/cubit/cubit.dart';
import 'package:todoapp_algoriza/businesslogic/cubit/states.dart';
import 'package:todoapp_algoriza/presentation/schedule/singletask.dart';

class Schedulescreen extends StatefulWidget {
  static const String ROUTE_NAME = 'schedule screen';

  @override
  State<Schedulescreen> createState() => _SchedulescreenState();
}

class _SchedulescreenState extends State<Schedulescreen> {
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
                            cubit.selectedday=DateFormat('dd-MM-yyy').format(DateTime.now()).toString();
                            cubit.getdatafromdatabase(cubit.database);
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

                  DatePicker(
                    DateTime.now(),
                    initialSelectedDate:DateTime.now(),
                    selectionColor: Colors.green,
                    selectedTextColor: Colors.white,
                    monthTextStyle: TextStyle(inherit: false),
                    dateTextStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    onDateChange: (date) {
                      cubit.selectedday=DateFormat('dd-MM-yyy').format(date).toString();

                         cubit.getdatafromdatabase(cubit.database);

                         print(cubit.selectedday);
                    },
                  ),


                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          '${cubit.today}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Spacer(),
                        Text(
                          '${DateFormat.yMMMMd().format(DateTime.now())}',
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return SingleTask(
                            item: cubit.selectedaytodos[index],
                            color: cubit.getbordercolor(
                                cubit.selectedaytodos[index]['color']));
                      },
                      itemCount: cubit.selectedaytodos.length,
                    ),
                  )
                ]),
          );
        });
  }
}
