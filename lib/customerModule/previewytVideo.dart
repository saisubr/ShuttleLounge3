import 'package:flutter/material.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart'; // for fallback open

class PreviewytVideo extends StatefulWidget {
  final String ytUrl;

  const PreviewytVideo({
    Key? key,
    required this.ytUrl,
  }) : super(key: key);

  @override
  State<PreviewytVideo> createState() => _PreviewytVideoState();
}

class _PreviewytVideoState extends State<PreviewytVideo> {
  YoutubePlayerController? controller;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();

    debugPrint('initState() called for PreviewytVideo');
    debugPrint('Incoming YouTube URL: ${widget.ytUrl}');

    if (widget.ytUrl.isNotEmpty) {
      String? videoId = YoutubePlayer.convertUrlToId(widget.ytUrl);
      debugPrint('Parsed videoId: $videoId');

      if (videoId != null && videoId.isNotEmpty) {
        controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            enableCaption: true,
            mute: false,
            forceHD: true,
          ),
        );
        _isValid = true;
        debugPrint('YouTubePlayerController initialized successfully');
      } else {
        debugPrint('Could not extract video ID from URL');
      }
    } else {
      debugPrint('No YouTube URL provided to PreviewytVideo');
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    debugPrint('Controller disposed');
    super.dispose();
  }

  Future<void> _openInBrowser() async {
    final url = Uri.parse(widget.ytUrl);
    if (await canLaunchUrl(url)) {
      debugPrint('Launching YouTube video in browser: ${widget.ytUrl}');
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch browser for URL: ${widget.ytUrl}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const CustomText(
          text: 'Preview YouTube Video',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          textcolor: Colors.black,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: _isValid ? _videoPlayer() : _errorWidget(),
          ),
        ),
      ),
    );
  }

  Widget _videoPlayer() {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: YoutubePlayer(
          controller: controller!,
          showVideoProgressIndicator: true,
          onReady: () {
            debugPrint('YouTube Player ready');
          },
          onEnded: (metaData) {
            debugPrint('Video playback ended');
          },
          bottomActions: const [
            SizedBox(width: 14.0),
            CurrentPosition(),
            SizedBox(width: 8.0),
            ProgressBar(isExpanded: true),
            RemainingDuration(),
            PlaybackSpeedButton(),
          ],
        ),
      ),
    );
  }

  Widget _errorWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 48),
        const SizedBox(height: 10),
        const Text(
          'Unable to load the YouTube video.',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: _openInBrowser,
          icon: const Icon(Icons.open_in_new),
          label: const Text('Open in YouTube App'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}

