import '../../domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.name,
    required super.address,
    required super.phone,
    required super.gender,
    required super.avatarUrl,
  });
  @override
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

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'address': address,
      'phone': phone,
      'gender': gender,
      'avatarUrl': avatarUrl,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      name: map['name'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      gender: map['gender'] as String,
      avatarUrl: map['avatarUrl'] as String,
    );
  }

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
