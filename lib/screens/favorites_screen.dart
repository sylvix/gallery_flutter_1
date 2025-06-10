import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery/providers/favorite_provider.dart';
import 'package:gallery/screens/picture_screen.dart';
import 'package:gallery/widgets/pictures_grid.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritePictures = ref.watch(favoritesPicturesProvider);

    Widget content = Center(child: Text('No favorites yet'));

    if (favoritePictures.isNotEmpty) {
      content = PicturesGrid(
        pictures: favoritePictures,
        onPictureSelected: (picture) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => PictureScreen(picture: picture),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.delete_rounded)),
        ],
      ),
      body: content,
    );
  }
}
