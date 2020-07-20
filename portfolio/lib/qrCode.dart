import 'package:flutter/material.dart';

import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr/qr.dart';
import 'package:qr/src/rs_block.dart' as rsBlock;
import 'package:qr/src/mode.dart' as qr_mode;
import 'package:qr/src/byte.dart' as byte;

//VCard suffer for compatibility issues
//this is me trying my best to work with that
class MyVCard {
  String firstName;
  String lastName;
  String title;
  String phone;
  String email;
  String website;

  MyVCard({
    this.firstName,
    this.lastName,
    this.title,
    this.phone,
    this.email,
    this.website,
  });

  //NOTE: to add revision
  //lower case values are placeholders
  //yyyy-dd-mmThh:mm:ss.mmm
  //yyyy-dd-mmThh:mm:ssZ

  String getV2({bool addCharset: false}) => _getV("2.1", addCharset);
  String getV3({bool addCharset: false}) => _getV("3.0", addCharset);
  String getV4() => _getV("4.0", false); //for all v4 charset not specified
  _getV(String version, bool addCharset) {
    String showCharset = ";CHARSET=UTF-8";
    String maybeCharset = addCharset ? showCharset : "";

    //start
    String output = "BEGIN:VCARD";
    output += "\nVERSION:$version" "";

    //name (both required)
    output += '''\nFN$maybeCharset:$firstName $lastName''';
    output += '''\nN$maybeCharset:$lastName;$firstName;;;''';

    //title
    output += '''\nTITLE$maybeCharset:$title''';

    //-----phone-----
    //NOTE: instead of CELL (WORK | HOME | FAX)
    //TODO: figure out when to add voice
    //like so 'TEL;WORK;VOICE:(111) 555-1212'
    //TODO: figure out when we can add pref
    //like so 'TEL;CELL;PREF:9567772692'

    output += '''\nTEL''';
    if (version == "2.1") {
      //TEL   ;CELL         :$phone
      output += ";CELL";
    } else if (version == "3.0") {
      //TEL   ;TYPE=CELL    :$phone
      output += ";TYPE=CELL";
    } else {
      //! alot of variation
      //TEL                 :$phone

      //v4 versions
      //TEL;TYPE=work,voice;VALUE=uri:tel:+1-111-555-1212
      //TEL;TYPE="voice,cell";VALUE=uri:tel:(956) 777-2692
      //TEL:956-777-2692
    }
    output += ":$phone";

    //-----email-----
    //v2 can specify as such 'EMAIL;HOME;INTERNET:$email'
    //v3 can specify as such 'EMAIL;type=HOME,INTERNET:$email'
    //v4 can specify as such 'EMAIL;type=HOME:$email'
    //all work like the one below though
    output += '''\nEMAIL$maybeCharset:$email''';

    //-----website-----
    //NOTE: basic features are shared
    //NOTE: this MUST NOT FAIL, so we specify charset
    output += '''\nURL$showCharset:$website''';

    //end
    return output += '''\nEND:VCARD''';
  }

  @override
  String toString() {
    return "use version specific functions";
  }
}

//in order to flip the colors when on a different background
//https://api.flutter.dev/flutter/dart-ui/ColorFilter-class.html
//we use an inverted color filter described here
//https://www.burkharts.net/apps/blog/over-the-rainbow-colour-filters/

//NOTE: this isnt currently implemented
class InvertColors extends StatelessWidget {
  InvertColors({
    @required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.matrix(
        [
          //R  G   B    A  Const
          -1, 0, 0, 0, 255, //
          0, -1, 0, 0, 255, //
          0, 0, -1, 0, 255, //
          0, 0, 0, 1, 0, //
        ],
      ),
      child: child,
    );
  }
}

//by default the background should be transparent
//that way we can change the background as we please
//but the QR code will most often appear with a black background
//so the default color to use to avoid using the inverted unless necesary
//is white
class AdjustableQrCode extends StatelessWidget {
  AdjustableQrCode({
    @required this.squaresColor,
  });

  final squaresColor;

