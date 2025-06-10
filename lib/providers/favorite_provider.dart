import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery/models/picture.dart';
import 'package:gallery/providers/picture_provider.dart';

class FavoritesNotifier extends Notifier<List<String>> {
  @override
  List<String> build() {
    return ['bridge'];
  }

  bool toggleFavoriteStatus(String pictureId) {
    final isFavorite = state.contains(pictureId);

    if (isFavorite) {
      state = state.where((id) => id != pictureId).toList();
    } else {
      state = [...state, pictureId];
    }

    return !isFavorite;
  }
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, List<String>>(
  FavoritesNotifier.new,
);

final favoritesPicturesProvider = Provider<List<Picture>>((ref) {
  final favoriteIds = ref.watch(favoritesProvider);
  final allPictures = ref.watch(picturesProvider);
  return allPictures.where((pic) => favoriteIds.contains(pic.id)).toList();
});
