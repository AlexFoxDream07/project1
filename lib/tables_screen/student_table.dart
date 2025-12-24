import 'package:flutter/material.dart';
import 'package:project1/db/tables.dart';
import 'package:project1/tables_screen/group_table.dart';
import 'package:project1/tables_screen/grades_table.dart';
import 'package:project1/db/student_manager.dart';
import 'package:project1/tables_screen/crud_screen/student/insert_students_screen.dart';
import 'package:project1/tables_screen/crud_screen/student/update_students_screen.dart';
import 'package:project1/tables_screen/crud_screen/student/delete_students_screen.dart';

class StudentTableScreen extends StatefulWidget {
  const StudentTableScreen({super.key});

  @override
  _StudentTableScreenState createState() => _StudentTableScreenState();
}

class _StudentTableScreenState extends State<StudentTableScreen>{
  List<Students> students = [];
  StudentManager studentManager = StudentManager();
  bool _isLoading = true;

  @override
  void initState() {  
    super.initState();
    loadStudents();
  }

  Future<void> loadStudents() async {
    setState(() {
      _isLoading = true;
    });
    List<Students> loadStudents = await studentManager.readStud();
    print(students.length);
    setState(() {
      students = loadStudents;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Таблица Студентов", style: TextStyle(fontSize: 24)),
      ),
      drawer: Drawer(
        child: FutureBuilder(
          future: Future.value(true),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            else {
              return ListView(
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
            );
            }
          }
        ),
      ),
      body: _isLoading
      ? Center(child: CircularProgressIndicator())
      : SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Table(
          border: TableBorder.all(width: 1.0, color:  Colors.black),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[300]),
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
                    child: Text("Действия", style: TextStyle(fontSize: 24)),
                  ),
                )
              ]
            ),
            /// передача данных из таблицы Students
            ...students.map((student) => TableRow(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      student.id?.toString() ?? '',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      student.fullName,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      student.groupId.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                              showUpdateDialog(context, student, () {
                                setState(() {
                                  loadStudents();
                                });
                              });
                            },
                          icon: Icon(Icons.edit),
                        ),
                        SizedBox(width: 8),
                        IconButton(
                          onPressed: () {
                            showDeleteDialog(context, student, (){
                              setState(() {
                                loadStudents();
                              });
                            });
                          }, 
                          icon: Icon(Icons.hide_source),
                        )
                      ],
                    )
                  ),
              )
              ]
            )
          )
          ]),
      ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showInsertDialog(context, () {
              setState(() {
                loadStudents();
              });
            });
          },
          backgroundColor: Colors.blueAccent,
        ),
    );
  }
}