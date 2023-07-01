import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final String data;
  const TaskCard({super.key, required this.data});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 3),
      child: Container(
        color: Colors.red,
        height: MediaQuery.of(context).size.height*0.20,
        width: double.infinity,
        child: Text(widget.data),
      ),
    );
  }
}