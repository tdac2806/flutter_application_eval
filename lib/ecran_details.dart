import 'package:flutter/material.dart';
import 'package:flutter_application_eval/note.dart';

class DetailsPage extends StatelessWidget {
  final Note note;
  const DetailsPage({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MES NOTES',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.left,
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
          child: noteWidget(note: note),
        ),
      ),
    );
  }
}