import 'package:flutter/material.dart';
import 'package:project1/screens/tables_screen/group_table.dart';
import 'package:project1/screens/tables_screen/grades_table.dart';
import 'package:project1/screens/tables_screen/direction_table.dart';
import 'package:project1/db/students/student_manager.dart';
import 'package:project1/db/students/students.dart';
import 'package:project1/db/students/debtor.dart';
import 'package:project1/screens/crud_screen/student/insert_students_screen.dart';
import 'package:project1/screens/crud_screen/student/update_students_screen.dart';
import 'package:project1/screens/crud_screen/student/delete_students_screen.dart';
import 'package:project1/screens/tables_screen/exit_screen.dart';

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
    try {
      List<Students> loadStudents = await studentManager.readStud();
      setState(() {
        students = loadStudents;
        _isLoading = false;
      });
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ошибка загрузки студентов")));
        setState(() {
          _isLoading = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Таблица Студентов", style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            icon: Icon(Icons.save_alt),
            onPressed: () {
              saveDeptorToFile(context);
            },
          ),
        ],
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
                // ListView(
                //   children: [
                //     UserAccountsDrawerHeader (
                //        accountName: Text('User'),
                //        accountEmail: Text('Email')
                //     ),
                //   ],
                // ),
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
                ListTile(
                  title: Text("Таблица Направлений", style: TextStyle(fontSize: 24)),
                  onTap: () {
                    Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => DirectionTableScreen()
                      )
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Выход из аккаунта'),
                  onTap: () {
                    showExitScreen(context);
                  },
                )
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
          columnWidths: <int, TableColumnWidth> {
            0: IntrinsicColumnWidth(),
            1: FixedColumnWidth(screenWidth * 0.3),
            2: FixedColumnWidth(screenWidth * 0.2),
            3: FixedColumnWidth(screenWidth * 0.25),
            4: IntrinsicColumnWidth(),
          },
          border: TableBorder.all(width: 1.0, color:  Colors.black),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[300]),
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Text("ID", style: TextStyle(fontSize: 16)),
                  )
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Text("ФИО Студента", style: TextStyle(fontSize: 16)),
                  )
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Text("№ Группы", style: TextStyle(fontSize: 16)),
                  )
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Text("Средний балл", style: TextStyle(fontSize: 16)),
                  )
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Text("Действия", style: TextStyle(fontSize: 16)),
                  ),
                )
              ]
            ),
            /// передача данных из таблицы Students
            ...students.map((student) => TableRow(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      student.id?.toString() ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      student.fullName,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      student.groupId.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      student.averageGrade.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
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
                          icon: Icon(Icons.edit, size: 24,),
                        ),
                        SizedBox(height: 3, width: 3),
                        IconButton(
                          onPressed: () {
                            showDeleteDialog(context, student, (){
                              setState(() {
                                loadStudents();
                              });
                            });
                          }, 
                          icon: Icon(Icons.hide_source, size: 24,),
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