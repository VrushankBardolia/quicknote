import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Time', style: TextStyle(color: theme.onBackground)),
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
        onPressed: (){},
        label: const Text('Save Note', style: TextStyle(fontSize: 16)),
        icon: const Icon(Icons.save_rounded),
        elevation: 0,
      ),
    );
  }
}
