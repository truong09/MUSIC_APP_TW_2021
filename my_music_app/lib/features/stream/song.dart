// import 'dart:async';

// import 'package:my_music_app/core/getSongFromId.dart';
// import 'package:my_music_app/model/song.dart';

// class SongStream {
//   List<Song> song;
//   StreamController songController =
//       new StreamController<List<Song>>.broadcast();
//   Stream get songStream => songController.stream;
//   change(List<dynamic> ids) async {
//     song = await getSongFromId(ids);
//     songController.sink.add(song);
//   }
// }
