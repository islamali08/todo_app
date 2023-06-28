import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp_mansorf/model/todo_app_model/sqlt_model.dart';

import 'constant.dart';
import 'package:todoapp_mansorf/modules/static.dart';


class databasehelper {

  static final databasehelper instance = databasehelper._init();


  databasehelper._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await createDB();
    return _database!;
  }



  Future<Database> createDB() async {
    String path = join(await getDatabasesPath(), 'TasksDB.db');
    return openDatabase(path, version: 1, onCreate: initDB);

  }

  Future<void> initDB(Database db, int version) async {
    // Create Table
    await db.execute('''
    CREATE TABLE $tablename (
    $colmnid $idType,
    $colomndate $textType,
    $colomntime $textType,
    $colmndetales $textType,
    $colmntitle $textType
    )
     ''');
    await db.execute('''
    CREATE TABLE $tablename2 (
    $colmnid $idType,
    $colomndate $textType,
    $colomntime $textType,
    $colmndetales $textType,
    $colmntitle $textType
    )
     ''');


  }

  Future<void> createTask(taskmodel tasksModel) async {
    //هستخدم ال جت بتاع (_database) عشان اساويها ب فريبل db
    final db = await instance.database;
    //هعمل insert لل تابل وهدخل اسم التابل و بعدين هستخدم ميثود tomap عشان احول ال data الي ختها من constructor ل map

    db.insert(

      tablename,
      tasksModel.toMap(),

      //هستخدم الالجورزم ده عشان امنع التكرار
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> createTask2(taskmodel tasksModel) async {
    //هستخدم ال جت بتاع (_database) عشان اساويها ب فريبل db
    final db = await instance.database;
    //هعمل insert لل تابل وهدخل اسم التابل و بعدين هستخدم ميثود tomap عشان احول ال data الي ختها من constructor ل map

    db.insert(
      tablename2,
      tasksModel.toMap(),
      //هستخدم الالجورزم ده عشان امنع التكرار
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<taskmodel>> readTasks() async {
    //هستخدم ال جت بتاع (_database) عشان اساويها ب فريبل db

    final db = await instance.database;
    // هعمل ليست اوف ماب عشان ال كويري بترجع ليست اوف ماب
    List<Map> tasksList = await db.query(tablename);
// لو ال تاسك ليست فاضي يرجع ليست فاضيه
    return tasksList.isEmpty
        ? []
    //   والا هلوب على تاسك ليست عن طريق .map  وهاخد الايتم الواحد احوله ليست اوف تاسك مودل
        : tasksList.map((item) => taskmodel.frommap(item)).toList();
  }
  Future<List<taskmodel>> readTasks2() async {
    //هستخدم ال جت بتاع (_database) عشان اساويها ب فريبل db

    final db = await instance.database;
    // هعمل ليست اوف ماب عشان ال كويري بترجع ليست اوف ماب
    List<Map> tasksList = await db.query(tablename2);
// لو ال تاسك ليست فاضي يرجع ليست فاضيه
    return tasksList.isEmpty
        ? []
    //   والا هلوب على تاسك ليست عن طريق .map  وهاخد الايتم الواحد احوله ليست اوف تاسك مودل
        : tasksList.map((item) => taskmodel.frommap(item)).toList();
  }


}