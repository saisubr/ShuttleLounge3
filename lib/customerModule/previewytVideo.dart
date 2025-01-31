import 'package:flutter/material.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PreviewytVideo extends StatefulWidget {
  final  String ytUrl;
  
   const PreviewytVideo(
      {Key? key,
      required this.ytUrl,
       })
      : super(key: key);


  @override
  State<PreviewytVideo> createState() => _PreviewytVideoState();
}

class _PreviewytVideoState extends State<PreviewytVideo> {
   late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
   
  if (widget.ytUrl.isNotEmpty) {
      String videoId = YoutubePlayer.convertUrlToId(widget.ytUrl) ?? '';
      controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ),
      );
    }
   
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const CustomText(text: 'Preview Youtube Video', fontSize: 20, fontWeight: FontWeight.w500, textcolor: Colors.black),
      leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back,color: Colors.black,size: 30,)),
     ),
     body: SafeArea(
      child: Container(
        margin: const EdgeInsets.only(right: 10,left: 10),
        child: Center(
          child: _videoplay() 
        ),
      )),
    );
  }
   Widget _videoplay() {
    if (widget.ytUrl.isEmpty) {
      return Container();
    }

    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: YoutubePlayer(
          showVideoProgressIndicator: true,
          bottomActions: [
            const SizedBox(width: 14.0),
            CurrentPosition(),
            const SizedBox(width: 8.0),
            RemainingDuration(),
            ProgressBar(isExpanded: true),
            const PlaybackSpeedButton(),
          ],
          controller: controller,
        ),
      ),
    );
  }
}