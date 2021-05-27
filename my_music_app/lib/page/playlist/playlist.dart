import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_music_app/core/convert.dart';
import 'package:my_music_app/model/service/playlist_service.dart';
import 'package:my_music_app/model/service/song_service.dart';
import 'package:my_music_app/page/playlist/playlist_detail.dart';
import 'package:my_music_app/widgets/add_new_playlist.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PLaylistPage extends StatefulWidget {
  @override
  _PLaylistPageState createState() => _PLaylistPageState();
}

class _PLaylistPageState extends State<PLaylistPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        child: StreamBuilder(
          stream: PlaylistService().getMyPlaylist(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.data() != null) {
              //danh sách id của playlist;
              Map result = snapshot.data.data();
              print(result.toString());
              List<String> name =
                  convertStringPlayListToName(result.keys.toString());
              return ListView.builder(
                itemCount: name.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'Xóa',
                        color: Colors.blue,
                        icon: Icons.delete_forever,
                        onTap: () {
                          PlaylistService().deleteAPlaylist(name[index]);
                        },
                      ),
                    ],
                    child: ListTile(
                      title: Text(name[index]),
                      onTap: () {
                        print("${result[name[index]]}");
                        // PlaylistService().getAllSongOfAPlaylist(name[index]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlaylistDetail(
                                songIdOfPlaylist:
                                    result[name[index].toString()],
                                name: name[index],
                              ),
                            ));
                      },
                    ),
                  );
                },
              );
            }
            if (snapshot.hasData && snapshot.data.data() == null) {
              return Container();
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: FloatingActionButton(
          child: const Icon(Icons.playlist_add),
          onPressed: () {
            addNewPlaylist(context);
          },
        ),
      ),
    ]);
  }
}
