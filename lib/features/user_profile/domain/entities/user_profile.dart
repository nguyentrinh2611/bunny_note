import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserProfile {
  final String name;
  final String address;
  final String phone;
  final String gender;
  final String avatarUrl;
  const UserProfile({
    required this.name,
    required this.address,
    required this.phone,
    required this.gender,
    required this.avatarUrl,
  });

  UserProfile copyWith({
    String? name,
    String? address,
    String? phone,
    String? gender,
    String? avatarUrl,
  }) {
    return UserProfile(
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'address': address,
      'phone': phone,
      'gender': gender,
      'avatarUrl': avatarUrl,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      name: map['name'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      gender: map['gender'] as String,
      avatarUrl: map['avatarUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfile(name: $name, address: $address, phone: $phone, gender: $gender, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(covariant UserProfile other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.address == address &&
        other.phone == phone &&
        other.gender == gender &&
        other.avatarUrl == avatarUrl;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        gender.hashCode ^
        avatarUrl.hashCode;
  }
}
