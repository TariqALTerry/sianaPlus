class UserEntity {
  final String token;
  final String email;
  final String role;
  final String username;
  final dynamic image;

  UserEntity({
    required this.token,
    required this.email,
    required this.role,
    required this.username,
    this.image,
  });
}
