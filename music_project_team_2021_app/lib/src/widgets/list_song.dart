import 'package:flutter/material.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:music_project_team_2021_app/src/constants/temp_varible.dart';
import 'package:music_project_team_2021_app/src/core/get_local_music.dart';
import 'package:music_project_team_2021_app/src/core/list_singer_to_text.dart';
import 'package:music_project_team_2021_app/src/core/play_song.dart';
import 'package:music_project_team_2021_app/src/core/stream/song_stream.dart';
import 'package:music_project_team_2021_app/src/model/song_model.dart';
import 'package:music_project_team_2021_app/src/widgets/notication.dart';

class ListSong extends StatefulWidget {
  @override
  _ListSongState createState() => _ListSongState();
}

class _ListSongState extends State<ListSong> {
  final songStream = StreamSong();
  final PlaySong playSongController = PlaySong();

  @override
  void initState() {
    MediaNotification.setListener('pause', () {
      print('da nhan vao pause');
      setState(() {
        playSongController.isPlaying = false;
        playSongController.pausePlaying();
      });
    });

    MediaNotification.setListener('play', () {
      setState(() {
        playSongController.continuePlaying();
        playSongController.isPlaying = false;
      });
    });

    MediaNotification.setListener('next', () {
      indexOfSongNow++;
      if (indexOfSongNow >= songsOffline.length) {
        indexOfSongNow = 0;
      }
      songStream.changesong(songsOffline[indexOfSongNow]);
    });

    MediaNotification.setListener('prev', () {
      indexOfSongNow--;
      if (indexOfSongNow < 0) {
        indexOfSongNow = 0;
      }
      songStream.changesong(songsOffline[indexOfSongNow]);
    });

    MediaNotification.setListener('select', () {});
    super.initState();
  }

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
                    indexOfSongNow = index;
                    songStream.changesong(songs[index]);
                    NoticationSong(song: songnow);
                    playSongController.isPlaying = false;
                    playSongController.playSoundNewSong(
                        path: songs[index].path);
                    playSongController.isPlaying = true;
                    // if (this.mounted) {
                    //   setState(() {
                    //     MediaNotification.showNotification(
                    //         title: songsOffline[indexOfSongNow].name,
                    //         author: singer(songsOffline[indexOfSongNow]));
                    //   });
                    // }
                    //
                  },
                  child: Column(
                    children: [
                      StreamBuilder(
                        stream: songStream.songStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            MediaNotification.showNotification(
                                title: snapshot.data.name,
                                author: singer(snapshot.data));
                          }
                          return Container(
                            height: 0.0,
                            width: 0.0,
                          );
                        },
                      ),
                      Card(
                        child: ListTile(
                          title: Text(songs[index].name),
                          subtitle: Text(singer(songs[index])),
                        ),
                      ),
                    ],
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
