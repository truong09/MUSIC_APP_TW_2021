import 'package:my_music_app/model/song.dart';

class TrackLibrary {
  static var playList = {};
}

class Track {
  final String url;
  final String author;
  final String title;
  final String id;

  Track(this.url, this.author, this.title, this.id);
  factory Track.fromSong(Song song) {
    return Track(song.path, song.singer, song.name, song.id);
  }
}
