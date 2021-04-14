import 'package:flutter/material.dart';
import 'package:music_project_team_2021_app/src/constants/temp_varible.dart';
import 'package:music_project_team_2021_app/src/core/get_local_music.dart';
import 'package:music_project_team_2021_app/src/core/list_singer_to_text.dart';
import 'package:music_project_team_2021_app/src/core/play_song.dart';
import 'package:music_project_team_2021_app/src/core/stream/song_stream.dart';
import 'package:music_project_team_2021_app/src/model/song_model.dart';

class ListSong extends StatefulWidget {
  @override
  _ListSongState createState() => _ListSongState();
}

class _ListSongState extends State<ListSong> {
  final songStream = StreamSong();
  final PlaySong playSongController = PlaySong();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: FutureBuilder(
        future: getLocalMusic(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Song> songs = snapshot.data;
            songsOffline = snapshot.data;
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    songnow = songs[index];

                    songStream.changesong(songs[index]);
                    playSongController.isPlaying = false;
                    playSongController.playSoundNewSong(
                        path: songs[index].path);
                    playSongController.isPlaying = true;
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(songs[index].name),
                      subtitle: Text(singer(songs[index])),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
