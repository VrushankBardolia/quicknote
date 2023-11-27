import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/detailsField.dart';
import '../components/titleField.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  final titleController = TextEditingController();
  final detailsController = TextEditingController();

  User? userId=FirebaseAuth.instance.currentUser;

  addNote()async{
    await FirebaseFirestore.instance.collection("notes").doc().set({
      "title":titleController.text,
      "details":detailsController.text,
      "createdAt":DateTime.now(),
      "uid":userId?.uid
    });
    Get.back();
    final snackBar = SnackBar(
      content: const Text('Note Added!',style: TextStyle(fontSize: 16)),
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
        backgroundColor: theme.primaryContainer,
        centerTitle: true,
        title: Text('Add Note',
            style: TextStyle(
                color: theme.onPrimaryContainer,
                fontWeight: FontWeight.w600,
                fontSize: 24
            )
        ),
        iconTheme: IconThemeData(color: theme.onPrimaryContainer),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TitleField(controller: titleController, focus: true),
              DetailsField(controller: detailsController)
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed:addNote,
        label: const Text('Save Note', style: TextStyle(fontSize: 16)),
        icon: const Icon(Icons.save_rounded),
        elevation: 0,
      ),
    );
  }
}
