import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_music_app/core/convert.dart';
import 'package:my_music_app/data/track_library.dart';
import 'package:my_music_app/features/media_player/bloc/media_player_cubit.dart';
import 'package:my_music_app/model/service/playlist_service.dart';
import 'package:my_music_app/model/service/song_service.dart';
import 'package:my_music_app/model/song.dart';
import 'package:my_music_app/widgets/add_song_to_playList.dart';

import '../injection_container.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchKey;
  mStream() {
    if (searchKey == null) return null;
    return SongService.ref
        .where('name', isGreaterThanOrEqualTo: searchKey)
        .snapshots();
  }

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
              body: SafeArea(
                child: Column(
                  children: [
                    Container(
                      child: TextField(
                        autofocus: true,
                        onChanged: (value) {
                          setState(() {
                            searchKey = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                      stream: mStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Không thể tìm kiếm!"),
                          );
                        } else if (snapshot.hasData &&
                            searchKey != null &&
                            searchKey != "") {
                          return Container(
                            child: ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                return Slidable(
                                  actionPane: SlidableDrawerActionPane(),
                                  secondaryActions: [
                                    IconSlideAction(
                                      caption: 'Playlist',
                                      color: Colors.blue,
                                      icon: Icons.playlist_add,
                                      onTap: () {
                                        addSongToPlaylist(context,
                                            snapshot.data.docs[index]['id']);
                                      },
                                    ),
                                  ],
                                  child: ListTile(
                                    title:
                                        Text(snapshot.data.docs[index]['name']),
                                    onTap: () async {
                                      List<Song> songs = await SongService()
                                          .getSong(
                                              20,
                                              int.parse(snapshot
                                                  .data.docs[index]['id']));
                                      print("day la songs se phat moi");
                                      print(songs.length);
                                      BlocProvider.of<MediaPlayerCubit>(context)
                                          .stopFromIsolate();
                                      print('pause tap');
                                      TrackLibrary.playList = {};

                                      TrackLibrary.playList =
                                          convertSongToTrack(songs, index);

                                      TrackLibrary.playList
                                          .forEach((key, value) {
                                        print("$key, ${value.title}");
                                      });

                                      BlocProvider.of<MediaPlayerCubit>(context)
                                          .play();
                                      print("tap play");
                                      SongService()
                                          .updateFigure(songs[index].id);
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }

                        return Container();
                      },
                    )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
