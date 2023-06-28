import 'constant.dart';

class taskmodel {
  int? id ;
  String? title ;
  String? detal ;
  String? time ;
  String? date ;

  taskmodel({
    this.title,
    this.detal,
    this.time,
    this.date
  });

taskmodel.frommap(Map data){
id = data[colmnid];
title =data[colmntitle];
detal =data[colmndetales];
time =data[colomntime];
date =data[colomndate];
}

  Map<String, dynamic> toMap() {
    return {
      colomntime: time,
      colomndate: date,
      colmndetales: detal,
      colmntitle: title,
    };
  }
}