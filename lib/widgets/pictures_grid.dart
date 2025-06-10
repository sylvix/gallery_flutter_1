import 'package:flutter/material.dart';
import 'package:gallery/models/picture.dart';

class PicturesGrid extends StatelessWidget {
  final List<Picture> pictures;
  final void Function(Picture picture) onPictureSelected;

  const PicturesGrid({
    super.key,
    required this.pictures,
    required this.onPictureSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: pictures.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder:
          (ctx, index) => GridTile(
            child: InkWell(
              onTap: () => onPictureSelected(pictures[index]),
              child: Ink.image(
                image: AssetImage('assets/images/${pictures[index].url}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
    );
  }
}
