class UserEntity {
  final String id;
  final String name;
  final String email;
  final String? avatar;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });
}
