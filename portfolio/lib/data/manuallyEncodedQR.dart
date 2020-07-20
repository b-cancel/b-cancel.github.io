//plugin import 'package:vcard/vcard.dart';
//wiki
/*
BEGIN:VCARD
VERSION:2.1
N:Gump;Forrest;;Mr.
FN:Forrest Gump
ORG:Bubba Gump Shrimp Co.
TITLE:Shrimp Man
PHOTO;GIF:http://www.example.com/dir_photos/my_photo.gif
TEL;WORK;VOICE:(111) 555-1212
TEL;HOME;VOICE:(404) 555-1212
ADR;WORK;PREF:;;100 Waters Edge;Baytown;LA;30314;United States of America
LABEL;WORK;PREF;ENCODING=QUOTED-PRINTABLE;CHARSET=UTF-8:100 Waters Edge=0D=
 =0ABaytown\, LA 30314=0D=0AUnited States of America
ADR;HOME:;;42 Plantation St.;Baytown;LA;30314;United States of America
LABEL;HOME;ENCODING=QUOTED-PRINTABLE;CHARSET=UTF-8:42 Plantation St.=0D=0A=
 Baytown, LA 30314=0D=0AUnited States of America
EMAIL:forrestgump@example.com
REV:20080424T195243Z
END:VCARD
*/

//plugin
String currentv2 = '''BEGIN:VCARD
VERSION:2.1
FN;CHARSET=UTF-8:Bryan Cancel
N;CHARSET=UTF-8:Cancel;Bryan;;;
EMAIL;CHARSET=UTF-8;HOME;INTERNET:bryan.o.cancel@gmail.com
TEL;TYPE=CELL:(956) 777-2692
TITLE;CHARSET=UTF-8:Software Engineer/Developer
URL;CHARSET=UTF-8:https://b-cancel.github.io/
REV:2020-07-20T12:20:59.940
END:VCARD''';

//some website
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

//wiki
/*
BEGIN:VCARD
VERSION:3.0
N:Gump;Forrest;;Mr.;
FN:Forrest Gump
ORG:Bubba Gump Shrimp Co.
TITLE:Shrimp Man
PHOTO;VALUE=URI;TYPE=GIF:http://www.example.com/dir_photos/my_photo.gif
TEL;TYPE=WORK,VOICE:(111) 555-1212
TEL;TYPE=HOME,VOICE:(404) 555-1212
ADR;TYPE=WORK,PREF:;;100 Waters Edge;Baytown;LA;30314;United States of America
LABEL;TYPE=WORK,PREF:100 Waters Edge\nBaytown\, LA 30314\nUnited States of America
ADR;TYPE=HOME:;;42 Plantation St.;Baytown;LA;30314;United States of America
LABEL;TYPE=HOME:42 Plantation St.\nBaytown\, LA 30314\nUnited States of America
EMAIL:forrestgump@example.com
REV:2008-04-24T19:52:43Z
END:VCARD
*/

//plugin
String currentv3 = '''BEGIN:VCARD
VERSION:3.0
FN;CHARSET=UTF-8:Bryan Cancel
N;CHARSET=UTF-8:Cancel;Bryan;;;
NICKNAME;CHARSET=UTF-8:
EMAIL;CHARSET=UTF-8;type=HOME,INTERNET:bryan.o.cancel@gmail.com
TEL;TYPE=CELL:(956) 777-2692
TITLE;CHARSET=UTF-8:Software Engineer/Developer
URL;CHARSET=UTF-8:https://b-cancel.github.io/
REV:2020-07-20T12:22:16.993
END:VCARD''';

//some website
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

//wiki
/*
BEGIN:VCARD
VERSION:4.0
N:Gump;Forrest;;Mr.;
FN:Forrest Gump
ORG:Bubba Gump Shrimp Co.
TITLE:Shrimp Man
PHOTO;MEDIATYPE=image/gif:http://www.example.com/dir_photos/my_photo.gif
TEL;TYPE=work,voice;VALUE=uri:tel:+1-111-555-1212
TEL;TYPE=home,voice;VALUE=uri:tel:+1-404-555-1212
ADR;TYPE=WORK;PREF=1;LABEL="100 Waters Edge\nBaytown\, LA 30314\nUnited States of America":;;100 Waters Edge;Baytown;LA;30314;United States of America
ADR;TYPE=HOME;LABEL="42 Plantation St.\nBaytown\, LA 30314\nUnited States of America":;;42 Plantation St.;Baytown;LA;30314;United States of America
EMAIL:forrestgump@example.com
REV:20080424T195243Z
x-qq:21588891
END:VCARD
*/

//plugin
String currentv4 = '''BEGIN:VCARD
VERSION:4.0
FN:Bryan Cancel
N:Cancel;Bryan;;;
NICKNAME:
EMAIL;type=HOME:bryan.o.cancel@gmail.com
TEL;VALUE=uri;TYPE="voice,cell":tel:(956) 777-2692
TITLE:Software Engineer/Developer
URL:https://b-cancel.github.io/
REV:2020-07-20T12:25:17.579
END:VCARD''';

//some website
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
