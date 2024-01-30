
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'package:songapp/view/widgets/song_player.dart';
import '../../data/models/tracks_model.dart';
import '../../provider/provider.dart';


class ListOfSongs extends StatefulWidget {
  List<Data>? trackList;
  List<bool>? isPlayingList;

  ListOfSongs({Key? key, this.trackList, this.isPlayingList}) : super(key: key);

  @override
  State<ListOfSongs> createState() => _ListOfSongsState();
}

class _ListOfSongsState extends State<ListOfSongs> {
  int? currentlyPlayingIndex;
  AudioPlayer audioPlayer = AudioPlayer();
  late List<Color> gradientColors;

  @override
  Widget build(BuildContext context) {
    return Consumer<SongsProvider>(
      builder: (context, songsProvider, child) {
        return Stack(
          children: [
            ListView.builder(
              itemCount: widget.trackList?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: songsProvider.isPlayingList![index]
                            ? Colors.pinkAccent
                            : Colors.white,
                        child: IconButton(
                          icon: Icon(
                            songsProvider.isPlayingList![index]
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: songsProvider.isPlayingList![index]
                                ? Colors.white
                                : Colors.pinkAccent,
                          ),
                          onPressed: () {
                            songsProvider.playPause(
                                widget.trackList, widget.isPlayingList, index);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.trackList![index].title.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            widget.trackList![index].artist!.name.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Text(
                    formatDuration(widget.trackList![index].duration!.toInt()),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                  onTap: () {
                    songsProvider.playPause(
                        widget.trackList, widget.isPlayingList, index);
                  },
                );
              },
            ),

        songsProvider.currentlyPlayingIndex != null ?   Positioned(
              left: 5,
              right: 5,
              bottom: 4,
              child: Container(
                height: 70,
                width: 40,
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    transform: GradientRotation(1),
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xFF9D9DA0).withOpacity(0.9),
                      Color(0xFF3B3B3B),
                      Color(0xFF3B3B3B),
                      Color(0xFF3B3B3B),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(
                      8.0), // Adjust the border radius
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      bottom: 2,
                      child: SongPlayer(songsProvider: songsProvider),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3), // Shadow color
                              spreadRadius: 2,  // Spread radius
                              blurRadius: 5,    // Blur radius
                              offset: Offset(0, -2), // Offset in the x and y directions
                            ),
                          ],
                        ),
                        child: LinearProgressIndicator(
                          value: 0.5,
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                        ),
                      ),
                    ),
                  ],
                )

              ),
            ) : Container(),
          ],
        );
      },
    );
  }

  String formatDuration(int duration) {
    int minutes = (duration ~/ 60);
    int seconds = (duration % 60);
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}