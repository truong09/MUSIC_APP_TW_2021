// import 'package:audioplayersaudioservice/features/audio_track/domain/entities/audio_track.dart';

import 'package:my_music_app/features/audio_track/domain/entities/audio_track.dart';

class AudioTrackModel extends AudioTrack {
  AudioTrackModel(String url, String author, String title,
      int currentTrackIndex, String id, String art)
      : super(url, author, title, currentTrackIndex, id, art);
}
