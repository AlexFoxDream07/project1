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
      'ID' : id,
      'Full Name' : fullName,
      'GroupID' : groupId
  };
  }
  factory Students.fromMap(Map<String, dynamic> map){
    return Students(
      id: map['ID'],
      fullName: map['FullName'], 
      groupId: map['GroupId'],
    );
  }
}

class Groups{
  final int? id;
  final String direction;
  final String name;
  final DateTime yaer;

  Groups({this.id, required this.direction, required this.name, required this.yaer});

  Map<String, dynamic> toMap(){
    return {'ID' : id, 'Direction' : direction, 'Name' : name, 'Year' : yaer};
  }
  factory Groups.fromMap(Map<String, dynamic> map){
    return Groups(
      id: map['ID'],
      direction: map['Direction'], 
      name: map['Name'], 
      yaer: map['Year']
    );
  }
}

class Grades{
  final int? id;
  final int studentID;
  final int grades;

  Grades({this.id, required this.studentID, required this.grades});

  Map<String, dynamic> toMap(){
    return {'ID' : id, 'StudentID' : studentID, 'Grades' : grades};
  }
  factory Grades.fromMap(Map<String, dynamic> map){
    return Grades(
      id: map['ID'],
      studentID: map['StudentID'], 
      grades: map['Grades'], 
    );
  }
}