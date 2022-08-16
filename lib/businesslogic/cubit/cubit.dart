import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp_algoriza/businesslogic/cubit/states.dart';
import 'package:todoapp_algoriza/presentation/schedule/schedule_screen.dart';
import 'package:todoapp_algoriza/services/local_notification.dart';

class Appcubit extends Cubit<AppStates> {
  Appcubit() : super(AppInitialState());
  late Database database;
  String selectedcolor='red';
  List<Map>alltasks=[];
  List<Map>completedtasks=[];
  List<Map>uncompletedtasks=[];
  List<Map>favoritetasks=[];
  int currentindex=0;
  String selectedday=DateFormat('dd-MM-yyy').format(DateTime.now()).toString();
  List<Map>selectedaytodos=[];
  late BuildContext context;
 late final LocalNotificationService service;


var today=DateFormat('EEEE').format(DateTime.now());

void init(){
  service=LocalNotificationService();
  service.intialize();
  ListentoNotification();
}
  void createdatabase() async {

  init();
    database = await openDatabase('todo.db', version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, tittle TEXT, date TEXT, starttime TEXT, endtime TEXT, status TEXT, remind TEXT, color TEXT)')
          .then((value) {
        print('data created');
      }).catchError((error) {
        print(error.toString());
      });
    }, onOpen: (database) {
      print('database opened');
      getdatafromdatabase( database);
    });

  }

  void inserttodatabase(
      {required String tittle,
      required String date,
      required String starttime,
      required String endtime,
      required String remind,
      required String color})  {
    database.transaction((txn) async {
       txn.rawInsert(
          'INSERT INTO tasks(tittle, date, starttime, endtime, status, remind, color) VALUES("$tittle", "$date", "$starttime", "$endtime", "new", "$remind", "$color")').
      then((value){
            print('$value inserted succsuflly');
            getdatafromdatabase(database);

      }).catchError((error){
        print('when inserting an $error');
       });
    });
  }
  void oncolorclick(String color){
    selectedcolor=color;
    print(selectedcolor);

  }
  void getdatafromdatabase(database)async{
    alltasks=[];
    completedtasks=[];
    uncompletedtasks=[];
    favoritetasks=[];
    selectedaytodos=[];
      database.rawQuery('SELECT * FROM tasks').then((value){
        alltasks=value;

        value.forEach((element) {
          if(element['date']==selectedday){
            selectedaytodos.add(element);
            print('heloooo')
            ;}

          if(element['status']=='complete'){
            completedtasks.add(element);

          }else if(element['status']=='favorite'){
            favoritetasks.add(element);
          }
          else {
            uncompletedtasks.add(element);
          }
          print(selectedaytodos.length);
        });
      emit(AppGetdata());
    });
  }

  Color getbordercolor(String color){
    if(color=='red'){
      return Colors.red;
    }else if(color=='yellow'){
      return Colors.yellow;
    }else if(color=='grey'){
      return Colors.grey;
    }else{
      return Colors.blueAccent;
    }
  }
  void updatedatabase(String status ,int id){
     database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ["$status",id]).then((value){
          print('$value updated succefully');
          emit(AppupdateState());
          getdatafromdatabase(database);


     }).catchError((error){
       print('the error is $error');
     });
  }
  List<Map> getthelisttoshow(){
    print('lets go');
    if(currentindex==0){
      return alltasks;
    }else if(currentindex==1){
      return completedtasks;
    }else if(currentindex==2){
      return uncompletedtasks;
    }else {
      return favoritetasks;
    }
  }
  void changetabbarsatet(index){
    currentindex=index;
    emit(ApptabbarState());
  }
  void deletefromdatabase(int id){
    database
        ?.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value){

      emit(Appdeletestate());
      getdatafromdatabase(database);
    });

  }

  void ListentoNotification(){
  service.onNotificationclick.stream.listen((event) {onNotificationListener;});
  }
  void onNotificationListener(String? payload,){
  if(payload != null && payload.isNotEmpty){
    Navigator.pushNamed(context, Schedulescreen.ROUTE_NAME);
  }

  }
}


