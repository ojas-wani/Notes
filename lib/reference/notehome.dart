import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/database/db.dart';
import 'package:flutter_app/models/note.dart';
import 'package:flutter_app/views/edit.dart';

class notehome extends StatefulWidget {
  @override
  _notehome createState() => _notehome();
}

class _notehome extends State<notehome> {
  String name = "MEMORY";
  bool loading = true;
  late List<Note> notes;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Notes"),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(7),
              itemCount: notes.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                Note note = notes[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      loading = true;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Edit(
                                  note: note,
                                ))).then((v) => refresh());
                  },
                  child: Card(
                    color: Colors.grey[200],
                    child: GridTile(
                      child: Text(
                        note.content!,
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            loading = true;
          });
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Edit(note: new Note())))
              .then((v) => refresh());
        },
      ),
    );
  }

  Future<void> refresh() async {
    notes = await DB().getNotes();
    setState(() {
      loading = false;
    });
  }
}
