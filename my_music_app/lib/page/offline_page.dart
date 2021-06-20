import 'package:flutter/material.dart';
import 'package:my_music_app/page/album/album.dart';
import 'package:my_music_app/page/album/album_detail.dart';
import 'package:my_music_app/page/gender/gender.dart';

import 'package:my_music_app/page/playlist/playlist.dart';
import 'package:my_music_app/page/singer/singer.dart';
import 'package:my_music_app/widgets/suggestion.dart';
import 'package:my_music_app/widgets/tags.dart';

class OfflinePage extends StatefulWidget {
  @override
  _OfflinePageState createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Wrap(
            children: [
              Mtag(
                lable: "Album",
                icon: Icons.album,
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
                icon: Icons.person_rounded,
                color: Colors.cyan,
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
                lable: "Thể loại",
                icon: Icons.account_balance_wallet_outlined,
                color: Colors.green,
                onpressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenderPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text(
            "Có thể bạn muốn nghe",
            style: TextStyle(fontSize: 25, color: Colors.blue),
          ),
          Expanded(flex: 3, child: Suggestion()),
          Text(
            "Danh sách phát nhạc của tôi",
            style: TextStyle(fontSize: 25, color: Colors.blue),
          ),
          Expanded(
            flex: 6,
            child: Container(
              // color: Colors.yellow,
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
