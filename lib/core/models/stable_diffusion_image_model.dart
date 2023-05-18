import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StableDiffusionImageResponseModel {
  final String status;
  final int eta;
  final String fetch_result;
  final int id;
  StableDiffusionImageResponseModel({
    required this.status,
    required this.eta,
    required this.fetch_result,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'eta': eta,
      'fetch_result': fetch_result,
      'id': id,
    };
  }

  factory StableDiffusionImageResponseModel.fromMap(Map<String, dynamic> map) {
    return StableDiffusionImageResponseModel(
      status: map['status'] as String,
      eta: double.parse(map['eta'].toString()).ceil(),
      fetch_result: map['fetch_result'] as String,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory StableDiffusionImageResponseModel.fromJson(String source) =>
      StableDiffusionImageResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class StableDiffusionImageModel {
  final String status;
  final String image;
  final int id;
  StableDiffusionImageModel({
    required this.status,
    required this.image,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'image': image,
      'id': id,
    };
  }

  factory StableDiffusionImageModel.fromMap(Map<String, dynamic> map) {
    return StableDiffusionImageModel(
      status: map['status'] as String,
      image: map['output'][0] as String,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory StableDiffusionImageModel.fromJson(String source) =>
      StableDiffusionImageModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
