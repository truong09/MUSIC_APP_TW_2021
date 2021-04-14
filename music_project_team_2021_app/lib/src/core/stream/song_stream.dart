import 'dart:async';

import 'package:music_project_team_2021_app/src/model/song_model.dart';

class StreamSong {
  Song song = new Song();

  StreamController songController = new StreamController<Song>.broadcast();

  static final StreamSong _instance = StreamSong._internal();

  factory StreamSong() => _instance;

  StreamSong._internal();

  Stream get songStream => songController.stream;

  changesong(Song newSong) {
    song = newSong;
    print('day la stream');
    print(newSong.name);
    songController.sink.add(song);
  }

  void dispose() {
    songController.close();
  }
}
