class DataModel {
  String? name;
  String? age;
  String? number;
  String? group;
  String? image;
  DataModel({
    required this.name,
    required this.age,
    required this.number,
    required this.group,
    required this.image,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      name: json["name"],
      age: json['age'].toString(),
      number: json['number'].toString(),
      group: json['group'],
      image: json['image'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'number': number,
      'group': group,
      'image': image,
    };
  }
}
