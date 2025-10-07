import 'package:just_audio/just_audio.dart' as ap;

class AssetAudio {
  static ap.AudioPlayer player = ap.AudioPlayer();

  playAudio() async {
    player.setAsset('assets/audios/call_tone.mp3');
    player.setLoopMode(ap.LoopMode.one);

     await player.play();
  }

  stop() {
    if (player.playing) {
      player.stop();
    }
  }
}
