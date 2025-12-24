import 'package:flutter/material.dart';
import 'package:project1/db/tables.dart';
import 'package:project1/tables_screen/student_table.dart';
import 'package:project1/tables_screen/group_table.dart';
import 'package:project1/db/grade_manager.dart';
import 'package:project1/tables_screen/crud_screen/grade/insert_grade_screen.dart';
import 'package:project1/tables_screen/crud_screen/grade/update_grade_screen.dart';
import 'package:project1/tables_screen/crud_screen/grade/delete_grade_screen.dart';

class GradesTableScreen extends StatefulWidget {
  const GradesTableScreen({super.key});

  @override
  _GradesTableScreenState createState() => _GradesTableScreenState();
}

class _GradesTableScreenState extends State<GradesTableScreen>{
  List<Grades> grades = [];
  GradeManager gradeManager = GradeManager();
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    loadGrades();
  }

  Future<void> loadGrades() async {
    setState(() {
      _isLoading = true;
    });
    List<Grades> loadGrades = await gradeManager.readGrade();
    print(grades.length);
    setState(() {
      grades = loadGrades;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Таблица Оценок"),
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
                    child: Text("ID Студента", style: TextStyle(fontSize: 24)),
                  )
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text("Оценки", style: TextStyle(fontSize: 24)),
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
            ...grades.map((grade) => TableRow(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      grade.id?.toString() ?? '',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      grade.studentID.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      grade.grades.toString(),
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
                                showUpdateDialog(context, grade, () {
                                  setState(() {
                                    loadGrades();
                                  });
                                });
                              },
                            icon: Icon(Icons.edit),
                          ),
                          SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              showDeleteDialog(context, grade, (){
                                setState(() {
                                  loadGrades();
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
            ))
          ]),
      ),
        floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
        onPressed: () {
            showInsertDialog(context, () {
              setState(() {
                loadGrades();
              });
            });
          },
      ),
    );
  }
}