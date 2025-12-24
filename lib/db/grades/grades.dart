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
