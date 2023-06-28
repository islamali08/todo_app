import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:readmore/readmore.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp_mansorf/model/todo_app_model/database_helper.dart';
import 'package:todoapp_mansorf/modules/done_screen.dart';

import '../model/todo_app_model/sqlt_model.dart';
import 'package:intl/intl.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/sates.dart';
import 'static.dart';

class taskscreen extends StatefulWidget {
  @override
  State<taskscreen> createState() => _taskscreenState();
}

class _taskscreenState extends State<taskscreen> {
  Database? database;

  TextEditingController title = TextEditingController();

  TextEditingController detal = TextEditingController();

  TextEditingController time = TextEditingController();

  TextEditingController date = TextEditingController();

  late List  cd ;

  double sizee = 0.0;
  List j = ['a', 's', 'd', 'f'];

  Future<List<taskmodel>> getData() async {
    return databasehelper.instance.readTasks();
  }

  Future<List<taskmodel>> getData2() async {
    return databasehelper.instance.readTasks2();
  }

  var hour;

  var minut;

  DateTime selectedDate = DateTime.now();

  var scafoldkey = GlobalKey<ScaffoldState>();

  var formvalid = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appcubit, appstate>(
      listener: (context, state) {},
      builder: (context, state) {
        appcubit cubit = appcubit.get(context);
        var task = appcubit.get(context).tasks;

        return Scaffold(
          key: scafoldkey,
          floatingActionButton: FloatingActionButton(
            onPressed: () {

              if (cubit.bottomsheetopen) {
                if (formvalid.currentState!.validate()) {
                  cubit.insertodatabase(
                      title.text, detal.text, date.text, time.text, 0);
                         cubit.checadd();
                         cd =cubit.checb2 ;
                  // databasehelper.instance
                  //     .createTask(
                  //   taskmodel(
                  //     time: time.text,
                  //     title: title.text,
                  //     detal: detal.text,
                  //     date: date.text,
                  //   ),
                  // )
                  //     .whenComplete(() {
                  //   getData();
                  // });

                  Navigator.pop(context);

                  cubit.flotbotomicon = Icons.edit;

                  cubit.bottomsheetopen = false;
                }
              } else {
                scafoldkey.currentState
                    ?.showBottomSheet(
                      (context) => SingleChildScrollView(
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: formvalid,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'title is empty';
                                  }
                                },
                                controller: title,
                                decoration: InputDecoration(
                                    hintText: 'Task title',
                                    prefixIcon: Icon(Icons.title),
                                    enabledBorder: OutlineInputBorder()),
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'contat is empty';
                                  }
                                },
                                controller: detal,
                                decoration: InputDecoration(
                                    hintText: 'Task content',
                                    prefixIcon: Icon(Icons.title),
                                    enabledBorder: OutlineInputBorder()),
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                validator: (String? valu) {
                                  if (valu!.isEmpty) {
                                    return 'date is empty';
                                  }
                                },
                                controller: date,
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                  ).then((value) {
                                    date.text =
                                        DateFormat.yMMMd().format(value!);
                                  });
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.calendar_month,
                                      color: Colors.black,
                                    ),
                                    hintText: date.text.isNotEmpty
                                        ? date.text
                                        : 'task date',
                                    enabledBorder: OutlineInputBorder()),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'time is empty';
                                  }
                                },
                                controller: time,
                                onTap: () async {
                                  showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now())
                                      .then((value) {
                                    time.text =
                                        value!.format(context).toString();
                                    print(time.text);
                                  });
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.schedule,
                                    color: Colors.black,
                                  ),
                                  enabledBorder: OutlineInputBorder(),
                                  hintText: time.text.isNotEmpty
                                      ? time.text
                                      : 'Task time',
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    )
                    .closed
                    .then((value) {
                  cubit.changbuttomndstate(false, Icons.edit);
                });
                cubit.changbuttomndstate(true, Icons.add);
              }
            },
            child: Icon(cubit.flotbotomicon),
          ),
          body: showTasks(task),
        );
      },
    );
  }

  DateTime? formatter;

  var mo;

  Widget showTasks(List<Map> data) {
    return MasonryGridView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
     var cub=   appcubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(5),
          child: (index % 2 == 0)
              ? InkWell(
            onLongPress: (){
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                title: const Text('more'),
                content:  SizedBox(
                  height:100 ,
                  child: Column(
                    children: [
                        Row(
                          children: [
                            Text('Archive'),
                            Spacer(),
                            IconButton(onPressed: (){
                             appcubit.get(context).changethem();

                              cub.insertodatabase3(data[index]['title'],  data[index]['content'], data[index]['time'],data[index]['date'],  0);
                              cub.delet(data[index]['id']);
                              Navigator.pop(context);

                            }, icon: Icon(Icons.archive_outlined))
                          ],
                        ),
                      Row(
                        children: [
                          Text('Delet'),
                          Spacer(),

                          IconButton(onPressed: (){

                            cub.delet(data[index]['id']);
                            Navigator.pop(context);

                          }, icon: Icon(Icons.delete))
                        ],
                      ),

                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
              );
            },
                child: Container(
                    height: 190,
                    width: 90,
                    color: Colors.blue[200],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${data[index]['time']}',
                            style: TextStyle(color: Colors.white70),
                          ),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                child: Text(
                                  '${data[index]['title']}',
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                    decoration: data[index]['ischec']==1? TextDecoration.lineThrough:TextDecoration.none



                                  ),
                                ),
                              ),
                              Spacer(),
                              Checkbox(
                                value: data[index]['ischec']==0?false:true ,
                                onChanged: (bool? value) {
                                  if(data[index]['ischec']==0){
                                    appcubit.get(context).updatedatabase(1, data[index]['id']);

                                               appcubit.get(context).insertodatabase2(data[index]['title'],  data[index]['content'], data[index]['time'],data[index]['date'],  0);
                                    appcubit.get(context).delet(data[index]['id']);
                                  }else{
                                    appcubit.get(context).updatedatabase(0, data[index]['id']);

                                  }

                                },
                              ),
                            ],
                          ),
                          Container(
                            height: 70,
                            child: SingleChildScrollView(
                              child: ReadMoreText(

                                data[index]['content'],
                                trimLength: 150,
                                trimLines: 2,
                                textAlign: TextAlign.left,
                                colorClickableText: Colors.pink,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'more',
                                trimExpandedText: '\nless',
                                lessStyle: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                moreStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Spacer(),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                '${data[index]['date']}',
                                style: TextStyle(color: Colors.white70),
                              ))
                        ],
                      ),
                    ),
                  ),
              )
              : InkWell(
            onLongPress: (){




              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('more'),
                  content:  SizedBox(
                    height:100 ,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Archive'),
                            Spacer(),
                            IconButton(onPressed: (){

                              cub.insertodatabase3(data[index]['title'],  data[index]['content'], data[index]['time'],data[index]['date'],  0);
                              cub.delet(data[index]['id']);
 
                              Navigator.pop(context);

                            }, icon: Icon(Icons.archive_outlined))
                          ],
                        ),
                        Row(
                          children: [
                            Text('Delet'),
                            Spacer(),

                            IconButton(onPressed: (){

                              cub.delet(data[index]['id']);
                              Navigator.pop(context);
                            }, icon: Icon(Icons.delete))
                          ],
                        ),

                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );


            },
                child: Container(
                    height: 160,
                    width: 80,
                    color: Colors.orange[300],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${data[index]['time']}',
                            style: TextStyle(color: Colors.white70,

                            ),
                       ),
                          Row(
                            children: [
                              Text(
                                '${data[index]['title']} ',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                decoration: data[index]['ischec']==1? TextDecoration.lineThrough:TextDecoration.none
                                ),
                              ),
                              Spacer(),
                              Checkbox(value:data[index]['ischec']==1?true:false, onChanged:(bool? value){
                                if(data[index]['ischec']==0){
                                  appcubit.get(context).updatedatabase(1, data[index]['id']);
                                  appcubit.get(context).insertodatabase2(data[index]['title'],  data[index]['content'], data[index]['time'],data[index]['date'],  0);
                                  appcubit.get(context).delet(data[index]['id']);



                                }else{
                                  appcubit.get(context).updatedatabase(0, data[index]['id']);

                                }
                              } )
                            ],
                          ),
                          Container(
                            height: 60,
                            child: SingleChildScrollView(
                              child: ReadMoreText(
                                data[index]['content'],
                                trimLength: 150,
                                trimLines: 2,
                                textAlign: TextAlign.left,
                                colorClickableText: Colors.pink,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'more',
                                trimExpandedText: '\nless',
                                lessStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,

                                ),
                                moreStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Spacer(),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                '${data[index]['date']}',
                                style: TextStyle(color: Colors.white70),
                              ))
                        ],
                      ),
                    ),
                  ),
              ),
        );
      },
      gridDelegate:
          SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }
}
