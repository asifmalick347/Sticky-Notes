import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:navigation_app/TodoList/addPost_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:navigation_app/TodoList/notesDetail_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final firebaseFirestore = FirebaseFirestore.instance.collection('mynotes').snapshots();
  CollectionReference reference = FirebaseFirestore.instance.collection('mynotes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AddPost()));
            },
            icon: const Icon(Icons.add),
          ),
        ],
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
            StreamBuilder<QuerySnapshot>(
                stream: firebaseFirestore,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return const Text('Some Error');
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text(
                      'No notes yet',
                      style: TextStyle(fontSize: 20),
                    ));
                  }
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NotesDetailScreen(
                                        title: snapshot
                                            .data!.docs[index]['title']
                                            .toString(),
                                        notes: snapshot
                                            .data!.docs[index]['notes']
                                            .toString(),
                                        date: DateFormat.yMMMd()
                                            .format(DateTime.now())
                                            .toString(),
                                        id: snapshot.data!.docs[index]['id']
                                            .toString(),
                                      )));
                            },
                            child: Card(
                              elevation: 7,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 15,
                                  child: Text((index + 1).toString()),
                                ),
                                title: Text(
                                  snapshot.data!.docs[index]['title']
                                      .toString(),
                                  style: const TextStyle(color: Colors.pink),
                                ),
                                subtitle: Text(
                                    DateFormat.yMMMd().format(DateTime.now())),
                                trailing: Column(
                                  children: [
                                    // TextButton(
                                    //   onPressed: (){

                                    //   },
                                    //   child: const Icon(Icons.edit,),
                                    // ),
                                    IconButton(
                                      onPressed: () async {
                                        await reference
                                            .doc(snapshot
                                                .data!.docs[index]['id']
                                                .toString())
                                            .delete();
                                      },
                                      icon: const Icon(Icons.delete),
                                      color: Colors.pink,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddPost()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
