import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

enum Source { Asset, Network }

class PreCachedImage extends StatefulWidget {
  PreCachedImage({
    @required this.url,
    this.source: Source.Network,
    this.fit: BoxFit.contain,
    this.fade: false,
  });

  final String url;
  final Source source;
  final BoxFit fit;
  final bool fade;

  @override
  _PreCachedImageState createState() => _PreCachedImageState();
}

class _PreCachedImageState extends State<PreCachedImage> {
  ImageProvider imageProvider;

  @override
  void initState() {
    super.initState();
    imageProvider = urlToImageProvider(
      widget.url,
      widget.source,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(
      imageProvider,
      context,
    ).then((value){
      print("precache success");
    }, onError: (){
      print("precache fail");
    });
  }

  @override
  Widget build(BuildContext context) {
    //even with precaching you need to fade
    //UNLESS you precache before you display the image
    return FadeInImage(
      placeholder: MemoryImage(kTransparentImage),
      image: imageProvider,
      fit: widget.fit,
    );
  }
}

ImageProvider urlToImageProvider(String url, Source source) {
  if (source == Source.Network) {
    return NetworkImage(url);
  } else {
    return AssetImage(url);
  }
}