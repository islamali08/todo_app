
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp_mansorf/shared/cubit/sates.dart';

import '../../model/todo_app_model/constant.dart';
import '../../model/todo_app_model/sqlt_model.dart';
import '../../modules/arcivescreen.dart';
import '../../modules/done_screen.dart';
import '../../modules/task_screen.dart';

class appcubit extends Cubit<appstate>{

  static appcubit  get(context)=> BlocProvider.of(context);


  appcubit(): super(intioalstal());

  int cruntindex=0;

bool  isdark=false ;
void changethem(){
  isdark=!isdark ;
  emit(darkstate());
}
  List<Widget> screens=[

    taskscreen(),
    donescreen(),
    donescreen2()

  ];

  List<String> apar=['new task','Done task','Arcived task'];
  List  < Map>  tasks=[] ;
  List  < Map>  tasks2=[] ;
  List  < Map>  tasks3=[] ;


  void chandeundex(index){
    cruntindex=index ;
    emit(Buttomnbchange());
  }

  Database? database;

    void createdatabase  () async{

       openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database,virsen){
          database.execute('CREATE TABLE tasks  (id INTEGER PRIMARY KEY,title TEXT,content TEXT,time TEXT,date TEXT,states TEXT,ischec INTEGER)').
          then((value){
            print('taple created');
          }).catchError((eror){
            print('eror create table${eror.toString()}');
          });
          print('open database');

          database.execute('CREATE TABLE tasks2  (id INTEGER PRIMARY KEY,title TEXT,content TEXT,time TEXT,date TEXT,states TEXT,ischec INTEGER)').
          then((value){
            print('taple created');
          }).catchError((eror){
            print('eror create table${eror.toString()}');
          });
          print('open database');

          database.execute('CREATE TABLE tasks3  (id INTEGER PRIMARY KEY,title TEXT,content TEXT,time TEXT,date TEXT,states TEXT,ischec INTEGER)').
          then((value){
            print('taple created');
          }).catchError((eror){
            print('eror create table${eror.toString()}');
          });
          print('open database');

        },
        onOpen: (database){
          getdatafromdatapase(database);
          getdatafromdatapase2(database);
          getdatafromdatapase3(database);
          print('open database');

        }


      ).then((value) {
        database =value ;
        emit(creatdb());
       });

 }

  insertodatabase (String title ,String conten,String date,String time,int chec) async{

     await  database!.transaction((txn) {
        txn.rawInsert('INSERT INTO tasks (title,content,time,date,states,ischec) VALUES ("$title","$conten","$date","$time","new","$chec")')
            .then((value) {
          print(' $value print sucsesful');
          emit(insertdb());

          getdatafromdatapase(database);

        }).catchError((eror){
          print('eror insert ${eror.toString()}');
        });
        return Future.value(tasks)  ;
      });
 }

  insertodatabase2 (String title ,String conten,String date,String time,int chec) async{

    await  database!.transaction((txn) {
      txn.rawInsert('INSERT INTO tasks2 (title,content,time,date,states,ischec) VALUES ("$title","$conten","$date","$time","new","$chec")')
          .then((value) {
        print(' $value print sucsesful');
        emit(insertdb2());

        getdatafromdatapase2(database);

      }).catchError((eror){
        print('eror insert ${eror.toString()}');
      });
      return Future.value(tasks2)  ;
    });
  }
  insertodatabase3 (String title ,String conten,String date,String time,int chec) async{

    await  database!.transaction((txn) {
      txn.rawInsert('INSERT INTO tasks3 (title,content,time,date,states,ischec) VALUES ("$title","$conten","$date","$time","new","$chec")')
          .then((value) {
        print(' $value print sucsesful');

        getdatafromdatapase3(database);
        emit(insertdb2());


      }).catchError((eror){
        print('eror insert ${eror.toString()}');
      });
      return Future.value(tasks3)  ;
    });
  }



  getdatafromdatapase ( database){

    database.rawQuery('SELECT * FROM tasks').then((value) {
     tasks = value ;
     print(tasks);


     emit(getdb());

   });;





       emit(getdb());


 }
  getdatafromdatapase2 ( database){

    database.rawQuery('SELECT * FROM tasks2').then((value) {
      tasks2 = value ;
      print(tasks2);


      emit(getdb2());

    });;





    emit(getdb2());


  }

  getdatafromdatapase3 ( database){

    database.rawQuery('SELECT * FROM tasks3').then((value) {
      tasks3 = value ;
      print(tasks3);


      emit(getdb2());

    });;





    emit(getdb2());


  }



  updatedatabase (int ischec,int id) async{
    await database!.rawUpdate(
       'UPDATE tasks SET ischec = ? WHERE id = ?',
       ['$ischec', '$id']).then((value) {

         emit(updatedb());

         getdatafromdatapase(database);
         print('done update');
    });

 }
  delet (int id) async{
    await database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {

      emit(deleted());

      getdatafromdatapase(database);
      print('done update');
    });

  }
  delet2 (int id) async{
    await database!.rawDelete('DELETE FROM tasks2 WHERE id = ?', [id]).then((value) {

      emit(deleted());

      getdatafromdatapase2(database);
      print('done update');
    });

  }
  delet3 (int id) async{
    await database!.rawDelete('DELETE FROM tasks3 WHERE id = ?', [id]).then((value) {

      emit(deleted());

      getdatafromdatapase3(database);
      print('done update');
    });

  }



  updatedatabase2 (String state,int id) async{
    await database!.rawUpdate(
        'UPDATE tasks SET states = ? WHERE id = ?',
        ['$state', '$id']).then((value) {

      emit(updatedb());

      getdatafromdatapase(database);
      print('done update');
    });

  }


  IconData? flotbotomicon = Icons.edit;
  bool bottomsheetopen = false;

void changbuttomndstate (bool isshow,IconData icone){
  flotbotomicon= icone ;
  bottomsheetopen =isshow ;
emit(bottomsheets());
}
bool chec =false ;
   checbox (bool? num,index){
chec=num! ;

print(chec);



emit(checboxssf());

  }


 List checb2=[] ;

   checadd(){
     checb2.add(false);
     print('false add');
     print(checb2);
     emit(checboxadd());
   }




}