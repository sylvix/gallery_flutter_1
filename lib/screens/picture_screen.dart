import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery/models/picture.dart';
import 'package:gallery/providers/favorite_provider.dart';

class PictureScreen extends ConsumerWidget {
  final Picture picture;

  const PictureScreen({super.key, required this.picture});

  void _toggleFavorite(BuildContext context, WidgetRef ref) {
    final isNowFavorite = ref
        .read(favoritesProvider.notifier)
        .toggleFavoriteStatus(picture.id);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isNowFavorite ? 'Added to favorites' : 'Removed from favorites',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final isFavorite = favorites.contains(picture.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(picture.title),
        actions: [
          IconButton(
            onPressed: () => _toggleFavorite(context, ref),
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  alignment: Alignment.topCenter,
                  turns: Tween(begin: 0.6, end: 1.0).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: Icon(
                key: ValueKey(isFavorite),
                isFavorite ? Icons.favorite : Icons.favorite_outline,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(child: Image.file(picture.image)),
    );
  }
}
