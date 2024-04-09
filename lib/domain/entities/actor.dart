class Actor {
  final int id;
  final String name;
  final String profilePath;
  final String? character;

  Actor(
    this.id,
    this.character, {
    required this.name,
    required this.profilePath,
  });

}
