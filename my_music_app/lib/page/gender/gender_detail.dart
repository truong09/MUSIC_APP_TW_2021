import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_music_app/core/convert.dart';
import 'package:my_music_app/core/search_song.dart';
import 'package:my_music_app/data/track_library.dart';
import 'package:my_music_app/features/media_player/bloc/media_player_cubit.dart';
import 'package:my_music_app/injection_container.dart';
import 'package:my_music_app/model/service/song_service.dart';

import 'package:my_music_app/model/song.dart';
import 'package:my_music_app/widgets/add_song_to_playList.dart';
import 'package:my_music_app/widgets/firstSong.dart';
import 'package:my_music_app/widgets/minibar.dart';

// ignore: must_be_immutable
class GenderDetail extends StatefulWidget {
  String genderName;
  GenderDetail({this.genderName});
  @override
  _GenderDetailState createState() => _GenderDetailState();
}

class _GenderDetailState extends State<GenderDetail> {
  List<Song> songs = [];
  List<Song> temp = [];
  @override
  void initState() {
    super.initState();
    init();
  }

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
                  "Danh sách cùng thể loại",
                  style: TextStyle(color: Colors.blue),
                ),
                centerTitle: true,
              ),
              body: SafeArea(
                child: Stack(children: [
                  Container(
                    child: FutureBuilder(
                      future: SongService().getSongInGender(widget.genderName),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          songs = snapshot.data;
                          if (temp.length == 0) {
                            temp = songs;
                          }
                          // temp = findByName("", songs);
                          return Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: BackgSinger(
                                  name: widget.genderName,
                                  onpressed: () {
                                    BlocProvider.of<MediaPlayerCubit>(context)
                                        .stopFromIsolate();
                                    print('pause tap');
                                    TrackLibrary.playList = {};

                                    TrackLibrary.playList =
                                        convertSongToTrack(songs, 0);

                                    TrackLibrary.playList.forEach((key, value) {
                                      print("$key, ${value.title}");
                                    });

                                    BlocProvider.of<MediaPlayerCubit>(context)
                                        .play();
                                    print("tap play");
                                    SongService().updateFigure(songs[0].id);
                                  },
                                ),
                              ),
                              Container(
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      temp = findByName(value, songs);
                                    });
                                  },
                                  decoration: InputDecoration(
                                      hintText:
                                          "Nhập tìm kiếm theo tên bài hát, tên ca sĩ",
                                      prefixIcon: Icon(Icons.search)),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: ListView.builder(
                                  itemCount: temp.length,
                                  itemBuilder: (context, index) {
                                    return Slidable(
                                        secondaryActions: [
                                          IconSlideAction(
                                            caption: 'Playlist',
                                            color: Colors.blue,
                                            icon: Icons.playlist_add,
                                            onTap: () {
                                              addSongToPlaylist(
                                                  context, temp[index].id);
                                            },
                                          ),
                                        ],
                                        actionPane: SlidableDrawerActionPane(),
                                        child: ListTile(
                                          trailing:
                                              Icon(Icons.sync_alt_outlined),
                                          title: Text(temp[index].name),
                                          onTap: () {
                                            BlocProvider.of<MediaPlayerCubit>(
                                                    context)
                                                .stopFromIsolate();
                                            print('pause tap');
                                            TrackLibrary.playList = {};

                                            TrackLibrary.playList =
                                                convertSongToTrack(temp, index);

                                            TrackLibrary.playList
                                                .forEach((key, value) {
                                              print("$key, ${value.title}");
                                            });

                                            BlocProvider.of<MediaPlayerCubit>(
                                                    context)
                                                .play();
                                            print("tap play");
                                            SongService()
                                                .updateFigure(temp[index].id);
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
