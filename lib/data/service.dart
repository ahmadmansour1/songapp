import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/tracks_model.dart';

List<Data>? trackList;
List<bool>? isPlayingList;

class SongsService {
  String baseUrl = 'https://api.deezer.com/album/302127/tracks';
  Future<List<Data>> fetchData() async {
    final response =
    await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      String decodedResponse = utf8.decode(response.bodyBytes);
      Tracks tracksData = Tracks.fromJson(json.decode(decodedResponse));

      // Assuming you want to return the list of tracks
      return tracksData.data ?? [];
    } else {
      print('Failed to load data. Error code: ${response.statusCode}');
      // Handle the error or return an empty list
      return [];
    }
  }
}
