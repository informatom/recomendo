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
  final RecommendationDetailState state;

  const AudioComment({Key key, @required this.recommendation, this.state})
      : super(key: key);

  @override
  State<AudioComment> createState() {
    return AudioCommentState(this.recommendation, this.state);
  }
}

class AudioCommentState extends State<AudioComment> {
  Recommendation recommendation;
  RecommendationDetailState state;
  bool isRecording = false;

  AudioCommentState(this.recommendation, this.state);

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(50.0), children: <Widget>[
      Center(child: isRecording ?
        RaisedButton(
            onPressed: () => stopRecording(state),
            child: Text("Stop Recording")
        ) :
        RaisedButton(
            onPressed: recordComment,
            child: Text("Start Recording"))),

      Center(child: recommendation.audioComment != null ?
        RaisedButton(
            onPressed: () => play(path: recommendation.audioComment),
            child: Text("Play")
        ) :
        Container()
      )
    ]);
  }

  Future recordComment() async {
    bool _hasPermissions = await AudioRecorder.hasPermissions;

    if (_hasPermissions == false) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      await PermissionHandler().requestPermissions([PermissionGroup.microphone]);
    };

    var uuid = Uuid();

    final directory = await getApplicationDocumentsDirectory();
    var fullPath = directory.path;
    var endPosition = fullPath.lastIndexOf('/');

    await AudioRecorder.start(
        path: await fullPath.substring(0, endPosition) + "/" + uuid.v1(),
        audioOutputFormat: AudioOutputFormat.AAC
    );
    setState(() => isRecording = true);
  }

  Future stopRecording(state) async {
    Recording recording = await AudioRecorder.stop();
    state.setState(() => recommendation.audioComment = recording.path);
    setState(() => isRecording = false);
  }

  Future play({String path}) async{
    if(path != null) {
      AudioPlayer audioPlayer = AudioPlayer();
      await audioPlayer.play(path, isLocal: true);
    }
  }
}
