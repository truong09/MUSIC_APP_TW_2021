import 'package:flutter/material.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'package:music_project_team_2021_app/src/constants/temp_varible.dart';
import 'package:music_project_team_2021_app/src/core/list_singer_to_text.dart';
import 'package:music_project_team_2021_app/src/core/play_song.dart';
import 'package:music_project_team_2021_app/src/model/song_model.dart';

class NoticationSong extends StatefulWidget {
  NoticationSong({this.song});
  Song song;
  @override
  _NoticationSongState createState() => new _NoticationSongState();
}

class _NoticationSongState extends State<NoticationSong> {
  PlaySong _playSong = PlaySong();

  @override
  void initState() {
    super.initState();

    MediaNotification.setListener('pause', () {
      setState(() => _playSong.pausePlaying());
    });

    MediaNotification.setListener('play', () {
      setState(() => _playSong.continuePlaying());
    });

    MediaNotification.setListener('prev', () {
      indexOfSongNow--;
      if (indexOfSongNow <= 0) {
        indexOfSongNow = songsOffline.length - 1;
      }
      _playSong.playSoundNewSong(path: songsOffline[indexOfSongNow].path);
    });
    MediaNotification.setListener('next', () {
      indexOfSongNow++;
      if (indexOfSongNow >= songsOffline.length) {
        indexOfSongNow = 0;
      }
      _playSong.playSoundNewSong(path: songsOffline[indexOfSongNow].path);
    });

    MediaNotification.setListener('select', () {});

    MediaNotification.showNotification(
        title: widget.song.name, author: singer(widget.song));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }
}
