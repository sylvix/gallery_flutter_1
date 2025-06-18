import 'package:flutter/material.dart';
import 'package:gallery/models/picture.dart';

class PicturesGrid extends StatefulWidget {
  final List<Picture> pictures;
  final void Function(Picture picture) onPictureSelected;

  const PicturesGrid({
    super.key,
    required this.pictures,
    required this.onPictureSelected,
  });

  @override
  State<PicturesGrid> createState() => _PicturesGridState();
}

class _PicturesGridState extends State<PicturesGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      duration: Duration(milliseconds: 300),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView.builder(
        itemCount: widget.pictures.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemBuilder:
            (ctx, index) => GridTile(
              child: InkWell(
                onTap: () => widget.onPictureSelected(widget.pictures[index]),
                child: Ink.image(
                  image: FileImage(widget.pictures[index].image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
      ),
      builder:
          (ctx, child) => SlideTransition(
            position: Tween(begin: Offset(0, 0.3), end: Offset(0, 0)).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeOut,
              ),
            ),
            child: child,
          ),
    );
  }
}
