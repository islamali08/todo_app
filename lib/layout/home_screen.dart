import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_mansorf/modules/static.dart';
import 'package:todoapp_mansorf/modules/task_screen.dart';
import 'package:todoapp_mansorf/shared/cubit/sates.dart';

import '../modules/done_screen.dart';
import '../shared/cubit/cubit.dart';


class homescreen extends StatelessWidget {

  // void ontap(int index){
  //   setState(() {
  //     cruntindex=index;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(


      create: (BuildContext context) =>appcubit()..createdatabase(),
      child: BlocConsumer<appcubit,appstate>(
        listener: (context,state){},
        builder: (context,state){
          appcubit cubit =appcubit.get(context) ;

          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.apar[cubit.cruntindex]),
            ),
            body: cubit.screens[cubit.cruntindex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'Task'

                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline),
                    label: 'Done'

                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: 'Archive'

                ),

              ],
              currentIndex:cubit.cruntindex ,
               onTap: cubit.chandeundex,
              selectedItemColor: Colors.blue,
            ),
          );
        },


      ),
    );
  }
}


