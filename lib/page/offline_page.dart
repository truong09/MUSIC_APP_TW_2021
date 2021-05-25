import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_music_app/model/AuthenticationFirebase.dart';
import 'package:my_music_app/model/helpers/song_hepler.dart';
import 'package:my_music_app/model/song.dart';
import 'file:///E:/FlutterProjects/my_music_app/lib/page/album/album.dart';

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
          Mtag(
            lable: "Danh sách phát",
            icon: Icons.ac_unit,
            color: Colors.blue,
            onpressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return PLaylistPage();
                },
              ));
            },
          ),
        ],
      ),
    );
  }
}
