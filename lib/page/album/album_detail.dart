import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_music_app/core/convert.dart';
import 'package:my_music_app/data/track_library.dart';
import 'package:my_music_app/features/media_player/bloc/media_player_cubit.dart';
import 'package:my_music_app/injection_container.dart';
import 'package:my_music_app/model/service/song_service.dart';
import 'package:my_music_app/model/song.dart';
import 'package:my_music_app/widgets/minibar.dart';

class AlbumDetail extends StatefulWidget {
  String name;
  AlbumDetail({this.name});
  @override
  _AlbumDetailState createState() => _AlbumDetailState();
}

class _AlbumDetailState extends State<AlbumDetail> {
  List<Song> songs = [];
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
          return MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(widget.name),
                centerTitle: true,
              ),
              body: SafeArea(
                child: Stack(children: [
                  Container(
                    child: FutureBuilder(
                      future: SongService().getSongInAlbum(widget.name),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          songs = snapshot.data;
                          return ListView.builder(
                            itemCount: songs.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(songs[index].name),
                                onTap: () {
                                  BlocProvider.of<MediaPlayerCubit>(context)
                                      .stopFromIsolate();
                                  print('pause tap');
                                  TrackLibrary.playList = {};

                                  TrackLibrary.playList =
                                      convertSongToTrack(songs, index);

                                  TrackLibrary.playList.forEach((key, value) {
                                    print("$key, ${value.title}");
                                  });

                                  BlocProvider.of<MediaPlayerCubit>(context)
                                      .play();
                                  print("tap play");
                                  SongService().updateFigure(songs[index].id);
                                },
                              );
                            },
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
