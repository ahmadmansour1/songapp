class Tracks {
  List<Data>? data;
  int? total;
  List<Artist>? artist;

  Tracks({this.data, this.total , this.artist});

  Tracks.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
    if (json['artist'] != null) {
      artist = <Artist>[];
      json['artist'].forEach((v) {
        artist!.add(Artist.fromJson(json));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int? id;
  bool? readable;
  String? title;
  String? titleShort;
  String? titleVersion;
  String? isrc;
  String? link;
  int? duration;
  int? trackPosition;
  int? diskNumber;
  int? rank;
  bool? explicitLyrics;
  int? explicitContentLyrics;
  int? explicitContentCover;
  String? preview;
  String? md5Image;
  Artist? artist;
  String? type;

  Data(
      {this.id,
        this.readable,
        this.title,
        this.titleShort,
        this.titleVersion,
        this.isrc,
        this.link,
        this.duration,
        this.trackPosition,
        this.diskNumber,
        this.rank,
        this.explicitLyrics,
        this.explicitContentLyrics,
        this.explicitContentCover,
        this.preview,
        this.md5Image,
        this.artist,
        this.type});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readable = json['readable'];
    title = json['title'];
    titleShort = json['title_short'];
    titleVersion = json['title_version'];
    isrc = json['isrc'];
    link = json['link'];
    duration = json['duration'];
    trackPosition = json['track_position'];
    diskNumber = json['disk_number'];
    rank = json['rank'];
    explicitLyrics = json['explicit_lyrics'];
    explicitContentLyrics = json['explicit_content_lyrics'];
    explicitContentCover = json['explicit_content_cover'];
    preview = json['preview'];
    md5Image = json['md5_image'];
    artist =
    json['artist'] != null ? new Artist.fromJson(json['artist']) : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['readable'] = this.readable;
    data['title'] = this.title;
    data['title_short'] = this.titleShort;
    data['title_version'] = this.titleVersion;
    data['isrc'] = this.isrc;
    data['link'] = this.link;
    data['duration'] = this.duration;
    data['track_position'] = this.trackPosition;
    data['disk_number'] = this.diskNumber;
    data['rank'] = this.rank;
    data['explicit_lyrics'] = this.explicitLyrics;
    data['explicit_content_lyrics'] = this.explicitContentLyrics;
    data['explicit_content_cover'] = this.explicitContentCover;
    data['preview'] = this.preview;
    data['md5_image'] = this.md5Image;
    if (this.artist != null) {
      data['artist'] = this.artist!.toJson();
    }
    data['type'] = this.type;
    return data;
  }
}

class Artist {
  int? id;
  String? name;
  String? tracklist;
  String? type;

  Artist({this.id, this.name, this.tracklist, this.type});

  Artist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tracklist = json['tracklist'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tracklist'] = this.tracklist;
    data['type'] = this.type;
    return data;
  }
}