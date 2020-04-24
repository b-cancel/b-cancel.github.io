//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/bodies/projects/projects.dart';

List<String> emptyList(int count){
  return List.generate(10, (index) => "");
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubSection(
            label: "Released",
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Swol",
                  description: "Swol helps you use One Rep Max Equations to reach your Weightlifting Goals Faster."
                  "Know exactly how much weight you should be lifting given your training type and your previous set,"
                  + "so that you are always pushing at your max but never beyond it to avoid injury and maximize results.",
                  github: "https://github.com/b-cancel/swol",
                  googlePlayLink: "https://play.google.com/store/apps/details?id=the.swol.app",
                  imageUrls: emptyList(10),
                ),
              ],
            ),
          ),
          SubSection(
            label: "Prototypes",
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Half Life",
                  description: "Keep track of the active dosage of medications\n"
                  + "given their half life, so you can adjust your dosage\n" 
                  + "until the side effects are worth the desired effects.",
                  github: "https://github.com/b-cancel/halfLife",
                  imageUrls: emptyList(1),
                ),
                ProjectSection(
                  label: "Leashed",
                  description: "Create a digital Leash between your Bluetooth Devices and your phone to avoid loss. Prevention > Recovery.",
                  github: "https://github.com/b-cancel/Leashed_Public",
                  imageUrls: emptyList(4),
                ),
              ],
            ),
          ),
          SubSection(
            label: "Toolkits",
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Contact Picker",
                  description: "Select, Create, and Delete Contacts." 
                  + " Handles permission requests for contacts, camera, and photo gallery."
                  " And allows you to quickly jump to a section of contacts with an adaptive scroll bar.",
                  github: "https://github.com/b-cancel/Flutter_ContactPicker",
                  imageUrls: emptyList(4),
                ),
                ProjectSection(
                  label: "Timer & Stopwatch",
                  description: "A re-usable timer and stopwatch with all the functionality you would expect.",
                  github: "https://github.com/b-cancel/Flutter_Timer_And_Stopwatch",
                  imageUrls: emptyList(1),
                ),
                ProjectSection(
                  label: "Material Sheets",
                  description: "Material sheets that can come in from every direction,"
                  + " with the full control, gestures, handles and more.",
                  github: "https://github.com/b-cancel/Flutter_MaterialSheetAndNavigationDrawer",
                  imageUrls: emptyList(1),
                ),
              ],
            ),
          ),
          SubSection(
            label: "Assignments",
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Tip Calculator",
                  description: "A Tip Calculator with a very detailed text input formatter",
                  github: "https://github.com/b-cancel/Flutter_CurrencyTextInputFormatter",
                  imageUrls: emptyList(1),
                ),
                ProjectSection(
                  label: "Score Keeper",
                  description: "Keep track of the time and points during a Jiu Jitsu match",
                  github: "https://github.com/b-cancel/Flutter_Cute_Score_Keeper",
                  imageUrls: emptyList(1),
                ),
                ProjectSection(
                  label: "Aero Press Timer Clone",
                  description: "Make the perfect coffee every time",
                  github: "https://github.com/b-cancel/Flutter_AeroPress_Timer_Partial_Clone",
                  imageUrls: emptyList(1),
                ),
                ProjectSection(
                  label: "Instagram Clone",
                  description: "A clone of instagram with flutter",
                  github: "https://github.com/b-cancel/Flutter_Instagram",
                  imageUrls: emptyList(1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}