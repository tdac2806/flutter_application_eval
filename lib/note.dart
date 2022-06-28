import 'package:flutter/material.dart';
import 'package:flutter_application_eval/ecran_details.dart';

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

class NotePage extends StatelessWidget {
  final Note note;
  const NotePage({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: InkWell(
        child: noteWidget(note: note),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(
              note: note,
            ),
          ),
        ),
      ),
    );
  }
}

Column noteWidget({required Note note}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          note.titre,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        Text(
          note.date,
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic),
          textAlign: TextAlign.left,
        ),
        Text(note.texte),
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.network(note.image),
        ),
        const Divider(
          color: Colors.black,
        ),
      ],
    );
