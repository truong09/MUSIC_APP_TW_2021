import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_music_app/core/convert.dart';
import 'package:my_music_app/data/track_library.dart';
import 'package:my_music_app/features/media_player/bloc/media_player_cubit.dart';
import 'package:my_music_app/injection_container.dart';
import 'package:my_music_app/model/service/song_service.dart';
import 'package:my_music_app/model/singer.dart';
import 'package:my_music_app/model/song.dart';
import 'package:my_music_app/widgets/add_song_to_playList.dart';
import 'package:my_music_app/widgets/firstSong.dart';
import 'package:my_music_app/widgets/minibar.dart';

// ignore: must_be_immutable
class SingerDetail extends StatefulWidget {
  Singer singer;
  SingerDetail({this.singer});
  @override
  _SingerDetailState createState() => _SingerDetailState();
}

class _SingerDetailState extends State<SingerDetail> {
  List<Song> singers = [];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: serviceLocator<MediaPlayerCubit>()),
      ],
      child: BlocBuilder<MediaPlayerCubit, MediaPlayerStateAbstract>(
        builder: (context, mediaPlayerState) {
          return MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.blue),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  "Danh sách bài hát nổi bật",
                  style: TextStyle(color: Colors.blue),
                ),
                centerTitle: true,
              ),
              body: SafeArea(
                child: Stack(children: [
                  Container(
                    child: FutureBuilder(
                      future: SongService().getSongInSinger(widget.singer.name),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          singers = snapshot.data;
                          return Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: BackgSinger(
                                  name: widget.singer.name,
                                  img: widget.singer.img,
                                  onpressed: () {
                                    BlocProvider.of<MediaPlayerCubit>(context)
                                        .stopFromIsolate();
                                    print('pause tap');
                                    TrackLibrary.playList = {};

                                    TrackLibrary.playList =
                                        convertSongToTrack(singers, 0);

                                    TrackLibrary.playList.forEach((key, value) {
                                      print("$key, ${value.title}");
                                    });

                                    BlocProvider.of<MediaPlayerCubit>(context)
                                        .play();
                                    print("tap play");
                                    SongService().updateFigure(singers[0].id);
                                  },
                                ),
                              ),
                              Divider(
                                height: 100,
                                thickness: 1,
                                color: Colors.blue,
                              ),
                              Expanded(
                                flex: 2,
                                child: ListView.builder(
                                  itemCount: singers.length,
                                  itemBuilder: (context, index) {
                                    return Slidable(
                                        secondaryActions: [
                                          IconSlideAction(
                                            caption: 'Playlist',
                                            color: Colors.blue,
                                            icon: Icons.playlist_add,
                                            onTap: () {
                                              addSongToPlaylist(
                                                  context, singers[index].id);
                                            },
                                          ),
                                        ],
                                        actionPane: SlidableDrawerActionPane(),
                                        child: ListTile(
                                          trailing:
                                              Icon(Icons.sync_alt_outlined),
                                          title: Text(singers[index].name),
                                          onTap: () {
                                            BlocProvider.of<MediaPlayerCubit>(
                                                    context)
                                                .stopFromIsolate();
                                            print('pause tap');
                                            TrackLibrary.playList = {};

                                            TrackLibrary.playList =
                                                convertSongToTrack(
                                                    singers, index);

                                            TrackLibrary.playList
                                                .forEach((key, value) {
                                              print("$key, ${value.title}");
                                            });

                                            BlocProvider.of<MediaPlayerCubit>(
                                                    context)
                                                .play();
                                            print("tap play");
                                            SongService().updateFigure(
                                                singers[index].id);
                                          },
                                        ));
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
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
        },
      ),
    );
  }
}
