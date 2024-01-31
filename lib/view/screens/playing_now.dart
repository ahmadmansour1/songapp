import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';
import '../widgets/search_widget.dart';

class PlayNowScreen extends StatelessWidget {
  const PlayNowScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final songsProvider = Provider.of<SongsProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cc3a8569ce2b4d7b7efc05573ba76f9d@2x.png'), // Set your background image
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 120, sigmaY:120), // Add blur effect
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 70.0),
                  decoration: const BoxDecoration(
                    color: Colors.transparent, // Set the background color
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                     const  Expanded(
                        child:  Center(
                          child: Text(
                            'Now Playing',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Set text color
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final selectedSong = await showSearch<String>(
                            context: context,
                            delegate: SongSearchDelegate(songsProvider.trackList!),
                          );
                          if (selectedSong != null) {
                            // Handle the selected song
                          }
                        },
                        icon: const Icon(Icons.search, color: Colors.white), // Set icon color
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background Image
                    Image.asset(
                      'assets/images/sound-wave-3.png',
                      width: double.infinity,
                      height: 60, // Adjust the height as needed
                      fit: BoxFit.cover,
                    ),
                    // Circular Avatar
                    CircleAvatar(
                      radius: 120, // Set your desired radius
                      backgroundImage: AssetImage('assets/images/cc3a8569ce2b4d7b7efc05573ba76f9d@2x.png'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite),
                      label: const Text('Follow     '),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white, width: 2.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        songsProvider.shuffleSongs();
                      },
                      icon: const Icon(Icons.shuffle),
                      label: const Text('Shuffle Play'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Text(
                  songsProvider.trackList![songsProvider.currentlyPlayingIndex ?? 0].title!,
                  style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  songsProvider.trackList![songsProvider.currentlyPlayingIndex ?? 0].artist!.name!,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Slider(
                  value: songsProvider.currentPosition.inSeconds.toDouble(),
                  onChanged: (double value) {
                    songsProvider.seekTo(Duration(seconds: value.toInt()));
                  },
                  min: 0.0,
                  max: songsProvider.totalDuration.inSeconds.toDouble(),
                  activeColor: Colors.pinkAccent,
                  inactiveColor: Colors.grey,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(50.0),
                      onTap: () {
                        songsProvider.playPause(
                            songsProvider.trackList, songsProvider.isPlayingList, songsProvider.currentlyPlayingIndex! - 1);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.skip_previous, size: 36.0, color: Colors.white),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(50.0),
                      onTap: () {
                        final newPosition = songsProvider.currentPosition - Duration(seconds: 3);
                        songsProvider.seekTo(newPosition);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 60.0),
                        child: Icon(Icons.fast_rewind_sharp, size: 36.0, color: Colors.white),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: IconButton(
                        icon: Icon(
                          songsProvider.isPlayingList![songsProvider.currentlyPlayingIndex!]
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 36.0,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          songsProvider.playPause(
                              songsProvider.trackList, songsProvider.isPlayingList, songsProvider.currentlyPlayingIndex ?? 0);
                        },
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(70.0),
                      onTap: () {
                                          },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 60.0),
                        child: Icon(Icons.fast_forward_sharp, size: 36.0, color: Colors.white),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(50.0),
                      onTap: () {
                        songsProvider.playPause(
                            songsProvider.trackList, songsProvider.isPlayingList, songsProvider.currentlyPlayingIndex! + 1);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Icon(Icons.skip_next, size: 36.0, color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
