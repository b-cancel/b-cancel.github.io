import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';

//-------------------------Passed Parameters-------------------------

class Parameters {
  //the application that the sheet is going to appear in front of
  final Widget app;
  //the primary sheet component that shows the content that shows and hides
  final Widget sheet;

  //if you drag the sheet but not all the way after 50% on either side it will open or close automatically
  //this will show an indicator when the action that will be taken is obvious
  //darker overlay means it will close, no overlay means it will open
  final bool autoOpenOrCloseIndicator;

  //how long the animator will take to automatically complete the closing or opening of the sheet
  final int maxAnimationTimeInMilliseconds;
  //the color that shows up over the sheet when the animator will automatically close the sheet if the sheet is let go
  final Color indicatorAutoCloseColor;
  //the scrim color that will be linearly interpolated to as you open or close a modal sheet
  final Color scrimOpenColor;

  Parameters({
    @required this.app,
    @required this.sheet,
    this.autoOpenOrCloseIndicator: false,
    this.maxAnimationTimeInMilliseconds: 100,
    this.indicatorAutoCloseColor: const Color.fromRGBO(0, 0, 0, .5),
    this.scrimOpenColor: const Color.fromRGBO(0, 0, 0, .5),
  });
}

//-------------------------Private Functions-------------------------

class PrivateFunctions {
  Function getAnimationTicker;
  Function setAnimationTicker;

  Function getAnimationOpenOrClose;
  Function setAnimationOpenOrClose;

  Function getSlideUpdateStream;
  Function setSlideUpdateStream;

  Function getOpenPercent;
  Function setOpenPercent;
}

//-------------------------Public Functions-------------------------

//TODO.... implement these functions
class PublicFunctions {
  //grab information
  Function getOpenPercent;
  Function getAttachmentSize;
  Function getSheetSize;
  //run command
  Function toggleInstantaneous;
  Function toggleAnimated;
  Function openInstantaneous;
  Function closeInstantaneous;
  Function openAnimated;
  Function closeAnimated;
}

//-------------------------Material Sheet-------------------------

//NOTE: this exists to avoid unnecessary rebuilding of the sheet since it has to rebuild twice to work properly
class Sheet extends StatelessWidget {
  final Parameters parameters;
  final PublicFunctions functions = new PublicFunctions();

  Sheet({
    @required this.parameters,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: <Widget>[
            parameters.app,
            SheetWidget(
              parameter: parameters,
              functions: functions,
            ),
          ],
        ),
      ),
    );
  }
}

//-------------------------The Actual Sheet-------------------------

//NOTE: this has to be stateful because "with WidgetsBindingObserver" requires it and setState might be called
class SheetWidget extends StatefulWidget {
  final Parameters parameter;
  final PublicFunctions functions;

  SheetWidget({
    @required this.parameter,
    @required this.functions,
  });

  @override
  _SheetWidgetState createState() => new _SheetWidgetState();
}

//NOTE: this is a whole other class because the stateful class below already uses a with clause and each class can only have 1 with clause
class _SheetWidgetState extends State<SheetWidget> with WidgetsBindingObserver {
  //-------------------------Local Variables----------

  //private function variables
  PrivateFunctions private = new PrivateFunctions();
  TickerProvider animationTicker;
  OpenOrCloseAnimation animationOpenOrClose;
  StreamController<double> slideUpdateStream;
  double openPercent;

  //public function variables
  Size sheetSize;
  Size attachmentSize;

  //widget keys
  GlobalKey wholeKey = new GlobalKey();
  GlobalKey attachKey = new GlobalKey();

  //ease of use variables
  Parameters parameters;

  //-------------------------Linkage Functions----------

  linkPublicFunctions() {
    var w = widget.functions;
    w.getOpenPercent = getOpenPercent;
    w.getAttachmentSize = getAttachmentSize;
    w.getSheetSize = getSheetSize;
    w.toggleInstantaneous = toggleInstantaneous;
    w.toggleAnimated = toggleAnimated;
    w.openInstantaneous = openInstantaneous;
    w.closeInstantaneous = closeInstantaneous;
    w.openAnimated = openAnimated;
    w.closeAnimated = closeAnimated;
  }

