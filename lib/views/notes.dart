import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/database/db.dart';
import 'package:flutter_app/models/note.dart';
import 'package:flutter_app/models/transition.dart';
import 'package:flutter_app/views/edit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Booknotes extends StatefulWidget {
  @override
  _BooknotesState createState() => _BooknotesState();
}

class _BooknotesState extends State<Booknotes> {
  bool loading = true;
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverPadding(padding: EdgeInsets.only(top: 5)),
            SliverAppBar(
              expandedHeight: 170.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: TyperAnimatedTextKit(
                  text: ['All Notes'],
                  textStyle: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                  speed: Duration(milliseconds: 60),
                  repeatForever: false,
                ),
              ),
            ),
            new SliverPadding(
              padding: EdgeInsets.only(bottom: 60),
            ),
          ];
        },
        body: StaggeredGridView.countBuilder(
            shrinkWrap: true,
            padding: EdgeInsets.all(5),
            itemCount: notes.length,
            crossAxisCount: 4,
            itemBuilder: (context, index) {
              Note note = notes[index];
              String? noteDate = note.date!.toString();
              return GestureDetector(
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  Navigator.push(
                    context,
                    createRoute(
                      Edit(
                        note: note,
                      ),
                    ),
                  ).then((v) => refresh());
                },
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.title!,
                          softWrap: true,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "${noteDate.substring(6)}-${noteDate.substring(4, 6)}-${noteDate.substring(0, 4)}",
                          style: TextStyle(fontSize: 10.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        AutoSizeText(
                          note.content!,
                          minFontSize: 16,
                          maxLines: 8,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            staggeredTileBuilder: (index) {
              return StaggeredTile.fit(2);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_rounded,
          size: 35,
        ),
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
