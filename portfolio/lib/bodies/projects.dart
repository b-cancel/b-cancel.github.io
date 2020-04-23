import 'package:flutter/material.dart';

//Image.network("https://fuss10.elemecdn.com/c/db/d20d49e5029281b9b73db1c5ec6f9jpeg.jpeg%3FimageMogr/format/webp/thumbnail/!90x90r/gravity/Center/crop/90x90"),
//https://source.unsplash.com/random/NUMBER
class ProjectsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      Center(
        child: SizedBox(
          height: 500,
          width: 250,
          child: Container(
            color: Colors.red,
            height: 500,
            width: 250,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 250,
          width: 400,
          child: Container(
            color: Colors.green,
            height: 250,
            width: 400,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 350,
          width: 350,
          child: Container(
            color: Colors.blue,
            height: 350,
            width: 350,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 900,
          width: 100,
          child: Container(
            color: Colors.grey,
            height: 900,
            width: 100,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 250,
          width: 400,
          child: Container(
            color: Colors.green,
            height: 250,
            width: 400,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 350,
          width: 350,
          child: Container(
            color: Colors.blue,
            height: 350,
            width: 350,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 250,
          width: 400,
          child: Container(
            color: Colors.green,
            height: 250,
            width: 400,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 350,
          width: 350,
          child: Container(
            color: Colors.blue,
            height: 350,
            width: 350,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 900,
          width: 100,
          child: Container(
            color: Colors.grey,
            height: 900,
            width: 100,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 350,
          width: 350,
          child: Container(
            color: Colors.blue,
            height: 350,
            width: 350,
          ),
        ),
      ),
      Center(
        child: SizedBox(
          height: 900,
          width: 100,
          child: Container(
            color: Colors.grey,
            height: 900,
            width: 100,
          ),
        ),
      ),
    ];
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
        right: 24,
      ),
      height: 320,
      color: Colors.yellow,
      child: Column(
        children: <Widget>[
          /*
          ListView.separated(
            scrollDirection: Axis.horizontal,
            primary: false,
            shrinkWrap: false,
            padding: EdgeInsets.all(0),
            itemCount: items.length,
            itemBuilder: (context, index){
              return items[index];
            },
            separatorBuilder: (context, int){
              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                height: 320,
                width: 2,
                color: MyApp.oldGrey,
              );
            }
          ),
          */
          //buttons that let you pick the picture directly
          /*
          Container(
            height: 48,
            child: Row(
              children: <Widget>[

              ],
            ),
          ),
          */
        ],
      ),
    );
  }
}

/*
Competitive Programming at HackerRank and TopCoder
Developer Tools For Unity 3D (soon to be on the 2017 Unity 3D Asset Store) [some are public on github]
● Outline Kit (with Game Objects) - Create outlines around 2D Sprites
Created because current open source solutions where to slow, looked gimmicky, and lacked features
● Color Kit - Experiment with different color mixing and color linear interpolation algorithms
Created because color mixing is subjective and no tool existed that allowed you to experiment with
current open source solutions. The library also allows you to easily test out your own mixing algorithms.
 Linear Interpolation Kit – Functions to aid in completing linear interpolations in an ammount of time
● Tap Sequence Detector - Detect Taps, and Holds to trigger commands in your games
Game Development Projects (using Unity3D Game Engine in C#)
● Squishables - Innovative Physics Based Cooperative 2D platformer where you control your character’s
velocity, acceleration, and impulse/jerk vector to keep you and your friends alive (senior project)
● Prototypes - All About The Chase | Super Retriever | Delta Pong
Hackathon Projects at (HackTexas, HackRice, CodeRed)
● Real Air Guitar - the Myo armband to detected fretting and the Oculus to put you on stage
● Fruit Ninja with Full Body Tracking - using the Kinect
Technology Student Association, TSA, Member (2012 – 2014) | Treasurer (2013 – 2014)
● Served as captain for all the events August 2012 – June 2014
*/