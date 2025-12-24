class Direction{
  final int? id;
  final String name;
  final String code;

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