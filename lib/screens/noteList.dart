import 'package:cloud_firestore/cloud_firestore.dart';
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
  User? userId=FirebaseAuth.instance.currentUser;

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

      body: Padding(
        padding: const EdgeInsets.all(8),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("notes").where("uid",isEqualTo: userId?.uid).snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return const Center(child: Text('Something went wrong'));
            }
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            if(snapshot.data!.docs.isEmpty){
              return const Center(child: Text('Oops!\nNo Notes Available'));
            }
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                  final note= snapshot.data!.docs[index];
                  Timestamp t =note["createdAt"];
                  DateTime dateTime=t.toDate();
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        title: Text(note['title']),
                        subtitle: Text("${dateTime.day}-${dateTime.month}-${dateTime.year}  ${dateTime.hour}:${dateTime.minute}"),
                        tileColor: theme.secondaryContainer,
                        textColor: theme.onSecondaryContainer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        ),
                      ),
                    );
                  }
              );
            }
            return Container();
          },
        ),
      )
    );
  }
}
