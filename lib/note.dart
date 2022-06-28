import 'package:flutter/material.dart';

class Note {
  final String titre;
  final String date;
  final String texte;
  final String image;

  Note(
      {required this.titre,
      required this.date,
      required this.texte,
      required this.image});
}

Widget NoteWidget({required Note note, required BuildContext context}) =>
    Container(
      padding:  const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.titre,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          Text(
            note.date,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
            textAlign: TextAlign.left,
          ),
          Text(note.texte),
          Image.network(note.image)
        ],
      ),
    );
