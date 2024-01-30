import 'package:flutter/material.dart';

import '../../provider/provider.dart';
import '../screens/playing_now.dart';

class SongPlayer extends StatelessWidget {
  SongsProvider songsProvider;
  SongPlayer({super.key, required this.songsProvider});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayNowScreen(),
          ),
        );
      },
      child: ListTile(
        leading: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.network(
                'https://media.npr.org/assets/img/2013/06/17/davidblack-ca8a5d8bac16559aadf019c79f37450f57d3ed51-s1100-c50.jpg')),
        title: Text(
          songsProvider
              .trackList![songsProvider.currentlyPlayingIndex ?? 0].title
              .toString(),
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.pause, color: Colors.white),
              onPressed: () {
                if (songsProvider
                        .isPlayingList![songsProvider.currentlyPlayingIndex!] &&
                    songsProvider.isPlayingList != null) {
                  songsProvider.playPause(
                      songsProvider.trackList,
                      songsProvider.isPlayingList,
                      songsProvider.currentlyPlayingIndex!);
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.skip_next, color: Colors.white),
              onPressed: () {
                songsProvider.playPause(
                    songsProvider.trackList,
                    songsProvider.isPlayingList,
                    songsProvider.currentlyPlayingIndex! + 1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
