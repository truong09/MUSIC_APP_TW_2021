import 'package:my_music_app/data/track_library.dart';
import 'package:my_music_app/model/song.dart';

convertSongToTrack(List<Song> song, int index) {
  Map<int, Track> map = new Map();
  int i = 0;
  for (int z = index; z < song.length; z++) {
    map[i] = Track.fromSong(song[z]);
    i++;
  }
  return map;
}

convertStringPlayListToName(String playlist) {
  List<String> playlistName = [];
  String temp = playlist.replaceAll("(", "").replaceAll(")", "");
  playlistName = temp.split(", ");
  return playlistName;
}
