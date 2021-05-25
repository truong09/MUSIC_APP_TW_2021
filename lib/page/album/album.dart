import 'package:flutter/material.dart';
import 'package:my_music_app/model/service/song_service.dart';
import 'file:///E:/FlutterProjects/my_music_app/lib/page/album/album_detail.dart';
import 'package:my_music_app/widgets/minibar.dart';

class AlbumPage extends StatefulWidget {
  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Album",
            style: TextStyle(color: Colors.blue),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: SongService().getAlbumName(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<String> albumName = snapshot.data;
                    return ListView.builder(
                      itemCount: albumName.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.home),
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
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Positioned(
              child: MiniBar(),
              bottom: 0,
              right: 0,
              left: 0,
            ),
          ]),
        ),
      ),
    );
  }
}
