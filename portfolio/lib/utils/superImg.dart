import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

enum Source {Asset, Network}

class SuperImage extends StatefulWidget {
  SuperImage({
    this.source: Source.Network,
    this.fit: BoxFit.contain,
    @required this.url,
  });

  final Source source;
  final BoxFit fit;
  final String url;

  @override
  _SuperImageState createState() => _SuperImageState();
}

class _SuperImageState extends State<SuperImage> {
  ImageProvider littleImage;
  ImageProvider largerImage;

  ImageProvider urlToImageProvider(String url){
    if(widget.source == Source.Network){
      return NetworkImage(url);
    }
    else{
      return AssetImage(url);
    }
  }

  @override
  void initState() {
    super.initState();
    littleImage = MemoryImage(kTransparentImage);
    largerImage = urlToImageProvider(widget.url);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //preload the image
    precacheImage(littleImage, context,).then((_) {
      // replace the loading indicator and show the image
      // (may be with some soothing fade in effect etc.)
    });

    precacheImage(largerImage, context,).then((_) {
      // replace the loading indicator and show the image
      // (may be with some soothing fade in effect etc.)
    });
  }

  @override
  Widget build(BuildContext context) {
    
    

    //build
    return FadeInImage(
      fit: widget.fit,
      placeholder: littleImage,
      image: largerImage,
    );
  }
}