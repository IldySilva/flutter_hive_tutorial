import 'package:hive_flutter/adapters.dart';


part 'steps.g.dart';

@HiveType(typeId: 2)
class NoteStep{

  @HiveField(0)
  String note;
  @HiveField(1)
  int? index;

  NoteStep({required this.note,this.index=0});
}