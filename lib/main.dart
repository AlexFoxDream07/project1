import 'package:flutter/material.dart';
import 'package:project1/identification/register.dart';
//import 'package:project1/tables_screen/student_table.dart';
import 'package:project1/db/database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelp.instance.db;
  await DBHelp.instance.initDB();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Register(),
    );
  }
}
//ch23@a.ru
//A121234