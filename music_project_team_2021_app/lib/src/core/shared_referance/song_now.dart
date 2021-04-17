import 'package:music_project_team_2021_app/src/constants/constant.dart';
import 'package:music_project_team_2021_app/src/model/song_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SongNow {
  saveSong(Song song) async {
    if (song != null) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(sfSongKey, song.name);
    }
  }

  getSong() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(sfSongKey);
  }
}
