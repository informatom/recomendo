import 'package:flutter/material.dart';
import 'package:recomendo/models/recommendation.dart';
import 'package:recomendo/screens/recommendation_detail.dart';
import 'package:audio_recorder/audio_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioComment extends StatelessWidget {
  const AudioComment({Key key, @required this.recommendation, this.state})
      : super(key: key);

  final Recommendation recommendation;
  final RecommendationDetailState state;


  @override
  Widget build(BuildContext context) {
    AudioPlayer audioPlayer = AudioPlayer();
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return ListView(children: <Widget>[
      Text(recommendation.audioComment ?? "No recording yet."),
      RaisedButton(onPressed: recordComment, child: Text("Start Recording")),
      RaisedButton(onPressed: stopRecording, child: Text("Stop Recording")),
      RaisedButton(onPressed: () => play(path: recommendation.audioComment),
                   child: Text("Play")),
    ]);
  }

  Future recordComment() async {
    bool _hasPermissions = await AudioRecorder.hasPermissions;

    if (_hasPermissions == false) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      PermissionStatus storage = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      await PermissionHandler()
          .requestPermissions([PermissionGroup.microphone]);
      PermissionStatus microphone = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.microphone);
    };

    var uuid = Uuid();

    final directory = await getApplicationDocumentsDirectory();
    var fullPath = directory.path;
    var endPosition = fullPath.lastIndexOf('/');

    await AudioRecorder.start(
        path: await fullPath.substring(0, endPosition) + "/" + uuid.v1(),
        audioOutputFormat: AudioOutputFormat.AAC);
  }

  Future stopRecording() async {
    Recording recording = await AudioRecorder.stop();

    state.setState(() {
      recommendation.audioComment = recording.path;
    });
  }

  Future play({String path}) async{
    if(path != null) {
      AudioPlayer audioPlayer = AudioPlayer();
      await audioPlayer.play(path, isLocal: true);
    }
  }
}
