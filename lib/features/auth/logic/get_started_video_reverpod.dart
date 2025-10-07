import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

// role
final roleProvider = StateProvider<String?>((_) => null);
final loadRoleProvider = FutureProvider<String?>((ref) async {
  final p = await SharedPreferences.getInstance();
  final r = p.getString('role');
  ref.read(roleProvider.notifier).state = r;
  return r;
});
final isClientProvider = Provider<bool>((ref) =>
(ref.watch(roleProvider) ?? '').trim().toLowerCase() == 'client');

// video sets
const _clientV = ['assets/videos/1.mp4','assets/videos/2.mp4','assets/videos/3.mp4','assets/videos/4.mp4'];
const _provV   = ['assets/videos/vendor1.mp4','assets/videos/vendor2.mp4','assets/videos/vendor3.mp4','assets/videos/vendor4.mp4'];
final videoPathsProvider = Provider<List<String>>((ref) =>
ref.watch(isClientProvider) ? _clientV : _provV);

// sequence flag
final videoSequenceCompletedProvider = StateProvider<bool>((_) => false);

// controller rotator
final videoCtlP = StateNotifierProvider<_Rot, VideoPlayerController?>((ref)=>_Rot(ref));
class _Rot extends StateNotifier<VideoPlayerController?> {
  _Rot(this.ref):super(null){ ref.listen<List<String>>(videoPathsProvider, (_, __)=>restart()); _play(0); }
  final Ref ref; int _i=0; bool _done=false; VoidCallback? _lis;
  List<String> get _paths => ref.read(videoPathsProvider);

  Future<void> _play(int i) async {
    if(state!=null){ if(_lis!=null) state!.removeListener(_lis!); await state!.dispose(); }
    final c = VideoPlayerController.asset(_paths[i]);
    await c.initialize(); c.setLooping(false); await c.play();
    _lis = () async {
      final v=c.value, ended=!v.isPlaying && v.position>=v.duration && v.duration!=Duration.zero;
      if(!ended) return;
      if(_lis!=null) c.removeListener(_lis!);
      final last = _i>=_paths.length-1;
      if(last){ if(_done) return; _done=true; await c.dispose(); state=null; ref.read(videoSequenceCompletedProvider.notifier).state=true; }
      else { _i++; _play(_i); }
    };
    c.addListener(_lis!); state=c;
  }

  Future<void> restart() async { _done=false; ref.read(videoSequenceCompletedProvider.notifier).state=false; _i=0; await _play(0); }
  @override Future<void> dispose() async { if(state!=null){ if(_lis!=null) state!.removeListener(_lis!); await state!.dispose(); } super.dispose(); }
}