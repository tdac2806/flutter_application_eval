import 'package:flutter/material.dart';
import 'package:flutter_application_eval/note.dart';
import 'package:intl/intl.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Evaluation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Ecran principal'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController titreController = TextEditingController();
  TextEditingController contenuController = TextEditingController();
  List<Note> notes = initnote();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'MES NOTES',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: const Text('NOUVELLE NOTE',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.grey,
                          ))),
                  TextFormField(
                    controller: titreController,
                    minLines: 1,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      labelText: 'Titre',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      controller: contenuController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Contenu',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: ElevatedButton(
                        onPressed: () {
                          // Respond to button press
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 102, 105, 102),
                          onPrimary: Colors.white,
                          shadowColor: const Color.fromARGB(255, 0, 0, 0),
                          elevation: 3,
                          minimumSize: const Size(100, 40),
                        ),
                        child: const Text('Ajouter une image'),
                      )),
                  Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: ElevatedButton(
                        onPressed: () => setState(() => {
                              notes.add(Note(
                                  titre: titreController.text,
                                  date: getCurrentDate(),
                                  texte: contenuController.text,
                                  image:
                                      'https://i.ibb.co/NVW6wCy/unknown.png')),
                              titreController.clear(),
                              contenuController.clear(),
                            }),
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 102, 105, 102),
                          onPrimary: Colors.white,
                          shadowColor: const Color.fromARGB(255, 0, 0, 0),
                          elevation: 3,
                          minimumSize: const Size(350, 40),
                        ),
                        child: const Text('AJOUTER MA NOTE'),
                      )),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('MES NOTES SAUVEGARDÉES',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: notes.length,
                      itemBuilder: (context, index) =>
                          NotePage(note: notes[index]),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

List<Note> initnote() {
  List<Note> notes = [];
  while(notes.length < 3)
  {
      notes.add(Note(
      titre: lorem(
        words: 4,
        paragraphs: 1
      ),
      date: getCurrentDate(),
      texte: lorem(words: 60, paragraphs: 1),
      image: 'https://i.ibb.co/NVW6wCy/unknown.png'));
  }
  return notes;
}

String getCurrentDate() {
  DateTime now = DateTime.now();
  return DateFormat('dd/MM/yyyy').format(now);
}
