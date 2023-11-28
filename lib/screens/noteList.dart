import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/actionAlert.dart';
import '../components/noteTile.dart';
import '../screens/addNote.dart';
import '../screens/editNote.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  User? userId=FirebaseAuth.instance.currentUser;

  signOut(){
    showDialog(
        context: context,
        builder: (context){
          return ActionAlert(
              title: 'LogOut',
              content: 'You will be logged out but your data will not be erased',
              onTap: (){
                FirebaseAuth.instance.signOut();
                Get.back();
                final snackBar = SnackBar(
                  content: const Text('User Logged Out!',style: TextStyle(fontSize: 16),),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  dismissDirection: DismissDirection.down,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              actionText: 'Logout'
          );
        }
    );
  }

  changeTheme(){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return SizedBox(
          height: 230,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Change Theme',style: Theme.of(context).textTheme.titleLarge),
              ),
              ListTile(
                title: const Text('System'),
                leading: const Icon(Icons.phone_android_rounded),
                onTap: (){
                  Get.changeThemeMode(ThemeMode.system);
                  Get.back();
                },
              ),
              ListTile(
                title: const Text('Light'),
                leading: const Icon(Icons.light_mode_rounded),
                onTap: (){
                  Get.changeThemeMode(ThemeMode.light);
                  Get.back();
                },
              ),
              ListTile(
                title: const Text('Dark'),
                leading: const Icon(Icons.dark_mode_rounded),
                onTap: (){
                  Get.changeThemeMode(ThemeMode.dark);
                  Get.back();
                },
              ),
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.background,
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
        onPressed: (){Get.to(() =>const AddNote());},
        label: const Text('Add Note', style: TextStyle(fontSize: 16)),
        icon: const Icon(Icons.add_rounded),
        elevation: 0,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,

      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(onPressed: changeTheme, icon: const Icon(Icons.color_lens_rounded))
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("notes").orderBy("createdAt",descending: true).snapshots(),
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
                    DateTime dateTime = note["createdAt"].toDate();
                    if(note['uid']==userId!.uid){
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: NoteTile(
                          title: note['title'],
                          date: "${dateTime.day}/${dateTime.month}/${dateTime.year}  ${dateTime.hour}:${dateTime.minute}",
                          onTap: (){
                            Get.to(() => const EditNote(),
                                arguments: {'note':note, 'noteID':note.id}
                            );
                          }
                        ),
                      );
                    }else{return Container();}
                  }
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}