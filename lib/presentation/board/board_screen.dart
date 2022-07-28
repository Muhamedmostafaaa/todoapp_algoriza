import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_algoriza/businesslogic/cubit/cubit.dart';
import 'package:todoapp_algoriza/businesslogic/cubit/states.dart';
import 'package:todoapp_algoriza/presentation/addtask/addtask_screen.dart';
import 'package:todoapp_algoriza/presentation/board/widgets/taskslist.dart';
import 'package:todoapp_algoriza/presentation/schedule/schedule_screen.dart';
import 'package:todoapp_algoriza/presentation/sharedwidgets/button.dart';

class Boardscreen extends StatelessWidget {
  static const ROUTE_NAME = 'boardscreen';
  TabController? controller;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<Appcubit>(context);

        return DefaultTabController(
          length: 4,
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children:  [
                      Text('Board',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Spacer(),
                      InkWell(onTap: (){
                        Navigator.pushNamed(context, Schedulescreen.ROUTE_NAME);
                      },
                        child: Icon(
                          Icons.calendar_today_rounded,
                          color: Colors.black45,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 22),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                    ),
                    TabBar(onTap:(index){
                     cubit.changetabbarsatet(index);

                    },
                        isScrollable: false,
                        labelPadding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 5),
                        indicatorColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.black,
                        labelStyle: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w500),
                        indicatorSize: TabBarIndicatorSize.label,
                        controller: controller,
                        tabs: [
                          Text('All'),
                          Text('Completed'),
                          Text('Uncompleted'),
                          Text('Favorite'),
                        ]),
                  ],
                ),
                taskslist(list:cubit.getthelisttoshow()),
                Spacer(),
                button(
                  text: 'Add a task',
                  onclick: () {
                    Navigator.pushNamed(context, Addtaskscreen.ROUTE_NAME);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
