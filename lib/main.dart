import 'package:flutter/material.dart';
import 'package:flutter_hive_tutorial/models/steps.dart';
import 'package:flutter_hive_tutorial/services/notes_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'components/note_tile.dart';
import 'models/note.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(NoteStepAdapter());

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
                Note(title: "Olá", dateTime: DateTime.now(), description: "Olá Mundo",steps: [NoteStep(note: "Note 1")] ),
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: CustomScrollView(slivers: [
            SliverAppBar(
              pinned: true,
              floating: false,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: AppBar(
                  leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu),
                  ),
                  actions: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
                  ],
                ),
              ),
              expandedHeight: 170.0,

              flexibleSpace: Center(
                child: Text(
                  "My Notes",
                  style: TextStyle(fontSize: 45,color: Colors.grey.shade600, fontWeight: FontWeight.w300),  ),
              ),
            ),
            ValueListenableBuilder(
                valueListenable: Hive.box<Note>("notes").listenable(),
                builder: (context, box, _) {
                  var list = box.values.toList().reversed.toList();

                  return SliverList(

                    delegate: SliverChildBuilderDelegate(

                      (_, int index) {
                        Note note = list[index];
                        return NoteTile(note: note);
                      },
                      childCount: list.length,
                    ),
                  );
                }),
          ]),
        )));
  }
}
