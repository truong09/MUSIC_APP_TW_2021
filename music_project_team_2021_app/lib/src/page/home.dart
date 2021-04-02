import 'package:flutter/material.dart';
import 'package:music_project_team_2021_app/src/model/song_model.dart';

import 'package:music_project_team_2021_app/src/widgets/list_song.dart';
import 'package:music_project_team_2021_app/src/widgets/m_bottom_tab_bar.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Icon cusIcon = Icon(
    Icons.search,
    color: Colors.blue,
  );
  Song song = Song(name: "Như phút ban đầu", singer: "Noo Phước Thịnh");
  Widget cusText = Text(
    "Danh sach nhac cua toi",
    style: TextStyle(color: Colors.black),
  );
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: cusText,
          bottom: TabBar(
            isScrollable: false,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontSize: 16),
            tabs: [
              Tab(
                text: 'Bài hát',
              ),
              Tab(
                text: 'Album',
              ),
              Tab(
                text: 'Ca sĩ',
              ),
              Tab(
                text: 'PlayLists',
              )
            ],
          ),
          actions: [
            IconButton(
                icon: cusIcon,
                onPressed: () {
                  // getLocalMusic();
                  setState(() {
                    if (this.cusIcon.icon == Icons.search) {
                      this.cusIcon = Icon(
                        Icons.clear,
                        color: Colors.blue,
                      );
                      this.cusText = TextField(
                        autofocus: true,
                      );
                    } else {
                      this.cusIcon = Icon(
                        Icons.search,
                        color: Colors.blue,
                      );
                      this.cusText = Text(
                        'Danh sach bai hat cua to',
                        style: TextStyle(color: Colors.black),
                      );
                    }
                  });
                }),
          ],
        ),
        bottomNavigationBar: MBottomTabBar(song: song),
        body: Stack(children: [
          TabBarView(
              children: [ListSong(), Container(), Container(), Container()]),
        ]),
      ),
    );
  }
}
