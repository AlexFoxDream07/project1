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