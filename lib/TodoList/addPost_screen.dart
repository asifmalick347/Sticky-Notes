import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:navigation_app/TodoList/post_screen.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  final firebaseFirestore = FirebaseFirestore.instance.collection('mynotes');
  bool loading = false;

  addNotes() async {
    try {
      setState(() {
        loading = true;
      });
      String uid = DateTime.now().millisecondsSinceEpoch.toString();
      await firebaseFirestore.doc(uid).set({
        'id': uid,
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
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const PostScreen()), (route) => false);
  }

  @override
  void initState() {
    super.initState();
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
                addNotes();
              },
              child: loading == true
                  ? const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    )
                  : const Text('Add Notes'),
            ),
          ],
        ),
      ),
    );
  }
}
