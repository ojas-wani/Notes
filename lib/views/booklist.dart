import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookList extends StatefulWidget {
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  var _index = 0;
  var _image =
      "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/contemporary-fiction-night-time-book-cover-design-template-1be47835c3058eb42211574e0c4ed8bf_screen.jpg?ts=1594616847";
  late String name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Icon(
            //Back Icon
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          backgroundColor: Colors.white, //To match with the background
          title: Text(
            "All Notes",
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Container(
          //For Background gradient effect
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.grey]),
          ),
          child: Column(
            children: [
              SizedBox(
                //BLANK SPACE
                height: 120,
              ),
              //BOOKLIST
              Expanded(
                child: GridView.builder(
                    controller: ScrollController(),
                    shrinkWrap: true,
                    itemCount: _index,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (BuildContext context, _index) {
                      return Column(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                print("detected");
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(0.1),
                                child: Image.network(_image, fit: BoxFit.fill),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 2),
                                ),
                              ),
                            ),
                          ),
                          Text(name),
                        ],
                      );
                    }),
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                  child: Text("ADD"),
                  onPressed: () {
                    setState(() {
                      _index += 1;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
