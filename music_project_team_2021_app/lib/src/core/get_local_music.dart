import 'dart:io';

getLocalMusic() {
  Directory dir = Directory('/storage/emulated/0/');
  String mp3Path = dir.toString();
  print(mp3Path);
  List<FileSystemEntity> _files;
  List<FileSystemEntity> _songs = [];
  _files = dir.listSync(recursive: true, followLinks: false);
  for (FileSystemEntity entity in _files) {
    String path = entity.path;
    if (path.endsWith('.mp3')) _songs.add(entity);
  }
  print(_songs);
  print(_songs.length);
}
