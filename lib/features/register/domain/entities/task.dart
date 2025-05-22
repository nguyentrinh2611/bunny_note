import 'dart:convert';

class SCTask {
  final String? description;
  final DateTime? duetime;

  final DateTime? starttime;

  final String? title;
  final String? uid;
  final String? userId;

  SCTask({
    this.description,
    this.duetime,
    this.starttime,
    this.title,
    this.uid,
    this.userId,
  });

  SCTask copyWith({
    String? description,
    DateTime? duetime,
    DateTime? starttime,
    String? title,
    String? uid,
    String? userId,
  }) =>
      SCTask(
        description: description ?? this.description,
        duetime: duetime ?? this.duetime,
        starttime: starttime ?? this.starttime,
        title: title ?? this.title,
        uid: uid ?? this.uid,
        userId: userId ?? this.userId,
      );

  factory SCTask.fromJson(String str) => SCTask.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SCTask.fromMap(Map<String, dynamic> json) => SCTask(
        description: json["description"],
        duetime:
            json["duetime"] == null ? null : DateTime.parse(json["duetime"]),
        starttime: json["starttime"] == null
            ? null
            : DateTime.parse(json["starttime"]),
        title: json["title"],
        uid: json["uid"],
        userId: json["userId"],
      );

  Map<String, dynamic> toMap() => {
        "description": description,
        "duetime": duetime?.toIso8601String(),
        "starttime": starttime?.toIso8601String(),
        "title": title,
        "uid": uid,
        "userId": userId,
      };
  factory SCTask.fromMapToThumbnail(Map<String, dynamic> map) {
    return SCTask(
      uid: map['uid'].toString(),
      userId: map['userId'].toString(),
      title: map['title'].toString(),
      description: map['description'].toString(),
      starttime: null,
      duetime: null,
    );
  }
}
