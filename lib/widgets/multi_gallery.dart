import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class MultiGallery extends StatefulWidget {
  final PageController pageController;
  final List<String> urlImages;
  final int index;
  MultiGallery({Key? key, required this.urlImages,  this.index = 0}) : pageController = PageController(initialPage: index);

  @override
  State<MultiGallery> createState() => _MultiGalleryState();
}

class _MultiGalleryState extends State<MultiGallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
        pageController: widget.pageController,
          itemCount: widget.urlImages.length,
          builder: (context, index){
            var image = widget.urlImages[index];
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(image),
            );
          },
      ),
    );
  }
}
