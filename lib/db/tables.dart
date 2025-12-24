class Students{
  final int? id;
  final String fullName;
  final int groupId;
  final double averageGrade;

  Students({this.id, required this.fullName, required this.groupId, required this.averageGrade});

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'fullName' : fullName,
      'groupId' : groupId,
      'averageGrade' : averageGrade
  };
  }
  factory Students.fromMap(Map<String, dynamic> map){
    return Students(
      id: map['id'],
      fullName: map['fullName'], 
      groupId: map['groupId'],
      averageGrade: map['averageGrade']
    );
  }
}

class Groups{
  final int? id;
  final int directionId;
  final String name;
  final String yaer;

  Groups({this.id, required this.directionId, required this.name, required this.yaer});

  Map<String, dynamic> toMap(){
    return {'id' : id, 'directionId' : directionId, 'name' : name, 'year' : yaer};
  }
  factory Groups.fromMap(Map<String, dynamic> map){
    return Groups(
      id: map['id'],
      directionId: map['directionId'], 
      name: map['name'], 
      yaer: map['year']
    );
  }
}

class Grades{
  final int? id;
  final int studentID;
  final int grades;

  Grades({this.id, required this.studentID, required this.grades});

  Map<String, dynamic> toMap(){
    return {'id' : id, 'studentId' : studentID, 'grade' : grades};
  }
  factory Grades.fromMap(Map<String, dynamic> map){
    return Grades(
      id: map['id'],
      studentID: map['studentId'], 
      grades: map['grade'], 
    );
  }
}

class Direction{
  final int? id;
  final String name;
  final int code;

  Direction({this.id, required this.name, required this.code});

  Map<String, dynamic> toMap(){
    return {'id' : id, 'name' : name, 'code' : code};
  }
  factory Direction.fromMap(Map<String, dynamic> map){
    return Direction(
      id: map['id'],
      name: map['name'], 
      code: map['code'], 
    );
  }
}