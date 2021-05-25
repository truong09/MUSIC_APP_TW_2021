import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_music_app/core/convert.dart';
import 'package:my_music_app/data/track_library.dart';
import 'package:my_music_app/features/media_player/bloc/media_player_cubit.dart';
import 'package:my_music_app/injection_container.dart';
import 'package:my_music_app/model/service/song_service.dart';
import 'package:my_music_app/model/song.dart';

class OnlinePage extends StatefulWidget {
  @override
  _OnlinePageState createState() => _OnlinePageState();
}

class _OnlinePageState extends State<OnlinePage> {
  @override
  void initState() {
    super.initState();
  }

  // getList() async {
  //   await SongService().getTopSong();
  //   await SongService().getNewSong();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.4,
      // width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: HotSong(),
          ),
          Expanded(
            child: NewSong(),
          ),
        ],
      ),
    );
  }
}

class HotSong extends StatefulWidget {
  @override
  _HotSongState createState() => _HotSongState();
}

class _HotSongState extends State<HotSong> {
  List<Song> hotSong = [];

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
          var _playCallback = () async {
            print('play tap');
          };

          var _pauseCallback = () {
            BlocProvider.of<MediaPlayerCubit>(context).pause();
            print('pause tap');
          };
          return Container(
            color: Colors.blue,
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Text("Nhạc hot trong tuần"),
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: FutureBuilder(
                    future: SongService().getTopSong(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        hotSong = snapshot.data;
                        return ListView.builder(
                          itemCount: hotSong.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                BlocProvider.of<MediaPlayerCubit>(context)
                                    .stopFromIsolate();
                                print('pause tap');
                                TrackLibrary.playList = {};
                                setState(() {
                                  TrackLibrary.playList =
                                      convertSongToTrack(hotSong, index);
                                });
                                TrackLibrary.playList.forEach((key, value) {
                                  print("$key, ${value.title}");
                                });

                                print(TrackLibrary.playList[0].title);
                                BlocProvider.of<MediaPlayerCubit>(context)
                                    .play();
                                print("tap play");
                                SongService().updateFigure(hotSong[index].id);
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                height: 35,
                                // color: Colors.white,
                                child: Text(hotSong[index].name),
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

class NewSong extends StatefulWidget {
  @override
  _NewSongState createState() => _NewSongState();
}

class _NewSongState extends State<NewSong> {
  List<Song> hotSong = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Text("Nhạc mới trong tuần"),
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            child: FutureBuilder(
              future: SongService().getNewSong(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  hotSong = snapshot.data;
                  return ListView.builder(
                    itemCount: hotSong.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Text(hotSong[index].name),
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
  }
}
