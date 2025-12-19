import 'package:flutter/material.dart';
import 'package:project1/db/tables.dart';
import 'package:project1/tables_screen/group_table.dart';
import 'package:project1/tables_screen/grades_table.dart';
import 'package:project1/db/student_manager.dart';

class StudentTableScreen extends StatefulWidget {
  const StudentTableScreen({super.key});

  @override
  _StudentTableScreenState createState() => _StudentTableScreenState();
}

class _StudentTableScreenState extends State<StudentTableScreen>{
  //List<Students> students = StudentManager.readStud();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Таблица Студентов", style: TextStyle(fontSize: 24)),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text("Таблицы", style: TextStyle(fontSize: 24, color: Colors.white))
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
                  child: Text("ФИО Студента", style: TextStyle(fontSize: 24)),
                )
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("№ Группы", style: TextStyle(fontSize: 24)),
                )
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Оценка", style: TextStyle(fontSize: 24)),
                )
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Посещение", style: TextStyle(fontSize: 24)),
                )
              ),
            ]
          ),
          /// передача данных из таблицы Students
          // 
        ]),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {} ,
              icon: Icon(Icons.add, color: Colors.white, size: 24)
            ),
            IconButton(
              onPressed: () {} ,
              icon: Icon(Icons.edit, color: Colors.white, size: 24)
            ),
            IconButton(
              onPressed: () {} ,
              icon: Icon(Icons.delete, color: Colors.white, size: 24)
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () async {
          
      //     setState(() {});
      //   }
      // ),
    );
  }
}