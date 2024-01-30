import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';
import '../widgets/search_widget.dart';

class PlayNowScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final songsProvider = Provider.of<SongsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing'),

        actions: [
          IconButton(
            onPressed: () async {
              final selectedSong = await showSearch<String>(
                context: context,
                delegate: SongSearchDelegate(songsProvider.trackList!),
              );
              if (selectedSong != null) {
                print("Selected Song: $selectedSong");
              }
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 120,
            backgroundImage: NetworkImage(
              'https://media.npr.org/assets/img/2013/06/17/davidblack-ca8a5d8bac16559aadf019c79f37450f57d3ed51-s1100-c50.jpg',
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  // Handle favorite button tap
                },
                icon: Icon(Icons.favorite),
                label: Text('Follow     '),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white, side: BorderSide(
                      color: Colors.white,
                      width: 2.0), // Border width and color
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // Adjust border radius
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  songsProvider.shuffleSongs();
                },
                icon: Icon(Icons.shuffle),
                label: Text('Shuffle Play'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent, // Customize button color
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // Adjust border radius
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Text(
            songsProvider
                .trackList![songsProvider.currentlyPlayingIndex ?? 0].title!,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            songsProvider.trackList![songsProvider.currentlyPlayingIndex ?? 0]
                .artist!.name!,
            style: TextStyle(fontSize: 18, color: Colors.grey),
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
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(50.0),
                onTap: () {
                  songsProvider.playPause(
                      songsProvider.trackList,
                      songsProvider.isPlayingList,
                      songsProvider.currentlyPlayingIndex! - 1);
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.skip_previous, size: 36.0, color: Colors.white),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(50.0),
                onTap: () {
                  // Handle skip backward 3 seconds
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
                        songsProvider.trackList,
                        songsProvider.isPlayingList,
                        songsProvider.currentlyPlayingIndex ?? 0);
                  },
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(70.0),
                onTap: () {
                  // Handle skip forward 3 seconds
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
                      songsProvider.trackList,
                      songsProvider.isPlayingList,
                      songsProvider.currentlyPlayingIndex! + 1);
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
    );
  }
}
