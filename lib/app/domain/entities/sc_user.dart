import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class SCUser {
  final String? uid;
  final String? dbUid;
  final String username;
  final String password;
  const SCUser({
    this.uid,
    this.dbUid,
    required this.username,
    required this.password,
  });

  SCUser copyWith({
    String? uid,
    String? dbUid,
    String? username,
    String? password,
  }) {
    return SCUser(
      uid: uid ?? this.uid,
      dbUid: dbUid ?? this.dbUid,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'dbUid': dbUid,
      'username': username,
      'password': password,
    };
  }

  factory SCUser.fromMap(Map<String, dynamic> map) {
    return SCUser(
      uid: map['uid'] != null ? map['uid'] as String : null,
      dbUid: map['dbUid'] != null ? map['dbUid'] as String : null,
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  @override
  String toString() {
    return 'SCUser(uid: $uid, dbUid: $dbUid, username: $username, password: $password)';
  }

  @override
  bool operator ==(covariant SCUser other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.dbUid == dbUid &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        dbUid.hashCode ^
        username.hashCode ^
        password.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory SCUser.fromJson(String source) =>
      SCUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
