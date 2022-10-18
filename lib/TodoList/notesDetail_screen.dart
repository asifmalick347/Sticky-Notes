import 'package:flutter/material.dart';
import 'package:navigation_app/TodoList/editNotes_screen.dart';

class NotesDetailScreen extends StatefulWidget {
 final String? title;
 final String? notes;
 final String? date;
 final String? id;

  const NotesDetailScreen({
   @required this.title,
   @required this.notes,
   @required this.date,
   @required this.id,
  });

  @override
  State<NotesDetailScreen> createState() => _NotesDetailScreenState();
}

class _NotesDetailScreenState extends State<NotesDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes Detail'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title.toString(), style: const TextStyle(color: Colors.pink, fontSize: 26, fontWeight: FontWeight.bold,),),
                const SizedBox(
                  height: 10,
                ),
                Text(widget.notes.toString(), style: const TextStyle(fontSize: 20),),
                const SizedBox(
                  height: 10,
                ),
                Text(widget.date.toString(), style: const TextStyle(color: Colors.pink, fontSize: 16),),
                const SizedBox(height: 10,),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditScreen(widget.id.toString())));
                }, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.edit, size: 20,),
                    SizedBox(width: 5,),
                    Text('Edit'),
                  ],
                )),
              ],
            ),
          ),
      ),
    );
  }
}
