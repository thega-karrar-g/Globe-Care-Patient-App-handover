import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:record/record.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../core/assets_helper/app_images.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';
import '../../data/constants/booking_constants.dart';
import 'audio_player.dart';

class AudioRecorderWidget extends StatefulWidget {
  final void Function(String path) onStop;

  AudioRecorderWidget({Key? key, required this.onStop}) : super(key: key);

  @override
  _AudioRecorderWidgetState createState() => _AudioRecorderWidgetState();
}

class _AudioRecorderWidgetState extends State<AudioRecorderWidget> {
  bool _isRecording = false;
  bool _isPaused = false;
  int _recordDuration = 0;
  Timer? _timer;
  Timer? _ampTimer;
  final _audioRecorder = AudioRecorder();

  GetStorage box = GetStorage();
  final GlobalKey one = GlobalKey();

  @override
  void initState() {
    _isRecording = false;
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ampTimer?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(builder:(context) {
      if (box.read('hint') == null) {
        WidgetsBinding.instance.addPostFrameCallback(
                (_) => ShowCaseWidget.of(context).startShowCase([one]));

        box.write('hint', true);
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildRecordStopControl(),
              SizedBox(width: 20.w),
              _buildPauseResumeControl(),
              SizedBox(width: 20.w),
              Row(
                children: [
                  _buildText(),
                ],
              ),
            ],
          ),
          // if (_amplitude != null) ...[
          //   const SizedBox(height: 40),
          //   Text('Current: ${_amplitude?.current ?? 0.0}'),
          //   Text('Max: ${_amplitude?.max ?? 0.0}'),
          // ],
        ],
      );
    });
  }

  Widget _buildRecordStopControl() {
    late Widget icon;

    if (_isRecording || _isPaused) {
      icon = Icon(Icons.stop, color: AppColors.primaryColorGreen, size: 30.w);
      //color = AppColors.primaryColorGreen.withOpacity(0.1);
    } else {
      icon = Showcase(
          description: AppStrings.audioHint.tr,
          descTextStyle: AppStyles.primaryStyle(),
          targetBorderRadius: BorderRadius.circular(30.h),


          tooltipPadding:
              EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          key: one,
          targetPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
          child: SvgPicture.asset(
            AppImages.microphone,
            width: 25.w,
            height: 25.h,
          ));

      // color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: AppColors.subTitleColor.withOpacity(0),
        child: InkWell(
          child: SizedBox(width: 30.w, height: 30.h, child: icon),
          onTap: () {
            _isRecording ? _stop() : _start();
          },
        ),
      ),
    );
  }

  Widget _buildPauseResumeControl() {
    if (!_isRecording && !_isPaused) {
      return const SizedBox.shrink();
    }

    late Icon icon;
    late Color color;

    if (!_isPaused) {
      icon = Icon(Icons.pause, color: AppColors.primaryColorGreen, size: 30.w);
      color = AppColors.primaryColorGreen.withOpacity(0.1);
    } else {
      //final theme = Theme.of(context);
      icon = Icon(Icons.play_arrow,
          color: AppColors.primaryColorGreen, size: 30.w);
      color = AppColors.primaryColorGreen.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56.w, height: 56.h, child: icon),
          onTap: () {
            _isPaused ? _resume() : _pause();
          },
        ),
      ),
    );
  }

  Widget _buildText() {
    if (_isRecording || _isPaused) {
      return _buildTimer();
    }
    return Text(
      "30",
      style: AppStyles.primaryStyleGreen(),
    );
  }

  Widget _buildTimer() {
    // final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    if (_recordDuration == 10) {
      _stop();
    }

    return Text(
      '${30 - (int.parse(seconds))}',
      style: TextStyle(color: AppColors.primaryColor),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start(RecordConfig(),path: BookingConstants.audioFile!.path );

        bool isRecording = await _audioRecorder.isRecording();
        setState(() {
          _isRecording = isRecording;
          _recordDuration = 0;
        });

        _startTimer();
      }
    } catch (_) {}
  }

  Future<void> _stop() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    final path = await _audioRecorder.stop();

    widget.onStop(path!);

    setState(() => _isRecording = false);
  }

  Future<void> _pause() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    await _audioRecorder.pause();

    setState(() => _isPaused = true);
  }

  Future<void> _resume() async {
    _startTimer();
    await _audioRecorder.resume();

    setState(() => _isPaused = false);
  }

  void _startTimer() {
    _timer?.cancel();
    _ampTimer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });

    _ampTimer =
        Timer.periodic(const Duration(milliseconds: 200), (Timer t) async {
      setState(() {});
    });

    // if(_recordDuration==30){
    //   _audioRecorder.stop();
    // }
  }
}

class RecoredWidget extends StatefulWidget {
  const RecoredWidget({Key? key}) : super(key: key);

  @override
  _RecoredWidgetState createState() => _RecoredWidgetState();
}

class _RecoredWidgetState extends State<RecoredWidget> {
  bool showPlayer = false;
  ap.AudioSource? audioSource;

  @override
  void initState() {
    showPlayer = false;

    if (BookingConstants.audioFile != null) {
      audioSource = ap.AudioSource.uri(Uri.parse(BookingConstants.audioFile!.path));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: BookingConstants.audioFile != null
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: AudioPlayer(
                source: audioSource!,
                onDelete: () {
                  setState(() {
                    BookingConstants.audioFile = null;

                    showPlayer = false;
                  });
                },
              ),
            )
          : AudioRecorderWidget(
              onStop: (path) {
                setState(() {
                  BookingConstants.audioFile = File(path);

                  audioSource = ap.AudioSource.uri(
                      Uri.parse(BookingConstants.audioFile!.path));
                  showPlayer = true;
                });
              },
            ),
    );
  }
}
