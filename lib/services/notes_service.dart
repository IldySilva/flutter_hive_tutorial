import 'package:hive_flutter/hive_flutter.dart';

import '../models/note.dart';

class NotesService {

  static var box =  Hive.box<Note>("notes");

 static  insert(Note note) async {
    box.add(note);
  }

   static List<Note> fetch(){
   var result=   box.values.toList();
   return result;
  }
}
