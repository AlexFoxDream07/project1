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
      averageGrade: (map['averageGrade'] as num?)?.toDouble() ?? 0.0
    );
  }
}