import 'package:flutter/material.dart';
import 'package:flutter_hive_tutorial/services/date_extensions.dart';

import '../models/note.dart';

class NoteTile extends StatefulWidget {
  NoteTile({super.key, required this.note});

  Note note;
  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300))..forward();
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    super.initState();
  }

  double containerWidth = 400;
  Offset containerOffset = const Offset(0, 0);

  @override
  void dispose() {
 _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          surfaceTintColor: Colors.white,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: Colors.white,
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.note.description != null) Text(widget.note.description ?? ""),
                  Text(
                    widget.note.dateTime.getDayAndHour(),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text("${widget.note.steps.length}Steps")
                ],
              ),
              title: Text(widget.note.title),
            ),
          ),
        ),
      ),
    );
  }
}
