import 'package:flutter/material.dart';
import 'package:my_music_app/model/service/song_service.dart';
import 'package:my_music_app/model/singer.dart';
import 'package:my_music_app/page/singer/singer_detail.dart';
import '../../comon_variable.dart';
import 'file:///E:/FlutterProjects/my_music_app/lib/page/album/album_detail.dart';
import 'package:my_music_app/widgets/minibar.dart';

class SingerPage extends StatefulWidget {
  @override
  _SingerPageState createState() => _SingerPageState();
}

class _SingerPageState extends State<SingerPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: SongService().getSingerName(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Singer> singers = snapshot.data;
                    return ListView.builder(
                      itemCount: singers.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                              height: 50,
                              width: 50,
                              child: Image.network(
                                singers[index].img,
                                fit: BoxFit.cover,
                              )),
                          title: Text(singers[index].name),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SingerDetail(
                                    name: singers[index].name,
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
