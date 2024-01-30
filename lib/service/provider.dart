import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../data/models/tracks_model.dart';
import '../data/service.dart';

class SongsProvider extends ChangeNotifier {
  List<Data>? _trackList;
  List<bool>? _isPlayingList;
  AudioPlayer _audioPlayer = AudioPlayer();
  int? _currentlyPlayingIndex;

  int? get currentlyPlayingIndex => _currentlyPlayingIndex;
  List<Data>? get trackList => _trackList;
  List<bool>? get isPlayingList => _isPlayingList;

  Future<void> getData() async {
    _trackList = await SongsService().fetchData();
    _isPlayingList = List.generate(_trackList!.length, (index) => false);

    notifyListeners();
  }
  void playPause(List<Data>? trackList, List<bool>? isPlayingList, int index) {
    if (_currentlyPlayingIndex != null && _currentlyPlayingIndex != index) {
      _audioPlayer.stop();
      isPlayingList![_currentlyPlayingIndex!] = false;
      notifyListeners();
    }

    isPlayingList![index] = !isPlayingList[index];
    _currentlyPlayingIndex = isPlayingList[index] ? index : null;

    if (isPlayingList[index]) {
      _audioPlayer.play(UrlSource(trackList![index].preview!));
      _currentlyPlayingIndex = index;

    } else {
      _audioPlayer.pause();
      _currentlyPlayingIndex = index;

    }

    notifyListeners();
  }

}
