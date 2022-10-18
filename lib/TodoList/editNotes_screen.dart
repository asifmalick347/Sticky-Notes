import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:navigation_app/TodoList/post_screen.dart';

class EditScreen extends StatefulWidget {
  String id;
  EditScreen(this.id);
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  final firebaseFirestore = FirebaseFirestore.instance.collection('mynotes');
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  editNotes() async {
    try {
      setState(() {
        loading = true;
      });
      await firebaseFirestore.doc(widget.id).update({
        'title': titleController.text.toString(),
        'notes': notesController.text.toString(),
      }).then((value) {
        setState(() {
          loading = false;
        });
      });
    } catch (e) {
      debugPrint('Error: $e');
      setState(() {
        loading = false;
      });
    }
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const PostScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Title..',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: notesController,
              maxLines: 5,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Add Notes..',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                editNotes();
              },
              child: loading == true
                  ? const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    )
                  : const Text('Update Notes'),
            ),
          ],
        ),
      ),
    );
  }
}
