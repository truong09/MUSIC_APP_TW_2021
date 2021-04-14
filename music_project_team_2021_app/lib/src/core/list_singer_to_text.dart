import 'package:music_project_team_2021_app/src/model/song_model.dart';

singer(Song song) {
  String singer = song.singer[0];
  if (song.singer.length > 1) {
    for (int i = 1; i < song.singer.length; i++) {
      singer = singer + ", " + song.singer[i];
    }
  }
  return singer;
}
