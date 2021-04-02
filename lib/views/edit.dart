import 'package:flutter/material.dart';
import 'package:flutter_app/database/db.dart';
import 'package:flutter_app/models/note.dart';
import 'package:intl/intl.dart';

class Edit extends StatefulWidget {
  final Note? note;
  Edit({this.note});
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController? title, content;
  String? date = DateFormat("dd-MM-yyyy").format(DateTime.now());
  bool loading = false, editmode = false;

  @override
  void initState() {
    super.initState();
    title = new TextEditingController(text: "");
    content = new TextEditingController(text: "");
    if (widget.note!.id != null) {
      editmode = true;
      title!.text = widget.note!.title!;
      content!.text = widget.note!.content!;
    }
  }

  void dispose() {
    title!.dispose();
    content!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editmode ? "Edit" : "New"),
        backgroundColor: Color(0xffffb31a),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.save,
              ),
              onPressed: () {
                setState(() {
                  loading = true;
                  save();
                  Navigator.pop(context);
                });
              }),
          if (editmode)
            IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  setState(() {
                    // date = DateFormat("dd-MM-yyyy").format(DateTime.now());
                    loading = true;
                    delete();
                  });
                })
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.all(13),
              children: <Widget>[
                TextField(
                  controller: title,
                  decoration: InputDecoration(
                    hintText: "Title",
                    disabledBorder: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Express your thoughts",
                  ),
                  style: TextStyle(fontSize: 20),
                  controller: content,
                  maxLines: 50,
                ),
              ],
            ),
    );
  }

  Future<void> save() async {
    if (title!.text != '') {
      widget.note!.title = title!.text;
      widget.note!.content = content!.text;
      if (editmode)
        await DB().update(widget.note!);
      else
        await DB().add(widget.note!);
    }
    setState(() {
      loading = false;
    });
  }

  Future<void> delete() async {
    await DB().delete(widget.note!);
    Navigator.pop(context);
  }
}
