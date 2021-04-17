import 'dart:async';

import 'package:music_project_team_2021_app/src/model/song_model.dart';

import '../play_song.dart';
import '../shared_referance/song_now.dart';

class StreamSong {
  Song song = new Song();

  StreamController songController = new StreamController<Song>.broadcast();

  static final StreamSong _instance = StreamSong._internal();

  factory StreamSong() => _instance;

  StreamSong._internal();

  Stream get songStream => songController.stream;
  final PlaySong playSongController = PlaySong();
  changesong(Song newSong) {
    song = newSong;
    playSongController.pausePlaying();
    SongNow().saveSong(newSong);
    playSongController.playSoundNewSong(path: newSong.path);
    songController.sink.add(song);
  }

  void dispose() {
    songController.close();
  }
}
