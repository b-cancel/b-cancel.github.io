import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String url;

  VideoPlayerWidget({
    Key key,
    @required this.url,
  }) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController _controller;

  ValueNotifier<Duration> timePassed = ValueNotifier<Duration>(
    Duration.zero,
  );
  ValueNotifier<Duration> totalTime = ValueNotifier<Duration>(
    Duration.zero,
  );
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      widget.url,
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.removeListener(updateValues);
    timePassed.removeListener(printValues);
    totalTime.removeListener(printValues);
    super.dispose();
  }

  updateValues() async {
    totalTime.value = _controller?.value?.duration ?? Duration.zero;
    timePassed.value = _controller?.value?.position ?? Duration.zero;
  }

  printValues() {
    print(totalTime.value.toString() + " => " + timePassed.value.toString());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _controller.addListener(updateValues);
          timePassed.addListener(printValues);
          totalTime.addListener(printValues);

          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the video.
          return Stack(
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                // Use the VideoPlayer widget to display the video.
                child: VideoPlayer(_controller),
              ),
              Positioned.fill(
                child: InkWell(
                  onTap: () {
                    // Wrap the play or pause in a call to `setState`. This ensures the
                    // correct icon is shown.
                    setState(() {
                      // If the video is playing, pause it.
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        // If the video is paused, play it.
                        _controller.play();
                      }
                    });
                  },
                  child: Center(
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: UpdatingSlider(
                  controller: _controller,
                  passed: timePassed,
                  total: totalTime,
                ),
              ),
            ],
          );
        } else {
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return Container();
        }
      },
    );
  }
}

class UpdatingSlider extends StatefulWidget {
  UpdatingSlider({
    @required this.controller,
    @required this.passed,
    @required this.total,
  });

  final VideoPlayerController controller;
  final ValueNotifier<Duration> passed;
  final ValueNotifier<Duration> total;

  @override
  _UpdatingSliderState createState() => _UpdatingSliderState();
}

class _UpdatingSliderState extends State<UpdatingSlider> {
  updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    widget.passed.addListener(updateState);
    widget.total.addListener(updateState);
  }

  @override
  void dispose() {
    widget.passed.removeListener(updateState);
    widget.total.removeListener(updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.total.value == Duration.zero) {
      return Container();
    } else {
      int total = widget.total.value.inMicroseconds;
      int passed = widget.passed.value.inMicroseconds;
      return Slider(
        max: 1,
        value: passed / total,
        onChangeStart: (double v) {
          widget.controller.pause();
        },
        onChanged: (double v) {
          widget.controller.seekTo(
            Duration(
              microseconds: (v * (total)).toInt(),
            ),
          );
        },
        onChangeEnd: (double v) {
          widget.controller.play();
        },
      );
    }
  }
}

class GiphyOverlay extends StatelessWidget {
  final Widget child;
  final String label;

  const GiphyOverlay({
    @required this.child,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Visibility(
            visible: label != null,
            child: Container(
              alignment: Alignment.centerLeft,
              color: Colors.black45,
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                label ?? "",
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/*

*/
