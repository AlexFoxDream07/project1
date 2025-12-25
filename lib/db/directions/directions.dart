class Directions{
  final int? id;
  final String name;
  final String code;

  Directions({this.id, required this.name, required this.code});

  Map<String, dynamic> toMap(){
    return {'id' : id, 'name' : name, 'code' : code};
  }
  factory Directions.fromMap(Map<String, dynamic> map){
    return Directions(
      id: map['id'],
      name: map['name'], 
      code: map['code'], 
    );
  }
}