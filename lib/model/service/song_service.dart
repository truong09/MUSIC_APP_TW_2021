import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_music_app/core/find_element.dart';
import 'package:my_music_app/model/helpers/song_hepler.dart';
import 'package:my_music_app/model/song.dart';

class SongService {
  static final ref = FirebaseFirestore.instance.collection("song_data");
  getASong(String id) async {
    Song temp;

    await ref.where('id', isEqualTo: id).get().then((value) {
      value.docs.forEach((element) async {
        temp = Song.fromJson(element.data());
      });
    });
    final reft = FirebaseStorage.instance.ref().child("${temp.id}.mp3");
    await reft.getDownloadURL().then((value) {
      temp.path = value;
    });
    return temp;
  }

  Future<List<Song>> getSong(int limit, int idNow) async {
    List<Song> temp = [];
    print("day la danh sach $idNow");
    await ref
        .where('id', isGreaterThanOrEqualTo: idNow.toString())
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(element.data().toString());
        Song tempSong = Song.fromJson(element.data());
        temp.add(tempSong);
      });
    });
    for (int i = 0; i < temp.length; i++) {
      final ref = FirebaseStorage.instance.ref().child("${temp[i].id}.mp3");
      await ref.getDownloadURL().then((value) {
        temp[i].path = value;
      });
    }

    print(temp.length);
    return temp;
  }

  getAlbumName() async {
    List<String> album = [];
    await ref.get().then((value) {
      value.docs.forEach((element) {
        print(element['album'].toString());
        if (findAlbumNameExist(element['album'], album) == false) {
          album.add(element['album']);
        }
      });
    });
    print(album.length);
    return album;
  }

  getSongInAlbum(String albumName) async {
    List<Song> songs = [];

    await ref.where('album', isEqualTo: albumName).get().then((value) {
      value.docs.forEach((element) {
        songs.add(Song.fromJson(element.data()));
      });
    });
    for (int i = 0; i < songs.length; i++) {
      final ref = FirebaseStorage.instance.ref().child("${songs[i].id}.mp3");
      await ref.getDownloadURL().then((value) {
        songs[i].path = value;
      });
    }
    return songs;
  }

  getSingerName() async {
    List<String> album = [];
    await ref.get().then((value) {
      value.docs.forEach((element) {
        print(element['singer'].toString());
        if (findAlbumNameExist(element['singer'], album) == false) {
          album.add(element['singer']);
        }
      });
    });

    return album;
  }

  getSongInSinger(String albumName) async {
    List<Song> songs = [];

    await ref.where('singer', isEqualTo: albumName).get().then((value) {
      value.docs.forEach((element) {
        songs.add(Song.fromJson(element.data()));
      });
    });
    for (int i = 0; i < songs.length; i++) {
      final ref = FirebaseStorage.instance.ref().child("${songs[i].id}.mp3");
      await ref.getDownloadURL().then((value) {
        songs[i].path = value;
      });
    }
    return songs;
  }

  Future<List<Song>> getTopSong() async {
    List<Song> temp = [];
    await ref
        .limit(10)
        .orderBy("figure", descending: true)
        .get()
        .then((value) async {
      value.docs.forEach((element) async {
        // print(element.data());

        Song tempSong = Song.fromJson(element.data());
        temp.add(tempSong);
      });
      // print(path);
      // String path =
      //     await StoragePath().getUrl((element.data()['id'].toString()));
      // tempSong.path = path;
    });
    for (int i = 0; i < temp.length; i++) {
      final ref = FirebaseStorage.instance.ref().child("${temp[i].id}.mp3");
      await ref.getDownloadURL().then((value) {
        temp[i].path = value;
      });
    }
    return temp;
  }

  Future<List<Song>> getNewSong() async {
    List<Song> temp = [];
    await ref.orderBy("upload_date", descending: false).get().then((value) {
      value.docs.forEach((element) {
        // print(element.data());
        temp.add(Song.fromJson(element.data()));
      });
    });
    return temp;
  }

  updateFigure(String id) async {
    String figure;
    await ref.where('id', isEqualTo: id).get().then((value) {
      figure = (value.docs[0].data()['figure']).toString();
    });
    await ref
        .doc(id)
        .set({'figure': (int.parse(figure) + 1)}, SetOptions(merge: true)).then(
            (value) {
      print("da tang luot nghe");
    });
  }
}
