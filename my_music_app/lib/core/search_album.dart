import 'package:my_music_app/model/singer.dart';

findAlbumByName(String words, List<String> list) {
  List<String> temp = [];
  if (list.length >= 0 && words != null && words != "") {
    list.forEach((element) {
      if ((element.toLowerCase()).contains(words.toLowerCase())) {
        temp.add(element);
      }
    });
    return temp;
  }

  return list;
}

findSinger(String words, List<Singer> singers) {
  List<Singer> temp = [];
  if (singers.length > 0 && words != null && words != "") {
    singers.forEach((element) {
      print(element.name);
      if ((element.name.toLowerCase()).contains(words.toLowerCase())) {
        temp.add(element);
      }
    });
    return temp;
  }

  return singers;
}

findGender(String words, List<String> gender) {
  List<String> temp = [];
  if (gender.length > 0 && words != null && words != "") {
    gender.forEach((element) {
      if ((element.toLowerCase()).contains(words.toLowerCase())) {
        temp.add(element);
      }
    });
    return temp;
  }

  return gender;
}
