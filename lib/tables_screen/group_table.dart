import 'package:flutter/material.dart';
import 'package:project1/tables_screen/student_table.dart';
import 'package:project1/tables_screen/grades_table.dart';

class GroupTableScreen extends StatefulWidget {
  const GroupTableScreen({super.key});

  @override
  _GroupTableScreenState createState() => _GroupTableScreenState();
}

class _GroupTableScreenState extends State<GroupTableScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Таблица Групп"),
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
              title: Text("Таблица Студентов", style: TextStyle(fontSize: 24)),
              onTap: () {
                Navigator.push(context, 
                MaterialPageRoute(
                  builder: (context) => StudentTableScreen()
                  )
                );
              },
            ),
            ListTile(
              title: Text("Таблица Оценок", style: TextStyle(fontSize: 24)),
              onTap: () {
                Navigator.push(context, 
                MaterialPageRoute(
                  builder: (context) => GradesTableScreen()
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
                  child: Text("Направление", style: TextStyle(fontSize: 24)),
                )
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Наименование группы", style: TextStyle(fontSize: 24)),
                )
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Год", style: TextStyle(fontSize: 24)),
                )
              ),
            ]
          ),
          /// передача данных из таблицы
        ],
      )
    );
  }
}