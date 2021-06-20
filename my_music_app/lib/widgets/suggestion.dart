import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_music_app/core/convert.dart';
import 'package:my_music_app/data/track_library.dart';
import 'package:my_music_app/features/media_player/bloc/media_player_cubit.dart';
import 'package:my_music_app/injection_container.dart';
import 'package:my_music_app/model/service/song_service.dart';
import 'package:my_music_app/model/song.dart';

class Suggestion extends StatefulWidget {
  @override
  _SuggestionState createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: serviceLocator<MediaPlayerCubit>()),
      ],
      child: BlocBuilder<MediaPlayerCubit, MediaPlayerStateAbstract>(
        builder: (context, mediaPlayerState) {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: FutureBuilder(
                future: SongService().getTopSong(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return MSguggestion(
                          song: snapshot.data[index],
                          onpressed: () {
                            BlocProvider.of<MediaPlayerCubit>(context)
                                .stopFromIsolate();
                            print('pause tap');
                            TrackLibrary.playList = {};

                            TrackLibrary.playList =
                                convertSongToTrack(snapshot.data, index);

                            TrackLibrary.playList.forEach((key, value) {
                              print("$key, ${value.title}");
                            });

                            BlocProvider.of<MediaPlayerCubit>(context).play();
                            print("tap play");
                            SongService().updateFigure(snapshot.data[index].id);
                          },
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          );
        },
      ),
    );
  }
}

class MSguggestion extends StatelessWidget {
  final Song song;
  final Function onpressed;
  MSguggestion({this.song, this.onpressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onpressed();
      },
      child: Container(
        // color: Colors.blue,
        width: 100,
        height: 150,
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(children: [
          Container(
              width: 80,
              height: 80,
              child: Image.network(song.artImage, fit: BoxFit.cover)),
          Expanded(
            child: Text(
              song.name,
              textAlign: TextAlign.center,
              // overflow: TextOverflow.ellipsis,
            ),
          )
        ]),
      ),
    );
  }
}
