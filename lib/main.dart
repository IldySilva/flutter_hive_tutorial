import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive_tutorial/services/date_extensions.dart';
import 'package:flutter_hive_tutorial/services/notes_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/note.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>("notes");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: const Color(0xff427dde)).copyWith(background: Colors.grey.shade100),
          useMaterial3: true,
        ),
        home: SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xff427dde),
              onPressed: () {
                NotesService.insert(
                  Note(title: "Olá", dateTime: DateTime.now(), description: "Olá Mundo"),
                );
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "My Notes",
                          style: TextStyle(fontSize: 45, color: Colors.grey.shade600, fontWeight: FontWeight.w300),
                        ),
                      )),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                      Row(
                        children: [
                          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
                        ],
                      )
                    ],
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                      builder: (context, box, _) {
                        var list = box.values.toList().reversed.toList();
                        return ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              Note note = list[index];

                              return Card(
                                surfaceTintColor: Colors.white,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    tileColor: Colors.white,
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (note.description != null) Text(note.description ?? ""),
                                        Text(note.dateTime.getDayAndHour(),style: const TextStyle(color: Colors.grey,fontSize: 12),)
                                      ],
                                    ),
                                    title: Text(note.title),
                                  ),
                                ),
                              );
                            });
                      },
                      valueListenable: Hive.box<Note>("notes").listenable(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
