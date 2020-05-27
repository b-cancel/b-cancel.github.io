import 'package:flutter/material.dart';
import 'package:qr/qr.dart';

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
class AdjustableQrCode extends StatefulWidget {
  AdjustableQrCode({
    @required this.squaresColor,
  });

  final squaresColor;

  /*
  Future changeAddressSelected(BuildContext context) {
    FocusScope.of(context).unfocus();
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: widget.clientData.addresses.length,
          itemBuilder: (context, index) {
            AddressData thisAddress = widget.clientData.addresses[index];
            bool selectedIndex = index == selectedAddressIndex.value;
            FontWeight weight =
                selectedIndex ? FontWeight.bold : FontWeight.normal;
            return ListTile(
              onTap: () {
                //update value
                selectedAddressIndex.value = index;

                //remove modal
                Navigator.of(context).pop();
              },
              title: Text(
                thisAddress.address,
                style: TextStyle(
                  fontWeight: weight,
                  color: Colors.black,
                ),
              ),
              trailing: Text(
                thisAddress.city + ", " + thisAddress.state,
                style: TextStyle(
                  fontWeight: weight,
                  color: ThemeData.dark().cardColor,
                ),
              ),
            );
          },
        );
      },
    );
  }*/

  @override
  _AdjustableQrCodeState createState() => _AdjustableQrCodeState();
}

//TODO: make switcher
class _AdjustableQrCodeState extends State<AdjustableQrCode> {
  //start in version 2 which seems to have the most captibility
  final ValueNotifier<int> qrCodeVersion = new ValueNotifier(2);

  updateState(){
    if(mounted){
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    qrCodeVersion.addListener(updateState);
  }

  @override
  void dispose() { 
    qrCodeVersion.removeListener(updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //create the qr code data
    QrCode qrCode = new QrCode(
      qrCodeVersion.value, 
      //TODO: figure out what this is
      QrErrorCorrectLevel.L,
    );
    qrCode.addData("Hello, world in QR form!");
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
        newRowChildren.add(
          Container(
            height: 1,
            width: 1,
            color: shouldFill ? widget.squaresColor : Colors.transparent,
          )
        );
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
    );

    //build it
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.contain,
        child: qrCodeWidget,
      ),
    );
  }
}

String v2 = '''
BEGIN:VCARD
VERSION:2.1
N:Cancel;Bryan
FN:Bryan Cancel
TITLE:Software Engineer/Developer
TEL;HOME:9567772692
TEL;WORK:9567772692
TEL;FAX:9567772692
TEL;CELL;PREF:9567772692
EMAIL:bryan.o.cancel@gmail.com
URL:b-cancel.github.io
END:VCARD
''';

String v3 = '''
BEGIN:VCARD
VERSION:3.0
FN;CHARSET=UTF-8:Bryan Cancel
N;CHARSET=UTF-8:Cancel;Bryan;;;
EMAIL;CHARSET=UTF-8;type=HOME,INTERNET:bryan.o.cancel@gmail.com
TEL;TYPE=CELL:9567772692
TEL;TYPE=HOME,VOICE:9567772692
TEL;TYPE=WORK,VOICE:9567772692
TITLE;CHARSET=UTF-8:Software Engineer/Developer
ORG;CHARSET=UTF-8:None
URL;type=WORK;CHARSET=UTF-8:http://b-cancel.github.io/
REV:2020-04-15T15:05:08.598Z
END:VCARD
''';

String v4 = '''
BEGIN:VCARD
VERSION:4.0
N:Cancel;Bryan;;;
FN:Bryan Cancel
TITLE:Software Engineer/Developer
EMAIL:bryan.o.cancel@gmail.com
TEL:956-777-2692
URL:https://b-cancel.github.io/
END:VCARD
''';