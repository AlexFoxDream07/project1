import 'package:flutter/material.dart';
import 'package:project1/tables_screen/student_table.dart';
import 'package:project1/tables_screen/grades_table.dart';
import 'package:project1/tables_screen/group_table.dart';
import 'package:project1/db/directions/directions.dart';
import 'package:project1/db/directions/direction_manager.dart';
import 'package:project1/tables_screen/crud_screen/direction/delete_direction_screen.dart';
import 'package:project1/tables_screen/crud_screen/direction/insert_direction_screen.dart';
import 'package:project1/tables_screen/crud_screen/direction/update_direction_screen.dart';

class DirectionTableScreen extends StatefulWidget {
  const DirectionTableScreen({super.key});

  @override
  _DirectionTableScreenState createState() => _DirectionTableScreenState();
}

class _DirectionTableScreenState extends State<DirectionTableScreen>{
  List<Direction> directions = [];
  DirectionManager directionManager = DirectionManager();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loaddirections();
  }

  Future<void> loaddirections() async {
    setState(() {
      _isLoading = true;
    });
    List<Direction> loadDir = await directionManager.readDir();
    setState(() {
      directions = loadDir;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Таблица Направлений"),
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
                    child: Text("Название", style: TextStyle(fontSize: 24)),
                  )
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text("Код", style: TextStyle(fontSize: 24)),
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
          ...directions.map((direction) => TableRow(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      direction.id?.toString() ?? '',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      direction.name,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      direction.code.toString(),
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
                                showUpdateDialog(context, direction, () {
                                  setState(() {
                                    loaddirections();
                                  });
                                });
                              },
                            icon: Icon(Icons.edit),
                          ),
                          SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              showDeleteDialog(context, direction, (){
                                setState(() {
                                  loaddirections();
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
                loaddirections();
              });
            });
          },
      ),
    );
  }
}