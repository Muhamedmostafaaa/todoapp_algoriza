import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_algoriza/businesslogic/cubit/cubit.dart';
import 'package:todoapp_algoriza/businesslogic/cubit/states.dart';

class taskslist extends StatelessWidget {
  List<Map>list;
  taskslist({required this.list});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppStates>(
      listener: (context, state) {},
      builder: (context, states) {
        var cubit = BlocProvider.of<Appcubit>(context);
        return Expanded(flex: 8,
          child:
          ListView.builder(
            itemBuilder: (context, index) {
              return Dismissible(key:Key(list[index]['id'].toString()) ,
                onDismissed: (direction){
                  cubit.deletefromdatabase(list[index]['id']);
                },
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: cubit
                                  .getbordercolor(list[index]['color']),
                              width: 3),
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    Text(
                     list[index]['tittle'],
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    PopupMenuButton(onSelected: (value){
                      print(value);
                      cubit.updatedatabase(value.toString(), list[index]['id']);
                    },
                        itemBuilder: (context) => [
                              PopupMenuItem(child: Text('Complete task'),value:'complete',),
                              PopupMenuItem(child: Text('Add to favorite'),value: 'favorite',),
                              PopupMenuItem(child: Text('Remove task'),value: 'remove'),
                            ])
                  ],
                ),
              );
            },
            itemCount: list.length,
          ),
        );
      },
    );
  }
}
