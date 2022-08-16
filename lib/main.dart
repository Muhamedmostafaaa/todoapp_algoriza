import 'package:bloc/bloc.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_algoriza/businesslogic/cubit/cubit.dart';
import 'package:todoapp_algoriza/businesslogic/cubit/states.dart';
import 'package:todoapp_algoriza/presentation/addtask/addtask_screen.dart';
import 'package:todoapp_algoriza/presentation/board/board_screen.dart';
import 'package:flutter/services.dart';
import 'package:todoapp_algoriza/presentation/schedule/schedule_screen.dart';

import 'businesslogic/bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
        () {
      runApp(myapp());

    },
    blocObserver: MyBlocObserver(),
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
}

class myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<Appcubit>(create:(context)=> Appcubit()..createdatabase(),
      child: BlocConsumer<Appcubit,AppStates>(listener: (context,states){},
        builder: (context,states){
        var cubit=BlocProvider.of<Appcubit>(context);

        return  MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(color: Colors.transparent),
          ),
          routes: {
            Boardscreen.ROUTE_NAME: (context) => Boardscreen(),
            Addtaskscreen.ROUTE_NAME: (context)=> Addtaskscreen(),
            Schedulescreen.ROUTE_NAME:(context)=> Schedulescreen()
          },
          initialRoute: Boardscreen.ROUTE_NAME,
        );
        },

      ),
    );
  }
}
