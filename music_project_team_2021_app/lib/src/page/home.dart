import 'package:flutter/material.dart';
import 'package:music_project_team_2021_app/src/constants/temp_varible.dart';
import 'package:music_project_team_2021_app/src/core/get_local_music.dart';
import 'package:music_project_team_2021_app/src/core/get_permision.dart';
import 'package:music_project_team_2021_app/src/core/shared_referance/song_now.dart';
import 'package:music_project_team_2021_app/src/core/stream/song_stream.dart';
import 'package:music_project_team_2021_app/src/model/song_model.dart';

import 'package:music_project_team_2021_app/src/widgets/list_song.dart';
import 'package:music_project_team_2021_app/src/widgets/m_bottom_tab_bar.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSong songStream = new StreamSong();
  Song currentSong;
  Icon cusIcon = Icon(
    Icons.search,
    color: Colors.blue,
  );

  Widget cusText = Text(
    "Danh sach nhac cua toi",
    style: TextStyle(color: Colors.black),
  );

  @override
  void initState() {
    super.initState();
    getPerMision();
    getLocalMusic();
  }

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
                  if (this.mounted) {
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
                  }
                }),
          ],
        ),
        bottomNavigationBar: StreamBuilder<Song>(
            stream: songStream.songStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new MBottomTabBar(song: snapshot.data);
              } else if (!snapshot.hasData) {
                FutureBuilder(
                  future: SongNow().getSong(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return new MBottomTabBar(song: currentSong);
                    }
                    return Container(
                      height: 0.0,
                    );
                  },
                );
              }
              if (snapshot.hasError) {
                return Container(
                  height: 5,
                  color: Colors.blue,
                );
              }
              return new MBottomTabBar(song: snapshot.data);
            }),
        body: TabBarView(
            children: [ListSong(), Container(), Container(), Container()]),
      ),
    );
  }
}
