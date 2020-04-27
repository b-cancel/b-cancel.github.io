//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/bodies/projects/projects.dart';

List<String> emptyList(int count) {
  return List.generate(count, (index) => "");
}

//widget
class AppDevelopment extends StatelessWidget {
  const AppDevelopment({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DevelopmentSection(
      label: "App Development",
      initiallyOpened: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubSection(
            initiallyOpened: true,
            label: "Released",
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Swol",
                  description:
                      "Swol helps you use One Rep Max Equations to reach your Weightlifting Goals Faster."
                              "Know exactly how much weight you should be lifting given your training type and your previous set," +
                          "so that you are always pushing at your max but never beyond it to avoid injury and maximize results.",
                  github: "https://github.com/b-cancel/swol",
                  googlePlayLink:
                      "https://play.google.com/store/apps/details?id=the.swol.app",
                  initiallyOpened: true,
                  //imageUrls: emptyList(13),
                  imageUrls: [
                    //basic cycle
                    "https://media.giphy.com/media/kyoxrhAK1FqJbWe2UK/giphy.gif",
                    //add exercise
                    "https://media.giphy.com/media/QZ7sMYoyS9dtsjaYAn/giphy.gif",
                    //onboarding
                    "https://media.giphy.com/media/j1gKlO4uAZM10dYXya/giphy.gif",
                    //search
                    "https://media.giphy.com/media/kfjRaDaE7xzVNJdGfr/giphy.gif",
                    //calibration
                    "https://media.giphy.com/media/dC4FWH4NDOq76CUz68/giphy.gif",
                    //error checking
                    "https://media.giphy.com/media/YSqWsc9dSjkLTLUCWU/giphy.gif",
                    //notes
                    "https://media.giphy.com/media/Rgz7qmqwOImQxM8ygX/giphy.gif",
                    //learn section
                    "https://media.giphy.com/media/RLOvYGkKt6jvsIyovu/giphy.gif",
                  ],
                ),
              ],
            ),
          ),
          SubSection(
            label: "Prototypes",
            initiallyOpened: true,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Half Life",
                  description: "Keep track of the active dosage of medications" +
                      " given their half life, so you can adjust your dosage" +
                      " until the side effects are worth the desired effects.",
                  github: "https://github.com/b-cancel/halfLife",
                  initiallyOpened: true,
                  imageUrls: [
                    //change name scrub
                    "https://media.giphy.com/media/PiQF5YD82meF4uitmz/giphy.gif",
                    //add dose
                    "https://media.giphy.com/media/Rk2zzd9k9l6MBBLTBY/giphy.gif",
                  ],
                ),
                ProjectSection(
                  label: "Leashed",
                  description:
                      "Create a digital Leash between your Bluetooth Devices and your phone to avoid loss. Prevention > Recovery.",
                  github: "https://github.com/b-cancel/Leashed_Public",
                  initiallyOpened: true,
                  imageUrls: [
                    //find ble
                    "https://media.giphy.com/media/S8lbi2cusC5gVC0xOS/giphy.gif",
                    //main list
                    "https://media.giphy.com/media/RKMMj20eRHONfImd0L/giphy.gif",
                    //sos settings
                    "https://media.giphy.com/media/S6Zdj4EiS99DlVZuDS/giphy.gif",
                    //add new
                    "https://media.giphy.com/media/d5qOvltp866jRzktDZ/giphy.gif",
                  ],
                ),
              ],
            ),
          ),
          SubSection(
            label: "Toolkits",
            initiallyOpened: true,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Contact Picker",
                  description: "Select, Create, and Delete Contacts." +
                      " Handles permission requests for contacts, camera, and photo gallery."
                          " And allows you to quickly jump to a section of contacts with an adaptive scroll bar.",
                  github: "https://github.com/b-cancel/Flutter_ContactPicker",
                  initiallyOpened: true,
                  imageUrls: [
                    //videos
                    "https://media.giphy.com/media/Uqk7fPBnsNydSn2GZW/giphy.gif",
                    "https://media.giphy.com/media/W0QwfdozN3AFnw1sWn/giphy.gif",
                    "https://media.giphy.com/media/LM9EpmeAiYlIpSAcgH/giphy.gif",
                    "https://media.giphy.com/media/Xbh1CLWME0plFA8g2G/giphy.gif",
                    "https://media.giphy.com/media/UT4byKMOmrYWk8dTmb/giphy.gif",
                    //jpgs
                    /*
                    "https://imgur.com/YWYmyOt.jpg",
                    "https://imgur.com/9XWVhy3.jpg",
                    "https://imgur.com/jdxaWT0.jpg",
                    "https://imgur.com/yASI0vn.jpg",
                    "https://imgur.com/TDzYvgI.jpg",
                    */
                  ],
                ),
                ProjectSection(
                  label: "Timer & Stopwatch",
                  description:
                      "A re-usable timer and stopwatch with all the functionality you would expect.",
                  github:
                      "https://github.com/b-cancel/Flutter_Timer_And_Stopwatch",
                      
                  initiallyOpened: false,
                  imageUrls: [
                  "https://media.giphy.com/media/DQdmcrEwAFqneM6tiL/giphy.gif",
                  "https://media.giphy.com/media/5qFCRiENukaLzB7Yoy/giphy.gif",
                  ],
                ),
                ProjectSection(
                  label: "Material Sheets",
                  description:
                      "Material sheets that can come in from every direction," +
                          " with the full control, gestures, handles and more.",
                  github:
                      "https://github.com/b-cancel/Flutter_MaterialSheetAndNavigationDrawer",
                  initiallyOpened: false,
                  imageUrls: [
                    "https://media.giphy.com/media/35KhYdJ9CQAN6hzYbQ/giphy.gif",
                    "https://media.giphy.com/media/dkXLQACALhF6puhk3I/giphy.gif",
                    "https://media.giphy.com/media/dYng1K8blxvnsLhP81/giphy.gif",
                    "https://media.giphy.com/media/9rsWxrJaYOhCQbRDXD/giphy.gif",
                  ],
                ),
              ],
            ),
          ),
          SubSection(
            label: "Assignments",
            initiallyOpened: false,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Instagram Clone",
                  description: "A clone of instagram with flutter",
                  github: "https://github.com/b-cancel/Flutter_Instagram",
                  initiallyOpened: true,
                  imageUrls: [
                    "https://media.giphy.com/media/UsT0dPQlVrVrJ4BC1z/giphy.gif",
                    "https://media.giphy.com/media/KezTdVWA3JIOS3fwX5/giphy.gif",
                    "https://media.giphy.com/media/S8BPNPf8i1CCYgv3LQ/giphy.gif",
                    "https://media.giphy.com/media/LSc6Y83JW98nX47nYe/giphy.gif",
                    "https://media.giphy.com/media/jUKJlmNzhbLRhetFtW/giphy.gif",
                  ],
                ),
                ProjectSection(
                  label: "Tip Calculator",
                  description:
                      "A Tip Calculator with a very detailed text input formatter",
                  github:
                      "https://github.com/b-cancel/Flutter_CurrencyTextInputFormatter",
                  initiallyOpened: false,
                  imageUrls: [
                    "https://media.giphy.com/media/kBNoowA21gf9gsg69j/giphy.gif",
                  ],
                ),
                ProjectSection(
                  label: "Score Keeper",
                  description:
                      "Keep track of the time and points during a Jiu Jitsu match",
                  github:
                      "https://github.com/b-cancel/Flutter_Cute_Score_Keeper",
                  initiallyOpened: false,
                  imageUrls: [
                    "https://media.giphy.com/media/j6prIja63xwUJmMLM5/giphy.gif",
                  ],
                ),
                ProjectSection(
                  label: "Aero Press Timer Clone",
                  description: "Make the perfect coffee every time",
                  github:
                      "https://github.com/b-cancel/Flutter_AeroPress_Timer_Partial_Clone",
                  initiallyOpened: false,
                  imageUrls: [
                    "https://media.giphy.com/media/H1RmERiJD4D3pL8wKG/giphy.gif",
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
