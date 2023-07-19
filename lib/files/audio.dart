import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedAudioPlayer;
  final String audioPath;
  const AudioFile(
      {super.key, required this.advancedAudioPlayer, required this.audioPath});

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  // String path = this.widget.audioPath;
  bool isPlaying = false;
  bool isPaused = false;
  bool isLoop = false;
  final List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];

  @override
  void initState() {
    super.initState();
    this.widget.advancedAudioPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    this.widget.advancedAudioPlayer.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
    this.widget.advancedAudioPlayer.setSourceUrl(this.widget.audioPath);
  }

  Widget btnStart() {
    return IconButton(
        padding: const EdgeInsets.only(bottom: 10),
        onPressed: () async {
          if (isPlaying == false) {
            await widget.advancedAudioPlayer
                .play(UrlSource(this.widget.audioPath));
            setState(() {
              isPlaying = true;
            });
          } else if (isPlaying == true) {
            await widget.advancedAudioPlayer.pause();
            setState(() {
              isPlaying = false;
            });
          }
        },
        icon: isPlaying == false
            ? Icon(_icons[0], size: 50, color: Colors.blue)
            : Icon(
                _icons[1],
                size: 50,
                color: Colors.blue,
              ));
  }

  Widget btnSlow() {
    return IconButton(
        onPressed: () {
          this.widget.advancedAudioPlayer.setPlaybackRate(0.5);
        },
        icon: ImageIcon(
          AssetImage("assets/backward.png"),
          size: 15,
          color: Colors.black,
        ));
  }

  Widget btnFast() {
    return IconButton(
        onPressed: () {
          this.widget.advancedAudioPlayer.setPlaybackRate(1.5);
        },
        icon: ImageIcon(
          AssetImage("assets/forward.png"),
          size: 15,
          color: Colors.black,
        ));
  }

  Widget loadAsset() {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            btnSlow(),
            btnStart(),
            btnFast(),
          ]),
    );
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.red,
        inactiveColor: Colors.grey,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });
        });
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    this.widget.advancedAudioPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _position.toString().split(".")[0],
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                _duration.toString().split(".")[0],
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        slider(),
        loadAsset(),
      ]),
    );
  }
}
