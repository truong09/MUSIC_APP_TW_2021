import 'package:my_music_app/model/song.dart';

findByName(String words, List<Song> songs) {
  List<Song> temp = [];
  if (songs.length >= 0 && words != null && words != "") {
    songs.forEach((element) {
      print(element.singer);
      if ((element.name.toLowerCase()).contains(words.toLowerCase())) {
        temp.add(element);
      }
      if (element.singer != null) {
        if (!temp.contains(element) &&
            element.singer.toLowerCase().contains(words.toLowerCase())) {
          temp.add(element);
        }
      }
    });
  }

  return temp;
}