  linkPrivateFunctions() {
    var w = private;
    w.setOpenPercent = setOpenPercent;
    w.getOpenPercent = getOpenPercent;
    w.setSlideUpdateStream = setSlideUpdateStream;
    w.getSlideUpdateStream = getSlideUpdateStream;
    w.setAnimationTicker = setAnimationTicker;
    w.getAnimationTicker = getAnimationTicker;
    w.setAnimationOpenOrClose = setAnimationOpenOrClose;
    w.getAnimationOpenOrClose = getAnimationOpenOrClose;
  }

  //-------------------------Public Functions----------

  Size getAttachmentSize() => attachmentSize;
  Size getSheetSize() => sheetSize;

  toggleInstantaneous() {
    if (private.getOpenPercent() == 1.0 || private.getOpenPercent() == 0.0)
      (private.getOpenPercent() == 1.0)
          ? closeInstantaneous()
          : openInstantaneous();
  }

  toggleAnimated() {
    if (private.getOpenPercent() == 1.0 || private.getOpenPercent() == 0.0)
      (private.getOpenPercent() == 1.0) ? closeAnimated() : openAnimated();
  }

  openInstantaneous() => completeOpenOrClose(1.0, 0, private);
  closeInstantaneous() => completeOpenOrClose(0.0, 0, private);

  openAnimated() => completeOpenOrClose(
      1.0, parameters.maxAnimationTimeInMilliseconds, private);
  closeAnimated() => completeOpenOrClose(
      0.0, parameters.maxAnimationTimeInMilliseconds, private);

  //-------------------------Private Functions----------

  TickerProvider getAnimationTicker() => animationTicker;
  setAnimationTicker(TickerProvider newAT) => animationTicker = newAT;

  OpenOrCloseAnimation getAnimationOpenOrClose() => animationOpenOrClose;
  setAnimationOpenOrClose(OpenOrCloseAnimation newOOCA) =>
      animationOpenOrClose = newOOCA;

  StreamController<double> getSlideUpdateStream() => slideUpdateStream;
  setSlideUpdateStream(StreamController<double> newSUS) =>
      slideUpdateStream = newSUS;

  double getOpenPercent() => openPercent;
  setOpenPercent(double newOP) => openPercent = newOP;

  //-------------------------Required For Reading in sheetWidth and sheetHeight----------

  int requiredBuildsPerChange = 2;
  int timesBuilt = 0;

  rebuildAsync() async {
    await Future.delayed(Duration.zero);
    setState(() {});
  }

  //-------------------------Required For Gestures and Animations----------

  asyncLinkInit() async {
    await linkPrivateFunctions();
    initSlideUpdateStream();
  }

  initSlideUpdateStream() {
    if (private.getSlideUpdateStream() == null) {
      private.setSlideUpdateStream(new StreamController<double>());

      private.getSlideUpdateStream().stream.listen((double newPercent) {
        setState(() {
          private.setOpenPercent(newPercent);
        });
      });
    }
  }

  //-------------------------Required For WidgetsBindingObserver----------

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    asyncLinkInit(); //for gestures and animations
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  //-------------------------Widget Extract Helpers----------

  Matrix4 _calcSheetClosedTransform(double width, double height) {
    width = width ?? 0.0;
    height = height ?? 0.0;
    return Matrix4.translationValues(-width, 0.0, 0.0);
  }

  Matrix4 _calcTransform(double width, double height) {
    Matrix4 beginMatrix = Matrix4.translationValues(0.0, 0.0, 0.0);
    Matrix4 endMatrix = _calcSheetClosedTransform(width, height);
    return Matrix4Tween(begin: endMatrix, end: beginMatrix)
        .lerp(private.getOpenPercent());
  }

  Color _calcIndicatorColor() {
    if (parameters.autoOpenOrCloseIndicator) {
      if (private.getOpenPercent() > .5)
        return parameters.indicatorAutoCloseColor.withOpacity(0.0);
      else
        return parameters.indicatorAutoCloseColor;
    } else
      return Colors.transparent;
  }

  //-------------------------Widget Extracts----------

  Widget sheetWidget(double w, double h) {
    return new Stack(children: <Widget>[
      new Container(
        width: (w == 0.0) ? null : w,
        height: (h == 0.0) ? null : h,
        child: parameters.sheet,
      ),
      new IgnorePointer(
        child: new Container(
          width: (w == 0.0) ? null : w,
          height: (h == 0.0) ? null : h,
          color: _calcIndicatorColor(),
        ),
      )
    ]);
  }

