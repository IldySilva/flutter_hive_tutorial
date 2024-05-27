import 'package:flutter_hive_tutorial/models/steps.dart';
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
  @HiveField(4)
  List<NoteStep> steps = [];
  Note({required this.title, required this.dateTime, this.description, this.id, this.steps = const []});
}
