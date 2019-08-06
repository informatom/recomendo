import 'package:flutter/material.dart';
import 'package:recomendo/models/recommendation.dart';
import 'package:recomendo/screens/recommendation_detail.dart';
import 'package:audio_recorder/audio_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioComment extends StatelessWidget {
  const AudioComment({Key key, @required this.recommendation, this.state})
      : super(key: key);

  final Recommendation recommendation;
  final RecommendationDetailState state;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Row(children: <Widget>[
      Expanded(child: Text(recommendation.audioComment ?? "No recording yet.")),
      Expanded(
          child: RaisedButton(
              onPressed: recordComment, child: Text("Record Comment")))
    ]);
  }

  Future recordComment() async {
    bool _hasPermissions = await AudioRecorder.hasPermissions;

    if(_hasPermissions == false){
      print("I am missing permissions!");
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      PermissionStatus storage = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
      print("storage ${storage}");
      await PermissionHandler().requestPermissions([PermissionGroup.microphone]);
      PermissionStatus microphone = await PermissionHandler().checkPermissionStatus(PermissionGroup.microphone);
      print("microphone ${microphone}");
    };

    await AudioRecorder.start(
        path: await _localPath,
        audioOutputFormat: AudioOutputFormat.AAC
    );
    Recording recording = await AudioRecorder.stop();

    state.setState(() {
      recommendation.audioComment = recording.path;
    });
  }


  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
