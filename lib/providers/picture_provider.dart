import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery/data/pictures_data.dart';
import 'package:gallery/models/picture.dart';

final picturesProvider = Provider<List<Picture>>((ref) {
  return pictures;
});
