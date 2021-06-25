import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_music_app/core/convert.dart';
import 'package:my_music_app/data/track_library.dart';
import 'package:my_music_app/features/media_player/bloc/media_player_cubit.dart';
import 'package:my_music_app/injection_container.dart';
import 'package:my_music_app/model/service/song_service.dart';
import 'package:my_music_app/model/song.dart';
import 'package:my_music_app/widgets/add_song_to_playList.dart';
import 'package:my_music_app/widgets/newSong.dart';

class OnlinePage extends StatefulWidget {
  @override
  _OnlinePageState createState() => _OnlinePageState();
}

class _OnlinePageState extends State<OnlinePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.4,
      // width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                "https://raw.githubusercontent.com/ankitkanojia/DotNetCharts/master/chart.jpg")),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Bài hát mới",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 30, color: Colors.blue),
            ),
            Expanded(flex: 1, child: NewSong()),
            Expanded(flex: 3, child: ChartSong()),
          ],
        ),
      ),
    );
  }
}

class ChartSong extends StatefulWidget {
  @override
  _ChartSongState createState() => _ChartSongState();
}

class _ChartSongState extends State<ChartSong> {
  List<Song> chartSongs = [];

  @override
  void initState() {
    super.initState();
    //getList();
  }

  // getList() async {
  //   await ;

  // }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: serviceLocator<MediaPlayerCubit>()),
      ],
      child: BlocBuilder<MediaPlayerCubit, MediaPlayerStateAbstract>(
        builder: (context, mediaPlayerState) {
          return Container(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Text(
                  "Bảng xếp hạng trong tuần",
                  style: TextStyle(fontSize: 30),
                ),
                Container(
                  // color: Colors.amberAccent,
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 50),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.blue,
                          // Colors.red,
                          Colors.green,
                          // Colors.yellow
                        ],
                      ),
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: FutureBuilder(
                    future: SongService().chartSong(),
                    builder: (context, snapshot) {
                      int rank = 0;
                      if (snapshot.hasData) {
                        chartSongs = snapshot.data;
                        print("day la phan tu mang");
                        chartSongs.forEach((element) {
                          print(element.id);
                          print(element.name);
                        });
                        return ListView.builder(
                          itemCount: chartSongs.length,
                          itemBuilder: (context, index) {
                            rank = index;
                            return Slidable(
                              secondaryActions: [
                                IconSlideAction(
                                  caption: 'Playlist',
                                  color: Colors.blue,
                                  icon: Icons.playlist_add,
                                  onTap: () {
                                    addSongToPlaylist(
                                        context, chartSongs[index].id);
                                  },
                                ),
                              ],
                              actionPane: SlidableDrawerActionPane(),
                              child: ListTile(
                                onTap: () {
                                  BlocProvider.of<MediaPlayerCubit>(context)
                                      .stopFromIsolate();
                                  print('pause tap');

                                  TrackLibrary.playList = {};

                                  TrackLibrary.playList =
                                      convertSongToTrack(chartSongs, index);

                                  TrackLibrary.playList.forEach((key, value) {
                                    print("$key, ${value.title}");
                                  });

                                  BlocProvider.of<MediaPlayerCubit>(context)
                                      .play();
                                  print("tap play");
                                  print(index);
                                  SongService()
                                      .updateFigure(chartSongs[index].id);
                                },
                                title: Text(
                                  chartSongs[index].name,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                                subtitle:
                                    Text(chartSongs[index].singer ?? "Unknown"),
                                trailing: Icon(Icons.sync_alt_outlined),
                                leading: Container(
                                  width: 90,
                                  height: 90,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 30,
                                        child: Text(
                                          (rank + 1).toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child: Image.network(
                                          chartSongs[index].artImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
