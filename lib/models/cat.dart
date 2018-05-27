import 'package:meta/meta.dart';

class Cat {
  final String documentId;
  int externalId;
  String name;
  String description;
  String avatarUrl;
  String location;
  int likeCounter;
  bool isAdopted;
  List<String> pictures;
  List<String> cattributes;
  bool checked;

  Cat({
    @required this.documentId,
    @required this.externalId,
    @required this.name,
    @required this.description,
    @required this.avatarUrl,
    @required this.location,
    @required this.likeCounter,
    @required this.isAdopted,
    @required this.pictures,
    @required this.cattributes,
    this.checked = false
  });
}
