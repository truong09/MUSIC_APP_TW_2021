import 'package:my_music_app/model/song.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

const String tableName = "song";
String id = "id";
String name = "name";
String album = "album";
String singer = 'singer';
String lengthInMiniSeconds = 'lengthInMiniSeconds';
String uploadDate = 'uploadDate';
String figure = 'figure';
String path = 'path';

class SongDB {
  SongDB._();
  static final SongDB songDB = SongDB._();
  static Database _songDatabase;
  Future<Database> get database async {
    if (_songDatabase == null) {
      _songDatabase = await initDataBase();
    }

    return _songDatabase;
  }

  Future<Database> initDataBase() async {
    String sql = '''CREATE TABLE song(
	  id text,
    name text,
    album text,
    singer text,
    lengthInMiniSeconds INTEGER,
    uploadDate text,
    figure INTEGER,
    path text
)''';
    return await openDatabase(join(await getDatabasesPath(), 'song.db'),
        onCreate: (db, version) async {
      await db.execute(sql);
    }, version: 1);
  }

  getAllSong({String word}) async {
    print("day la test tu data");
    List<Song> songs = [];
    final db = await database;
    var res;
    if (word == null) {
      res = await db.query(tableName);
    } else {
      String sql =
          "SELECT * FROM song WHERE name LIKE '%$word%' OR singer LIKE '%$word%' ";
      res = await db.rawQuery(sql);
    }
    if (res.length == 0) {
      return null;
    } else {
      print(res.length);
      res.forEach((element) {
        Song song = Song.fromJson(element);

        songs.add(song);
      });
    }

    print("day la test tu dataa ${songs.length}");

    return songs;
  }

  insertASong(Song song) async {
    final db = await database;
    var res = await db.insert(tableName, song.toJson());
    return res;
  }

  deleteAllSong() async {
    final db = await database;
    await db.delete(tableName);
  }
}
