import 'package:flutter/material.dart';

class ListSong extends StatefulWidget {
  @override
  _ListSongState createState() => _ListSongState();
}

class _ListSongState extends State<ListSong> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(index.toString()),
            ),
          );
        },
      ),
    );
  }
}
