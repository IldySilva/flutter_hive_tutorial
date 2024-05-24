import 'package:hive_flutter/hive_flutter.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  DateTime dateTime;
  Note({required this.title, required this.dateTime, this.description, this.id});
}