  Widget attachmentWidget(bool addKey) {
    return Container(
      key: (addKey) ? attachKey : null,
      child: Icon(Icons.attachment, color: Colors.transparent),
    );
  }

  Widget scrimWidget() {
    if (private.getOpenPercent() != 0.0) {
      return new Container(
        color: Color.lerp(
          Colors.transparent,
          parameters.scrimOpenColor,
          private.getOpenPercent(),
        ),
        child: new GestureDetector(
          onTap: () => closeAnimated(),
        ),
      );
    } else
      return new Container();
  }

  Widget sheetAndAttachmentWidget() {
    //both of these are read in by build in the first build phase
    double wholeWidth = wholeKey?.currentContext
        ?.findRenderObject()
        ?.semanticBounds
        ?.size
        ?.width;
    double wholeHeight = wholeKey?.currentContext
        ?.findRenderObject()
        ?.semanticBounds
        ?.size
        ?.height;
    double attachWidth = attachKey?.currentContext
        ?.findRenderObject()
        ?.semanticBounds
        ?.size
        ?.width;
    double attachHeight = attachKey?.currentContext
        ?.findRenderObject()
        ?.semanticBounds
        ?.size
        ?.height;

    double sheetWidth = (wholeWidth == null)
        ? 0.0
        : (wholeWidth == attachWidth) ? wholeWidth : wholeWidth - attachWidth;
    double sheetHeight = (wholeHeight == null)
        ? 0.0
        : (wholeHeight == attachHeight)
            ? wholeHeight
            : wholeHeight - attachHeight;

    attachmentSize = new Size(attachWidth, attachHeight);
    sheetSize = new Size(sheetWidth, sheetHeight);

    Widget thisSheetWidget = sheetWidget(sheetWidth, sheetHeight);

    Transform mainWidget = new Transform(
      transform: _calcTransform(sheetWidth, sheetHeight),
      child: new Flex(
        direction: Axis.horizontal,
        //ONLY relevant if position is top or bottom
        textDirection: TextDirection.rtl,
        //ONLY relevant if position is left or right
        verticalDirection: VerticalDirection.down,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          Container(
            key: wholeKey,
            color: Colors.transparent,
            child: SwipeToOpenClose(
              parameters: parameters,
              private: private,
              sheetWidth: sheetWidth,
              sheetHeight: sheetHeight,
              child: Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  thisSheetWidget,
                  attachmentWidget(true),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return new Stack(
      children: <Widget>[
        mainWidget,
        new IgnorePointer(
          child: new Flex(
            direction: Axis.horizontal,
            //ONLY relevant if position is top or bottom
            textDirection: TextDirection.rtl,
            //ONLY relevant if position is left or right
            verticalDirection: VerticalDirection.down,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Expanded(
                child: new Container(),
              ),
              attachmentWidget(false),
            ],
          ),
        ),
      ],
    );
  }

  //-------------------------Build Method----------

  @override
  Widget build(BuildContext context) {
    //link up functions
    linkPrivateFunctions();
    linkPublicFunctions();

    //for ease of use
    parameters = widget.parameter;

    //init open percent
    if (private.getOpenPercent() == null)
      private.setOpenPercent(1); //start open

    //required to read in sheetWidth and sheetHeight
    timesBuilt++;
    if (timesBuilt < requiredBuildsPerChange)
      rebuildAsync();
    else
      timesBuilt = 0;

    //return our widgets
    return new Stack(
      children: <Widget>[
        scrimWidget(),
        sheetAndAttachmentWidget(),
      ],
    );
  }
}

//-------------------------GestureDetector Code-------------------------

//NOTE: this has to be stateful because the SingleTickerProviderStateMixin requires it
class SwipeToOpenClose extends StatefulWidget {
  SwipeToOpenClose({
    @required this.parameters,
    @required this.private,
    @required this.sheetWidth,
    @required this.sheetHeight,
    @required this.child,
  });

  final Parameters parameters;
  final PrivateFunctions private;

  final double sheetWidth;
  final double sheetHeight;

  final Widget child;

  @override
  _SwipeToOpenCloseState createState() => _SwipeToOpenCloseState();
}

//NOTE: this is a whole other class because the stateful class above already uses a with clause and each class can only have 1 with clause
class _SwipeToOpenCloseState extends State<SwipeToOpenClose>
    with SingleTickerProviderStateMixin {
  //-------------------------Gesture Helpers

  Offset dragStart;
  double slideStart;

  onDragStart(DragStartDetails details) {
    slideStart = widget.private.getOpenPercent();
    dragStart = details.globalPosition;
  }

  onDragUpdate(DragUpdateDetails details) {
    if (dragStart != null) {
      Offset dragCurrent = details.globalPosition;
      Offset dragChange = dragCurrent - dragStart;
      double slideAdded = (dragChange.dx / widget.sheetWidth);

      widget.private
          .getSlideUpdateStream()
          .add((slideStart + slideAdded).clamp(0.0, 1.0));
    }
  }

  onDragEnd(DragEndDetails details) {
    //clear some data
    dragStart = null;
    //calculate how long the animation should take
    int animationTimeInMilliseconds = widget.parameters
        .maxAnimationTimeInMilliseconds; //the longest it should take assuming a full animated close or open
    bool isOpening = (widget.private.getOpenPercent() >= 0.5);
    if (isOpening)
      animationTimeInMilliseconds =
          ((1 - widget.private.getOpenPercent()) * animationTimeInMilliseconds)
              .round();
    else
      animationTimeInMilliseconds = ((0.5 - widget.private.getOpenPercent()) *
              animationTimeInMilliseconds)
          .round();
    //compete the open or closing action
    completeOpenOrClose(
        isOpening ? 1.0 : 0.0, animationTimeInMilliseconds, widget.private);
  }

  //-------------------------System Functions

  @override
  Widget build(BuildContext context) {
    widget.private.setAnimationTicker(this);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      //---for bottom and top sheets
      onVerticalDragStart: null,
      onVerticalDragUpdate: null,
      onVerticalDragEnd: null,
      //---for left and right sheets
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
      child: widget.child,
    );
  }
}

//-------------------------Animation Code-------------------------

completeOpenOrClose(double goalOpenPercent, int millisecondsToComplete,
    PrivateFunctions globals) {
  if (globals.getAnimationOpenOrClose() == null) {
    var newOOCA = new OpenOrCloseAnimation(
      startOpenPercent: globals.getOpenPercent(),
      goalOpenPercent: goalOpenPercent,
      millisecondsToComplete: millisecondsToComplete,

      slideUpdateStream: globals.getSlideUpdateStream(),
      vsync: globals
          .getAnimationTicker(), //NOTE: this assumes you have created an animation ticker already
    );

    globals.setAnimationOpenOrClose(newOOCA);
  } else {
    globals.getAnimationOpenOrClose().startOpenPercent =
        globals.getOpenPercent();
    globals.getAnimationOpenOrClose().goalOpenPercent = goalOpenPercent;
    globals.getAnimationOpenOrClose().millisecondsToComplete =
        millisecondsToComplete;
    globals.getAnimationOpenOrClose().completionAnimationController.duration =
        new Duration(milliseconds: millisecondsToComplete);
  }

  globals.getAnimationOpenOrClose().run();
}

//-------------------------Animation Class-------------------------

class OpenOrCloseAnimation {
  AnimationController completionAnimationController;

  double startOpenPercent;
  double goalOpenPercent;
  int millisecondsToComplete;
  StreamController<double> slideUpdateStream;
  TickerProvider vsync;

  OpenOrCloseAnimation({
    @required this.startOpenPercent,
    @required this.goalOpenPercent,
    @required this.millisecondsToComplete,

    //NOTE: these variables are initially passed by the only stateful widget that has a Ticker
    @required this.slideUpdateStream,
    @required this.vsync,
  }) {
    completionAnimationController = new AnimationController(
      duration: Duration(milliseconds: millisecondsToComplete),
      vsync: vsync,
    )..addListener(() {
        final slidePercent = lerpDouble(
          startOpenPercent,
          goalOpenPercent,
          completionAnimationController.value,
        );

        slideUpdateStream.add(slidePercent);
      });
  }

  run() async {
    completionAnimationController.forward(from: 0.0);
  }
}
