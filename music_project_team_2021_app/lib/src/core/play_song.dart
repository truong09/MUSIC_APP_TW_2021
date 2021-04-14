import 'package:audioplayers/audioplayers.dart';

class PlaySong {
  String path;
  String currentPath;
  Duration positon = new Duration();
  Duration musicLength = new Duration();
  bool isPlaying = false;
  PlaySong._();
  static final PlaySong _instance = PlaySong._();
  factory PlaySong() => _instance;
  AudioPlayer audioPlayer = AudioPlayer();

  playSoundNewSong({String path}) async {
    if (path != null) {
      await audioPlayer.pause();
      await audioPlayer.play(path);
      isPlaying = true;
    }
  }

  pausePlaying() async {
    if (isPlaying == true) {
      await audioPlayer.pause();
    }
  }

  continuePlaying() async {
    if (isPlaying == false) {
      await audioPlayer.resume();
    }
  }

  void seekToSecond(int second) {
    Duration newPos = Duration(seconds: second);
    audioPlayer.seek(newPos);
  }
}
