import 'package:flutter/material.dart';
import 'package:my_music_app/core/search_album.dart';
import 'package:my_music_app/model/service/song_service.dart';
import 'package:my_music_app/page/album/album_detail.dart';

class AlbumPage extends StatefulWidget {
  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  List<String> albumName = [];
  List<String> temp = [];
  String word;

  @override
  void initState() {
    super.initState();
    intAlbum();
  }

  intAlbum() async {
    // temp = await SongService().getAlbumName();
    // albumName = await SongService().getAlbumName();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Album",
            style: TextStyle(color: Colors.blue),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Tìm theo tên album",
                    prefixIcon: Icon(Icons.search),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      // temp = findAlbumByName(value, albumName);
                      // print(albumName.toString());
                      word = value;
                    });
                  },
                ),
              ),
              Expanded(
                // height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                    future: SongService().getAlbumName(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        temp = snapshot.data;
                        albumName = findAlbumByName(word, temp);
                        return ListView.builder(
                          itemCount: albumName.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Icon(Icons.album_sharp),
                              title: Text(albumName[index]),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AlbumDetail(
                                        name: albumName[index],
                                      ),
                                    ));
                              },
                            );
                          },
                        );
                      }

                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),

                // Positioned(
                //   child: MiniBar(),
                //   bottom: 0,
                //   right: 0,
                //   left: 0,
                // ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
