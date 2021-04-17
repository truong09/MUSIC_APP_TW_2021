import 'dart:io';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:music_project_team_2021_app/src/core/get_permision.dart';
import 'package:music_project_team_2021_app/src/model/song_model.dart';

import '../constants/temp_varible.dart';

getLocalMusic() async {
  getPerMision();
  List<Song> song = new List();
  var retriever = new MetadataRetriever();
  Directory dir = Directory('/storage/emulated/0/CSNMusic/Download/Music');
  String mp3Path = dir.toString();
  print(mp3Path);
  List<FileSystemEntity> _files;
  List<FileSystemEntity> _songs = [];
  _files = dir.listSync(recursive: true, followLinks: false);
  for (FileSystemEntity entity in _files) {
    String path = entity.path;
    if (path.endsWith('.mp3')) _songs.add(entity);
  }
  for (int i = 0; i < _songs.length; i++) {
    await retriever.setFile(new File(_songs[i].path));
    Metadata metadata = await retriever.metadata;

    // print(metadata.albumArtistName); //album
    // print(metadata.albumLength);
    // print(metadata.albumName);
    // print(metadata.authorName); //nguoi sang tac
    // print(metadata.bitrate);
    // print(metadata.discNumber);
    // print(metadata.genre); //the loai
    // print(metadata.mimeType);
    // //ca si
    // print(metadata.trackArtistNames);
    // //thowi luong
    // print(metadata.trackDuration);
    print(metadata.trackName); //ten bai hat
    // print(metadata.trackNumber);
    // print(metadata.writerName);
    song.add(new Song(
      name: metadata.trackName,
      album: metadata.albumArtistName,
      artist: metadata.writerName,
      singer: metadata.trackArtistNames,
      path: _songs[i].path,
      gener: metadata.genre,
    ));
    songsOffline = song;
  }
  return song;
}
