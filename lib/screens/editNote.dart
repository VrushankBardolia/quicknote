import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/detailsField.dart';
import '../components/titleField.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {

  final titleController = TextEditingController();
  final detailsController = TextEditingController();
  DateTime dateTime = Get.arguments['note']["createdAt"].toDate();
  late final String time;
  late final String noteID = Get.arguments['noteID'];

  @override
  void initState() {
    titleController.text = Get.arguments['note']['title'];
    detailsController.text = Get.arguments['note']['details'];
    time = "${dateTime.day}/${dateTime.month}/${dateTime.year}  ${dateTime.hour}:${dateTime.minute}";
    super.initState();
  }

  editNote()async{
    await FirebaseFirestore.instance.collection("notes").doc(noteID).update({
          "title":titleController.text,
          "details":detailsController.text,
        });
    Get.back();
    final snackBar = SnackBar(
      content: const Text('Note Edited!',style: TextStyle(fontSize: 16)),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      dismissDirection: DismissDirection.down,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  deleteNote()async{
    await FirebaseFirestore.instance.collection("notes").doc(noteID).delete();
    Get.back();
    final snackBar = SnackBar(
      content: const Text('Note Deleted!',style: TextStyle(fontSize: 16)),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      dismissDirection: DismissDirection.down,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(time, style: GoogleFonts.jetBrainsMono(color: theme.onBackground,fontSize: 16)),
        actions: [
          IconButton(onPressed: deleteNote, icon: const Icon(Icons.delete))
        ],
        iconTheme: IconThemeData(color: theme.onBackground),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TitleField(controller: titleController, focus: false),
              DetailsField(controller: detailsController)
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed:editNote,
        label: const Text('Save Note', style: TextStyle(fontSize: 16)),
        icon: const Icon(Icons.save_rounded),
        elevation: 0,
      ),
    );
  }
}
