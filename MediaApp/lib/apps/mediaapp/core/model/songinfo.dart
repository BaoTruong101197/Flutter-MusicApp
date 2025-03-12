class SongInfo {
  SongInfo({required this.id, required this.title, required this.album, required this.artist, required this.source, required this.image, required this.duration});

  factory SongInfo.fromJson(Map<String, dynamic> map) {
    return SongInfo(
      id: map['id'],
      title: map['title'],
      album: map['album'],
      artist: map['artist'],
      source: map['source'],
      image: map['image'],
      duration: map['duration'],
    );
  }

  @override
  bool operator==(Object other) => 
    identical(this, other) || other is SongInfo && id == other.id;

  @override
  int get hashCode => id.hashCode;

  String id;
  String title;
  String album;
  String artist;
  String source;
  String image;
  int duration;
}