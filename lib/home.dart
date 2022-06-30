import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_eval/note.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_eval/repository/noterepository.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

NoteRepository noteRepository = NoteRepository();

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController titreController = TextEditingController();
  TextEditingController contenuController = TextEditingController();
  ImagePicker imagePicker = ImagePicker();

  List<Note> notes = [];
  List<XFile> images = [];

  @override
  void initState() {
    initnote();
    super.initState();
  }

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
                  Row(
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: ElevatedButton(
                            onPressed: () {
                              camera();
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
                      images.isNotEmpty
                          ? Container(
                              width: MediaQuery.of(context).size.width / 5,
                              height: MediaQuery.of(context).size.width / 5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: Image.file(File(images[0].path)).image,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: ElevatedButton(
                        onPressed: (() => {
                              noteRepository
                                  .addNote(Note(
                                      titre: titreController.text,
                                      date: getCurrentDate(),
                                      texte: contenuController.text,
                                      image: images.isNotEmpty
                                          ? images[0].path
                                          : ""))
                                  .then((value) => addnote(value)),
                              titreController.clear(),
                              contenuController.clear(),
                              images.clear(),
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

  initnote() async {
    notes = await noteRepository.getAllNotes();
    setState(() {});
    return;
  }

  addnote(Note note) {
    notes.add(note);
    setState(() {});
    return;
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    return DateFormat('dd/MM/yyyy').format(now);
  }

  camera() async {
    images.clear();
    var img = await imagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      images.add(img);
    }
    setState(() {});
  }
}
