import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery/models/picture.dart';

class PicturesNotifier extends Notifier<List<Picture>> {
  @override
  List<Picture> build() {
    return [];
  }

  void addPicture(Picture picture) {
    state = [...state, picture];
  }
}

final picturesProvider = NotifierProvider<PicturesNotifier, List<Picture>>(
  PicturesNotifier.new,
);
