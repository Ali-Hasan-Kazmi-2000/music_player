import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:music_player/Constants/app_colors.dart' as AppColors;
import 'package:music_player/files/audio.dart';

class DetailAudioPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final booksData;
  final int index;
  const DetailAudioPage({super.key, this.booksData, required this.index});

  @override
  State<DetailAudioPage> createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  late AudioPlayer advancedAudioPlayer;
  @override
  void initState() {
    super.initState();
    advancedAudioPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWeight = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.audioBluishBackground,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight / 4,
            child: Container(
              color: AppColors.audioBlueBackground,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  {
                    Navigator.of(context).pop();
                  }
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    {}
                  },
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenWeight * 0.42,
            height: screenHeight * 0.4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Text(
                    this.widget.booksData[this.widget.index]["name"],
                    style: const TextStyle(
                        fontSize: 30,
                        fontFamily: "Avenir",
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    this.widget.booksData[this.widget.index]["author"],
                    style: const TextStyle(
                        fontSize: 20,
                        fontFamily: "Avenir",
                        fontWeight: FontWeight.bold),
                  ),
                  AudioFile(
                      advancedAudioPlayer: advancedAudioPlayer,
                      audioPath: this.widget.booksData[this.widget.index]
                          ["url"]),
                ],
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.12,
            left: (screenWeight - 150) / 2,
            right: (screenWeight - 150) / 2,
            height: screenHeight * 0.16,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.audioGrayBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 3),
                    image: DecorationImage(
                        image: AssetImage(
                            this.widget.booksData[this.widget.index]["img"]),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
