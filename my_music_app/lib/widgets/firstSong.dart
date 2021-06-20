import 'package:flutter/material.dart';

class BackgSinger extends StatelessWidget {
  final String name;
  final String img;
  final Function onpressed;
  BackgSinger({this.name, this.img, this.onpressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green[100],
      padding: EdgeInsets.all(10),
      child: Card(
        child: Row(
          children: [
            Container(
              width: 180,
              height: 180,
              child: Image.network(
                img ??
                    "https://cdn2.iconfinder.com/data/icons/music-indigo-vol-2/256/Music_Album-512.png",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 25),
                  ),
                  FloatingActionButton.extended(
                      onPressed: () {
                        onpressed();
                      },
                      label: Icon(Icons.play_circle_outline_outlined))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
