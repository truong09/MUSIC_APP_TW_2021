import 'package:my_music_app/comon_variable.dart';
import 'package:my_music_app/data/track_library.dart';
import 'package:my_music_app/model/song.dart';

convertSongToTrack(List<Song> song, int index) {
  Map<int, Track> map = new Map();
  int i = 0;
  for (int z = index; z < song.length; z++) {
    if (song[z].artImage == "" || song[z].artImage == null) {
      song[z].artImage = defaultImage;
    }
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

String printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}
