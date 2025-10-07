import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

/// ভিডিও সিকোয়েন্স শেষ হয়েছে কি না।
final videoSequenceCompletedProvider = StateProvider<bool>((ref) => false);

final videoPlayerControllerProvider =
StateNotifierProvider<VideoRotatorNotifier, VideoPlayerController?>(
      (ref) => VideoRotatorNotifier(ref),
);

class VideoRotatorNotifier extends StateNotifier<VideoPlayerController?> {
  VideoRotatorNotifier(this.ref) : super(null) {
    _initializeAndPlay(0);
  }

  final Ref ref;

  final List<String> _videoPaths = const [
    'assets/videos/1.mp4',
    'assets/videos/2.mp4',
    'assets/videos/3.mp4',
    'assets/videos/4.mp4',
  ];

  int _currentIndex = 0;
  bool _hasCompleted = false; // একবারই ট্রিগার করবে

  VoidCallback? _attachedListener;

  Future<void> _initializeAndPlay(int index) async {
    // আগের কন্ট্রোলার/লিসেনার ক্লিনআপ
    if (state != null) {
      if (_attachedListener != null) {
        state!.removeListener(_attachedListener!);
      }
      await state!.dispose();
    }

    final controller = VideoPlayerController.asset(_videoPaths[index]);
    await controller.initialize();
    controller.setLooping(false);
    await controller.play();

    // সঠিকভাবে remove করার জন্য listener রেফারেন্স ধরে রাখি
    _attachedListener = () async {
      final v = controller.value;
      final ended = !v.isPlaying &&
          v.position >= v.duration &&
          v.duration != Duration.zero;

      if (ended) {
        // এই কন্ট্রোলার থেকে লিসেনার খুলে দিন
        if (_attachedListener != null) controller.removeListener(_attachedListener!);

        // লাস্ট ভিডিও কিনা দেখুন
        final isLast = _currentIndex >= _videoPaths.length - 1;

        if (isLast) {
          if (!_hasCompleted) {
            _hasCompleted = true;
            // সিকোয়েন্স শেষ—স্টেট ক্লিয়ার করুন
            await controller.dispose();
            state = null;

            // Riverpod ফ্ল্যাগ true করুন (UI থেকে ন্যাভিগেট করবে)
            ref.read(videoSequenceCompletedProvider.notifier).state = true;
          }
        } else {
          // পরের ভিডিও প্লে করুন
          _currentIndex++;
          _initializeAndPlay(_currentIndex);
        }
      }
    };

    controller.addListener(_attachedListener!);
    state = controller;
  }

  /// চাইলে আবার শুরু করতে পারবেন
  Future<void> restart() async {
    _hasCompleted = false;
    ref.read(videoSequenceCompletedProvider.notifier).state = false;
    _currentIndex = 0;
    await _initializeAndPlay(_currentIndex);
  }

  @override
  Future<void> dispose() async {
    if (state != null) {
      if (_attachedListener != null) {
        state!.removeListener(_attachedListener!);
      }
      await state!.dispose();
    }
    super.dispose();
  }
}