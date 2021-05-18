import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:visab_admin/models/location.dart';
part 'city.g.dart';

@JsonSerializable(explicitToJson: true)
class City{
  String cityId;
  String name;
  String imageUrl;
  String description;
  Location location;

  City(this.cityId,this.name, this.imageUrl,this.description,this.location);

  factory City.fromJson(Map<String, dynamic> json) =>
      _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);

  factory City.fromDocumentSnapshot(DocumentSnapshot json) {
    return City(
      json.id,
      json['name'] as String,
      json['imageUrl'] as String,
      json['description'] as String,
      json['location'] as Location
    );
  }


  @override
  String toString() {
    // TODO: implement toString
    return "====================\nCity Name : $name\nCity Description : $description\nCity Location : ${location.toString()}\n====================";
  }
}