import 'package:my_music_app/model/song.dart';

findAlbumNameExist(String albumName, List<String> list) {
  if (list.length > 0) {
    list.forEach((element) {
      if (element == albumName) {
        return true;
      }
    });
  }
  return false;
}
