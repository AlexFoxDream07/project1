class Groups{
  final int? id;
  final int directionId;
  final String name;
  final String year;

  Groups({this.id, required this.directionId, required this.name, required this.year});

  Map<String, dynamic> toMap(){
    return {'id' : id, 'directionId' : directionId, 'name' : name, 'year' : year};
  }
  factory Groups.fromMap(Map<String, dynamic> map){
    return Groups(
      id: map['id'],
      directionId: map['directionId'], 
      name: map['name'], 
      year: map['year']
    );
  }
}