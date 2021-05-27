import 'package:flutter/material.dart';
import 'package:my_music_app/page/album/album.dart';
import 'package:my_music_app/page/album/album_detail.dart';

import 'package:my_music_app/page/playlist/playlist.dart';
import 'package:my_music_app/page/singer/singer.dart';
import 'package:my_music_app/widgets/tags.dart';

class OfflinePage extends StatefulWidget {
  @override
  _OfflinePageState createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Wrap(
            children: [
              Mtag(
                lable: "Album",
                icon: Icons.ac_unit,
                color: Colors.blue,
                onpressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AlbumPage(),
                    ),
                  );
                },
              ),
              Mtag(
                lable: "Ca si",
                icon: Icons.ac_unit,
                color: Colors.blue,
                onpressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SingerPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          Text(
            "Danh sách phát nhạc của tôi",
            style: TextStyle(fontSize: 25, color: Colors.blue),
          ),
          Expanded(
            child: Container(
              color: Colors.yellow,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: PLaylistPage(),
            ),
          ),
        ],
      ),
    );
  }
}
