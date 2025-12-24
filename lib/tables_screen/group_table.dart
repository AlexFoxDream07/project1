import 'package:flutter/material.dart';
import 'package:project1/db/tables.dart';
import 'package:project1/tables_screen/student_table.dart';
import 'package:project1/tables_screen/grades_table.dart';
import 'package:project1/db/group_manager.dart';
import 'package:project1/tables_screen/crud_screen/group/insert_group_screen.dart';
import 'package:project1/tables_screen/crud_screen/group/update_group_screen.dart';
import 'package:project1/tables_screen/crud_screen/group/delete_group_screen.dart';

class GroupTableScreen extends StatefulWidget {
  const GroupTableScreen({super.key});

  @override
  _GroupTableScreenState createState() => _GroupTableScreenState();
}

class _GroupTableScreenState extends State<GroupTableScreen>{
  List<Groups> groups = [];
  GroupManager groupManager = GroupManager();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadGroups();
  }

  Future<void> loadGroups() async {
    setState(() {
      _isLoading = true;
    });
    List<Groups> loadGrades = await groupManager.readGroup();
    print(groups.length);
    setState(() {
      groups = loadGrades;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Таблица Групп"),
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
                    child: Text("№ Направления", style: TextStyle(fontSize: 24)),
                  )
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text("Название", style: TextStyle(fontSize: 24)),
                  )
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text("Год", style: TextStyle(fontSize: 24)),
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
            /// передача данных из таблицы Group
          ...groups.map((group) => TableRow(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      group.id?.toString() ?? '',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      group.directionId.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      group.name,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      group.yaer,
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
                                showUpdateDialog(context, group, () {
                                  setState(() {
                                    loadGroups();
                                  });
                                });
                              },
                            icon: Icon(Icons.edit),
                          ),
                          SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              showDeleteDialog(context, group, (){
                                setState(() {
                                  loadGroups();
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
                loadGroups();
              });
            });
          },
      ),
    );
  }
}