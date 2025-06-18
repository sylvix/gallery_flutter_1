import 'dart:io';

class Picture {
  final String id;
  final String title;
  final File image;

  const Picture({required this.id, required this.title, required this.image});
}
