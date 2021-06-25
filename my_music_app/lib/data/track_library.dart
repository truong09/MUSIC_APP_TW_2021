import 'package:my_music_app/model/song.dart';

class TrackLibrary {
  static var playList = {};
}

class Track {
  final String url;
  final String author;
  final String title;
  final String id;
  final String art;

  Track(this.url, this.author, this.title, this.id, this.art);
  factory Track.fromSong(Song song) {
    return Track(song.path, song.singer, song.name, song.id, song.artImage);
  }
}
