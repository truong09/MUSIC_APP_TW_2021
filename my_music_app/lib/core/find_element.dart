import 'package:my_music_app/model/song.dart';

findAlbumNameExist(String albumName, List<String> list) {
  if (list.length > 0) {
    list.forEach((element) {
      if (element == albumName) {
        print("day la test find_element");
        print(element);
        print(albumName);
        print("Keets thucs");
        return true;
      }
    });
  }
  return false;
}
