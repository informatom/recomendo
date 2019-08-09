import 'package:flutter/material.dart';
import 'package:recomendo/models/recommendation.dart';
import 'package:recomendo/screens/recommendation_detail.dart';
import 'package:audio_recorder/audio_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioComment extends StatefulWidget {
  final Recommendation recommendation;
  final RecommendationDetailState parentWidget;

  const AudioComment({this.recommendation, this.parentWidget});

  @override
  State<AudioComment> createState() => AudioCommentState();
}

class AudioCommentState extends State<AudioComment> {
  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(50.0), children: <Widget>[
      Center(child: isRecording ?
        RaisedButton(
            onPressed: stopRecording,
            child: Text("Stop Recording")
        ) :
        RaisedButton(
            onPressed: startRecording,
            child: Text("Start Recording"))),

      Center(child: widget.recommendation.audioComment != null ?
        RaisedButton(
            onPressed: play,
            child: Text("Play")
        ) :
        Container()
      )
    ]);
  }

  Future startRecording() async {
    bool _hasPermissions = await AudioRecorder.hasPermissions;
    var uuid = Uuid();
    final directory = await getApplicationDocumentsDirectory();
    var fullPath = directory.path;
    var endPosition = fullPath.lastIndexOf('/');

    if (_hasPermissions == false) {
      await PermissionHandler().requestPermissions([
        PermissionGroup.storage,
        PermissionGroup.microphone
      ]);
    };

    await AudioRecorder.start(
        path: await fullPath.substring(0, endPosition) + "/" + uuid.v1(),
        audioOutputFormat: AudioOutputFormat.AAC
    );
    setState(() => isRecording = true);
  }

  Future stopRecording() async {
    Recording recording = await AudioRecorder.stop();
    widget.parentWidget.setState(() => widget.recommendation.audioComment = recording.path);
    setState(() => isRecording = false);
  }

  Future play() async{
    if(widget.recommendation.audioComment != null) {
      AudioPlayer audioPlayer = AudioPlayer();
      await audioPlayer.play(widget.recommendation.audioComment, isLocal: true);
    }
  }
}
