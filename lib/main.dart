import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_mansorf/shared/cubit/cubit.dart';
import 'package:todoapp_mansorf/shared/cubit/observer.dart';
import 'package:todoapp_mansorf/shared/cubit/sates.dart';

import 'layout/home_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp( myapp());
}

class myapp extends StatelessWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(



      create: (BuildContext context) =>appcubit(),

      child: BlocConsumer<appcubit,appstate>(

        listener: (BuildContext context, Object? state) {  },

        builder: (BuildContext context, state) {

          return  MaterialApp(
            theme: ThemeData(
brightness: Brightness.light
            ),
            darkTheme: ThemeData(
brightness: Brightness.dark
            ),
            themeMode:appcubit.get(context).isdark? ThemeMode.dark:ThemeMode.light,

            debugShowCheckedModeBanner: false,
            home: homescreen(),
          );
        },

      ),
    );
  }
}
