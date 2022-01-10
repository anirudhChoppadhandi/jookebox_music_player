import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
      const MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: MyApp(),
          ),
        ),
      )
  );
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

 @override

  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = Duration();
  Duration position = Duration();

  bool playing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.grey,
      ),
      padding: const EdgeInsets.all(10),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.network('https://picsum.photos/200'),
          slider(),
          InkWell(
            onTap: (){
              getAudio();
            },
            child: Icon(
              playing == false
                  ? Icons.play_circle_outline
                  : Icons.pause_circle_outline,
              size: 100,
              color: Colors.black,

            ),
          )
        ],
      ),
    );
  }

  Widget slider() {
    return Slider.adaptive(
        min: 0.0,
        value: position.inSeconds.toDouble(),
        max: duration.inSeconds.toDouble(),
        onChanged:(double value){
          setState(() {
            audioPlayer.seek(Duration(seconds: value.toInt()));

          });
        }

    );
  }

  void getAudio() async {
    var url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";

    //playing is false by default
    if(playing){
      //pause song

      var res = await audioPlayer.pause();
      if(res == 1){
        setState(() {
          playing = false;
        });
      }
    }else{
      //play song

      var res = await audioPlayer.play(url,isLocal: true);
      if(res == 1){
        setState(() {
          playing = true;
        });
      }
    }

    audioPlayer.onDurationChanged.listen((Duration dd) {
      setState(() {
        duration = dd;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((Duration dd) {

      setState(() {
        position = dd;
      });

    });
  }
}
