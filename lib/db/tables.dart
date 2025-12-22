class Students{
  final int? id;
  final String fullName;
  final int groupId;

  Students({this.id, required this.fullName, required this.groupId});

  // @override
  // String toString() {
  //   return ('ID : $id, Full Name: $fullName, GroupID: $groupId, Grade: $grade');
  // }
  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'fullName' : fullName,
      'groupId' : groupId
  };
  }
  factory Students.fromMap(Map<String, dynamic> map){
    return Students(
      id: map['id'],
      fullName: map['fullName'], 
      groupId: map['groupId'],
    );
  }
}

class Groups{
  final int? id;
  final String direction;
  final String name;
  final String yaer;

  Groups({this.id, required this.direction, required this.name, required this.yaer});

  Map<String, dynamic> toMap(){
    return {'if' : id, 'direction' : direction, 'name' : name, 'year' : yaer};
  }
  factory Groups.fromMap(Map<String, dynamic> map){
    return Groups(
      id: map['id'],
      direction: map['direction'], 
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
    return {'id' : id, 'studentId' : studentID, 'grades' : grades};
  }
  factory Grades.fromMap(Map<String, dynamic> map){
    return Grades(
      id: map['id'],
      studentID: map['studentId'], 
      grades: map['grades'], 
    );
  }
}