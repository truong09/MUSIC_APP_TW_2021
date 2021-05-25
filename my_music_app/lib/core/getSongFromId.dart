import 'package:my_music_app/model/service/song_service.dart';
import 'package:my_music_app/model/song.dart';

getSongFromId(List<dynamic> ids) async {
  List<Song> song = [];
  for (int i = 0; i < ids.length; i++) {
    await SongService().getASong(ids[i]).then((value) {
      song.add(value);
    });
  }
  return song;
}
