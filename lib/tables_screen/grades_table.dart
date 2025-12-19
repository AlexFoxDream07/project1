import 'package:flutter/material.dart';
import 'package:project1/tables_screen/student_table.dart';
import 'package:project1/tables_screen/group_table.dart';

class GradesTableScreen extends StatefulWidget {
  const GradesTableScreen({super.key});

  @override
  _GradesTableScreenState createState() => _GradesTableScreenState();
}

class _GradesTableScreenState extends State<GradesTableScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Таблица Оценок"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text("Таблицы", style: TextStyle(fontSize: 24))
            ),
            ListTile(
              title: Text("Таблица Групп", style: TextStyle(fontSize: 24)),
              onTap: () {
                Navigator.push(context, 
                MaterialPageRoute(
                  builder: (context) => GroupTableScreen()
                  )
                );
              },
            ),
            ListTile(
              title: Text("Таблица Студентов", style: TextStyle(fontSize: 24)),
              onTap: () {
                Navigator.push(context, 
                MaterialPageRoute(
                  builder: (context) => StudentTableScreen()
                  )
                );
              },
            ),
          ],
        ),
      ),
      body: Table(
        border: TableBorder(horizontalInside: BorderSide(width: 10.0)),
        children: [
          TableRow(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("ID", style: TextStyle(fontSize: 24)),
                )
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("ID Студента", style: TextStyle(fontSize: 24)),
                )
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Оценки", style: TextStyle(fontSize: 24)),
                )
              )
            ]
          ),
          /// передача данных из таблицы
        ],
      )
    );
  }
}