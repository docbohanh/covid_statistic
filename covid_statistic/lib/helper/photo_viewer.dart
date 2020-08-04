import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewer extends StatelessWidget {
  const PhotoViewer({
    this.imageProvider,
    this.loadingChild,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialScale,
    this.basePosition = Alignment.center,
    this.filterQuality = FilterQuality.none,
  });

  final ImageProvider imageProvider;
  final Widget loadingChild;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final dynamic initialScale;
  final Alignment basePosition;
  final FilterQuality filterQuality;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Dismissible(
            key: Key(imageProvider.toString()),
            direction: DismissDirection.down,
            onDismissed: (_) => Navigator.of(context).pop(),
            child: PhotoView(
              imageProvider: imageProvider,
              gaplessPlayback: false,
              backgroundDecoration: BoxDecoration(color: Colors.white70),
              customSize: MediaQuery.of(context).size,
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 1.8,
              initialScale: PhotoViewComputedScale.contained,
              basePosition: Alignment.center,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top,
          right: 8,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.close,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
