import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:giphy_client/giphy_client.dart';
import 'package:portfolio/utils/giphyVideo.dart';
import 'package:portfolio/workContent.dart';

//be able to pass ID... and let everything else be handled as expected
//if its a giphy image we want to save the data so its accessible from anywhere
//so that when we tap the image we can full screen
//cover case where our image is not yet loaded at all

//1st we MAY need to read in the giphy image => show placeholder
//2nd we want to show a bit of everything on screen => show still
//3rd we want to show the looping gif -> show gif
//4th if we tap on the gif we want to -> show the high quality version (perhaps even mp4)

/// Loads and renders a Giphy image.
class GiphyController extends StatefulWidget {
  final GiphyGif gif;
  final double aspectRatio;
  final ValueNotifier<bool> playableContentTapped;

  /// Loads an image from given url.
  const GiphyController({
    Key key,
    @required this.gif,
    @required this.aspectRatio,
    @required this.playableContentTapped,
  }) : super(key: key);

  @override
  _GiphyControllerState createState() => _GiphyControllerState();

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

class _GiphyControllerState extends State<GiphyController> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GiphyController.load(
        //this is only going to be viewable for a second
        widget.gif.images.downsizedStill.url,
      ),
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
          if (snapShot.hasData == false) {
            print("no data");
            return ShimmeringContent(
              aspectRatio: widget.aspectRatio,
              isLoading: false,
            );
          } else {
            return VideoPlayerWidget(
              background: snapShot.data,
              url: widget.gif.images.originalMp4.mp4,
              playableContentTapped: widget.playableContentTapped,
            );
          }
        } else {
          return ShimmeringContent(
            aspectRatio: widget.aspectRatio,
          );
        }
      },
    );
  }
}
