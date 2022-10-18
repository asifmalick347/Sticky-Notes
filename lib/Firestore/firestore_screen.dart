import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestorePractice extends StatefulWidget {
  const FirestorePractice({Key? key}) : super(key: key);

  @override
  State<FirestorePractice> createState() => _FirestorePracticeState();
}

class _FirestorePracticeState extends State<FirestorePractice> {

  final firebaseFirestore = FirebaseFirestore.instance.collection('practice');

  addData()async{
    try{
      String uid = DateTime.now().microsecondsSinceEpoch.toString(); 
      await firebaseFirestore.doc(uid).set({
        'id': uid,
        'name': 'Asif',
      });
    }
    catch (e){
      print('Error: $e');
    }
  }
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Practice'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                addData;
              },
              child: const Text('Add Data'),
            ),
          ],
        ),
      ),
    );
  }
}