  @override
  Widget build(BuildContext context) {
    //No Point in Allowing Switching
    //IF ANYTHING we should use automatic switching
    //V4 has alot of variability
    /*
    QrCode qrCode = new QrCode.fromData(
      data: MyVCard(
        firstName: 'Bryan',
        lastName: 'Cancel',
        title: "Software Engineer/Developer",
        phone: "(956) 777-2692",
        email: "bryan.o.cancel@gmail.com",
        website: 'https://b-cancel.github.io',
      ).getV3(),
      //this is only necessary for print
      //where redundancy helps to correct whatever peice we don't see
      errorCorrectLevel: QrErrorCorrectLevel.L,
    );

    //make the qr code
    qrCode.make();

    //create qr code widget
    List<Widget> columnChildren = new List<Widget>();

    //each row is a one of the columns children
    for (int row = 0; row < qrCode.moduleCount; row++) {
      //compile all the children for Row X
      List<Widget> newRowChildren = new List<Widget>();

      //for Row X grab the data from all of its columns
      for (int col = 0; col < qrCode.moduleCount; col++) {
        bool shouldFill = qrCode.isDark(row, col);
        newRowChildren.add(Container(
          height: 1,
          width: 1,
          color: shouldFill ? squaresColor : Colors.transparent,
        ));
      }

      //add this new row as a child
      columnChildren.add(
        Row(
          children: newRowChildren,
        ),
      );
    }

    //assemble all the rows we grabbed into a column
    Widget qrCodeWidget = Column(
      children: columnChildren,
    );*/

    String data = MyVCard(
      firstName: 'Bryan',
      lastName: 'Cancel',
      title: "Software Engineer/Developer",
      phone: "(956) 777-2692",
      email: "bryan.o.cancel@gmail.com",
      website: 'https://b-cancel.github.io',
    ).getV3();

    //build it
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.contain,
        child: PrettyQr(
          elementColor:
              squaresColor == Colors.black ? Colors.white : Colors.black,
          errorCorrectLevel: QrErrorCorrectLevel.M,
          typeNumber: calculateTypeNumberFromData(
            QrErrorCorrectLevel.M,
            [byte.QrByte(data)],
          ),
          data: data,
          //NOTE: rounding edges looks cool
          //NOTE: adding a vcard icon in the middle looks cool
          //but BOTH make it harder to read the QR Code
        ),
      ),
    );
  }

  //functions below taken from qr plugin
  calculateTypeNumberFromData(
    int errorCorrectLevel,
    List<byte.QrByte> dataList,
  ) {
    int typeNumber;
    for (typeNumber = 1; typeNumber < 40; typeNumber++) {
      final rsBlocks =
          rsBlock.QrRsBlock.getRSBlocks(typeNumber, errorCorrectLevel);

      final buffer = QrBitBuffer();
      var totalDataCount = 0;
      for (var i = 0; i < rsBlocks.length; i++) {
        totalDataCount += rsBlocks[i].dataCount;
      }

      for (var i = 0; i < dataList.length; i++) {
        final data = dataList[i];
        buffer
          ..put(data.mode, 4)
          ..put(data.length, lengthInBits(data.mode, typeNumber));
        data.write(buffer);
      }
      if (buffer.length <= totalDataCount * 8) break;
    }
    return typeNumber;
  }

  int lengthInBits(int mode, int type) {
    if (1 <= type && type < 10) {
      // 1 - 9
      switch (mode) {
        case qr_mode.modeNumber:
          return 10;
        case qr_mode.modeAlphaNum:
          return 9;
        case qr_mode.mode8bitByte:
          return 8;
        case qr_mode.modeKanji:
          return 8;
        default:
          throw ArgumentError('mode:$mode');
      }
    } else if (type < 27) {
      // 10 - 26
      switch (mode) {
        case qr_mode.modeNumber:
          return 12;
        case qr_mode.modeAlphaNum:
          return 11;
        case qr_mode.mode8bitByte:
          return 16;
        case qr_mode.modeKanji:
          return 10;
        default:
          throw ArgumentError('mode:$mode');
      }
    } else if (type < 41) {
      // 27 - 40
      switch (mode) {
        case qr_mode.modeNumber:
          return 14;
        case qr_mode.modeAlphaNum:
          return 13;
        case qr_mode.mode8bitByte:
          return 16;
        case qr_mode.modeKanji:
          return 12;
        default:
          throw ArgumentError('mode:$mode');
      }
    } else {
      throw ArgumentError('type:$type');
    }
  }
}
