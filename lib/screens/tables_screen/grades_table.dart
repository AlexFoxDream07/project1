import 'package:flutter/material.dart';
import 'package:project1/screens/tables_screen/student_table.dart';
import 'package:project1/screens/tables_screen/group_table.dart';
import 'package:project1/screens/tables_screen/direction_table.dart';
import 'package:project1/db/grades/grade_manager.dart';
import 'package:project1/db/grades/grades.dart';
import 'package:project1/screens/crud_screen/grade/insert_grade_screen.dart';
import 'package:project1/screens/crud_screen/grade/update_grade_screen.dart';
import 'package:project1/screens/crud_screen/grade/delete_grade_screen.dart';

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
    setState(() {
      grades = loadGrades;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                ListView(
                  children: [
                    UserAccountsDrawerHeader(accountName: Text('User'), accountEmail: Text('Email'))
                  ],
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
            2: FixedColumnWidth(screenWidth * 0.45),
            3: IntrinsicColumnWidth(),
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
                    child: Text("ID Студента", style: TextStyle(fontSize: 16)),
                  )
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Text("Оценка", style: TextStyle(fontSize: 16)),
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
            /// передача данных и таблицы Grade
            ...grades.map((grade) => TableRow(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      grade.id?.toString() ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      grade.studentID.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      grade.grades.toString(),
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
                                showUpdateDialog(context, grade, () {
                                  setState(() {
                                    loadGrades();
                                  });
                                });
                              },
                            icon: Icon(Icons.edit, size: 24,),
                          ),
                          SizedBox(height: 3, width: 3),
                          IconButton(
                            onPressed: () {
                              showDeleteDialog(context, grade, (){
                                setState(() {
                                  loadGrades();
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