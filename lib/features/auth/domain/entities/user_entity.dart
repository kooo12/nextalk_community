import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String username;
  final String? bio;
  final String? profileImageUrl;
  final String role;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.username,
    this.bio,
    this.profileImageUrl,
    required this.role,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        uid,
        email,
        username,
        bio,
        profileImageUrl,
        role,
        createdAt,
        updatedAt,
      ];
}
