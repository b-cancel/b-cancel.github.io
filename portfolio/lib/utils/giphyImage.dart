import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:giphy_client/giphy_client.dart';
import 'package:portfolio/utils/giphyVideo.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'package:video_player/video_player.dart';

//be able to pass ID... and let everything else be handled as expected
//if its a giphy image we want to save the data so its accessible from anywhere
//so that when we tap the image we can full screen
//cover case where our image is not yet loaded at all

//1st we MAY need to read in the giphy image => show placeholder
//2nd we want to show a bit of everything on screen => show still
//3rd we want to show the looping gif -> show gif
//4th if we tap on the gif we want to -> show the high quality version (perhaps even mp4)

/// Loads and renders a Giphy image.
class GiphyImage extends StatefulWidget {
  final String url;
  final Widget placeholder;
  final double width;
  final double height;
  final BoxFit fit;
  final bool isVideo;
  final double aspectRatio;

  /// Loads an image from given url.
  const GiphyImage({
    Key key,
    @required this.url,
    @required this.isVideo,
    @required this.aspectRatio,
    this.placeholder,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);

  GiphyImage.preview({
    Key key,
    @required GiphyGif gif,
    @required this.aspectRatio,
    this.placeholder,
    this.width,
    this.height,
    this.fit,
  })  : isVideo = false,
        url = gif.images.previewGif.url,
        super(key: key ?? Key(gif.id));

  GiphyImage.downScaled({
    Key key,
    @required GiphyGif gif,
    @required this.aspectRatio,
    this.placeholder,
    this.width,
    this.height,
    this.fit,
  })  : isVideo = false,
        url = gif.images.downsized.url,
        super(key: key ?? Key(gif.id));

  /// Loads the original image for given Giphy gif.
  GiphyImage.original({
    Key key,
    @required GiphyGif gif,
    @required this.aspectRatio,
    this.placeholder,
    this.width,
    this.height,
    this.fit,
  })  : isVideo = false,
        url = gif.images.original.url,
        super(key: key ?? Key(gif.id));

  /// Loads the original still image for given Giphy gif.
  GiphyImage.originalStill({
    Key key,
    @required GiphyGif gif,
    @required this.aspectRatio,
    this.placeholder,
    this.width,
    this.height,
    this.fit,
  })  : isVideo = false,
        url = gif.images.originalStill.url,
        super(key: key ?? Key(gif.id));

  GiphyImage.video({
    Key key,
    @required GiphyGif gif,
    @required this.aspectRatio,
    this.placeholder,
    this.width,
    this.height,
    this.fit,
  })  : isVideo = true,
        url = gif.images.downsizedSmall.mp4,
        super(key: key ?? Key(gif.id));

  @override
  _GiphyImageState createState() => _GiphyImageState();

  /// Loads the images bytes for given url from Giphy.
  static Future<Uint8List> load(String url, {Client client}) async {
    assert(url != null);

    final response =
        await (client ?? Client()).get(url, headers: {'accept': 'image/*'});

    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
    return null;
  }
}

class _GiphyImageState extends State<GiphyImage> {
  Future<Uint8List> _loadImage;

  @override
  void initState() {
    _loadImage = GiphyImage.load(widget.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isVideo == false) {
      return FutureBuilder(
        future: _loadImage,
        builder: (
          BuildContext context,
          AsyncSnapshot<Uint8List> snapshot,
        ) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Image.memory(
                  snapshot.data,
                  width: widget.width,
                  height: widget.height,
                  fit: widget.fit,
                ),
              ],
            );
          } else {
            return widget.placeholder ??
                Shimmer(
                  duration: Duration(seconds: 2), //Default value
                  color: Colors.white, //Default value
                  enabled: true, //Default value
                  direction: ShimmerDirection.fromLTRB(),
                  child: Container(
                    height: 3,
                    width: 3 * widget.aspectRatio,
                  ),
                );
          }
        },
      );
    } else {
      return VideoPlayerWidget(
        url: widget.url,
      );
    }
  }
}
