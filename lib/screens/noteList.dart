import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quicknote/screens/addNote.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

  signOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryContainer,
        centerTitle: true,
        title: Text('QuickNote',
          style: TextStyle(
            color: theme.onPrimaryContainer,
            fontWeight: FontWeight.w600,
            fontSize: 24
          )
        ),
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout_outlined))
        ],
        actionsIconTheme: IconThemeData(color: theme.onPrimaryContainer),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){Get.to(const AddNote());},
        label: const Text('Add Note'),
        icon: const Icon(Icons.add_rounded),
        elevation: 0,
      ),
      body: const Center(child: Text('NoteList')),
    );
  }
}
