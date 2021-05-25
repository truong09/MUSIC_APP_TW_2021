class Song {
  Song({
    this.id,
    this.name,
    this.album,
    this.singer,
    this.artImage,
    this.uploadDate,
    this.figure,
    this.path,
  });

  String id;
  String name;
  String album;
  String singer;
  String artImage;
  String uploadDate;
  int figure;
  String path;

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        id: json["id"],
        name: json["name"],
        album: json["album"],
        singer: json["singer"],
        artImage: json["artImage"],
        // lengthInMiniSeconds: (json["lengthInMiniSeconds"]).toInt(),
        uploadDate: json["uploadDate"],
        figure: (json["figure"]),
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "album": album,
        "singer": singer,
        "artImage": artImage,
        "uploadDate": uploadDate,
        "figure": figure,
        "path": path,
      };
}
