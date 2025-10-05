import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';


final videoPlayerControllerProvider =
StateNotifierProvider<VideoRotatorNotifier, VideoPlayerController?>(
      (ref) => VideoRotatorNotifier(),
);

class VideoRotatorNotifier extends StateNotifier<VideoPlayerController?> {
  VideoRotatorNotifier() : super(null) {
    _initializeAndPlay(0);
  }

  final List<String> _videoPaths = [
    'assets/videos/1.mp4',
    'assets/videos/2.mp4',
    'assets/videos/3.mp4',
    'assets/videos/4.mp4',
  ];
  int _currentIndex = 0;

  Future<void> _initializeAndPlay(int index) async {
    final controller = VideoPlayerController.asset(_videoPaths[index]);
    await controller.initialize();
    controller.play();
    controller.setLooping(false);

    // listener setup
    controller.addListener(() async {
      final position = controller.value.position;
      final duration = controller.value.duration;
      final ended = !controller.value.isPlaying &&
          position >= duration &&
          duration != Duration.zero;

      if (ended) {
        controller.removeListener(() {});
        await controller.dispose();

        _currentIndex = (_currentIndex + 1) % _videoPaths.length;
        _initializeAndPlay(_currentIndex);
      }
    });

    state = controller;
  }

  @override
  void dispose() {
    state?.dispose();
    super.dispose();
  }
}
