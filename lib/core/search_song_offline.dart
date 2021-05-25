import 'package:my_music_app/model/song.dart';

findByName(String words, List<Song> songs) {
  if (songs.length >= 0 && words != null) {
    List<Song> temp = [];
    songs.forEach((element) {
      if (element.name.contains(words)) {
        temp.add(element);
      }
      if (element.singer.contains(words)) {
        temp.add(element);
      }
    });
    return temp;
  }
  return songs;
}
