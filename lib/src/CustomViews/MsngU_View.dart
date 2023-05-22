import 'dart:async';
import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:betamsngu/src/Firebase_Objects/Usuario.dart';
import 'package:betamsngu/src/Singleton/DataHolder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MsngU_View extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MsngU_View();
  }
}

class _MsngU_View extends State<MsngU_View> {
  List<Usuario> Friends = [];
  FirebaseFirestore db = FirebaseFirestore.instance;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _showSendButton = false;
  FlutterSoundRecorder? _audioRecorder;
  FlutterSoundPlayer? _audioPlayer;
  bool _isRecording = false;
  bool _isPlaying = false;
  String? _audioFilePath;
  Timer? _timer;
  int _recordDuration = 0;



  @override
  void initState() {
    super.initState();
    _initializeAudio();
  }

  void _initializeAudio() async {
    _audioRecorder = FlutterSoundRecorder();
    await _audioRecorder!.openRecorder();
    _audioPlayer = FlutterSoundPlayer();
    await _audioPlayer!.openPlayer();

  }

//Métodos para Grabar un mensaje de Voz:
  Future<void> _startRecording() async {
    if (_isRecording) return;

    try {
      await _audioRecorder!.startRecorder(toFile: 'audio.wav');
      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      print('Error starting recording: $e');
    }
  }
  Future<void> _stopRecording() async {
    if (!_isRecording) return;

    try {
      String? path = await _audioRecorder!.stopRecorder();
      setState(() {
        _isRecording = false;
        _audioFilePath = path;
      });
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }
  Future<void> _playAudio() async {
    if (_isPlaying || _audioFilePath == null) return;

    try {
      await _audioPlayer!.startPlayer(fromURI: _audioFilePath);
      setState(() {
        _isPlaying = true;
      });
    } catch (e) {
      print('Error starting playback: $e');
    }
  }
  Future<void> _stopAudio() async {
    if (!_isPlaying) return;

    try {
      await _audioPlayer!.stopPlayer();
      setState(() {
        _isPlaying = false;
      });
    } catch (e) {
      print('Error stopping playback: $e');
    }
  }

  void _startTimer() {
    const duration = const Duration(seconds: 1);
    _timer = Timer.periodic(duration, (Timer timer) {
      setState(() {
        _recordDuration += 1;
      });
    });
  }
  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
  String _getFormattedDuration(int duration) {
    final minutes = (duration / 60).floor().toString().padLeft(2, '0');
    final seconds = (duration % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }


  //Métodos para Enviar una Foto:
  Future<void> _pickImageFromCamera() async {
    final ImagePicker _picker = ImagePicker();

    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        _showSendButton = true;

      });
    }
  }
  void _removeImage() {
    setState(() {
      _image = null;
      _showSendButton = false;
    });
  }


  //Método para conseguir a los amigos de nuestro usuario
  void getUserFriends() async {
    final ref = db
        .collection(DataHolder().sCOLLETCTIONS_USERS)
        .where("uid", whereIn: DataHolder().usuario.friends)
        .withConverter(
          fromFirestore: Usuario.fromFirestore,
          toFirestore: (Usuario u, _) => u.toFirestore(),
        );
    final docSnap = await ref.get();

    setState(() {
      for (int i = 0; i < docSnap.docs.length; i++) {
        Friends.add(docSnap.docs[i].data());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: TabBar(
            padding: EdgeInsets.all(3),
            indicatorColor: Colors.lightBlueAccent.shade100,
            //Dividimos la pantalla en 3 partes, Usuarios totales donde podremos ver y solicitar amistad,
            //la pantalla Peticiones donde vamos a poder ver nuestras peticiones y aceptarlas o rechazarlas
            //La pantalla amigos para ver nuestros amigos
            tabs: [
              Tab(
                  icon: Icon(Icons.camera_alt_rounded),
                  iconMargin: EdgeInsets.symmetric(horizontal: 1, vertical: 1)),
              Tab(
                  icon: Icon(Icons.message_rounded),
                  iconMargin: EdgeInsets.symmetric(horizontal: 1, vertical: 1)),
              Tab(
                  icon: Icon(Icons.keyboard_voice_rounded),
                  iconMargin: EdgeInsets.symmetric(horizontal: 1, vertical: 1)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCameraPage(),
            _buildInputPage(),
            _buildAudioPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputPage() {
    return Center(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.0),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: 'Escribe Un Mensaje',
          ),
        ),
      ),
    );
  }

  Widget _buildCameraPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: 350.0,
                height: 350.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.lightBlueAccent,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: _image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.file(
                    _image!,
                    fit: BoxFit.cover,
                  ),
                )
                    : Container(
                  color: Colors.grey,
                ),
              ),
              if (_image != null)
                IconButton(
                  onPressed: _removeImage,
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.0),
          IconButton(
            onPressed: _pickImageFromCamera,
            icon: Icon(
              _image != null ? Icons.send : Icons.camera,
              size: 32.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _isRecording ? _stopRecording : _startRecording,
            icon: Icon(
              _isRecording ? Icons.stop : Icons.mic,
              size: 32.0,
            ),
          ),
          SizedBox(height: 16.0),
          LinearProgressIndicator(
            value: _recordDuration / 60,
            minHeight: 10.0,
          ),
          SizedBox(height: 16.0),
          IconButton(
            onPressed: _isPlaying ? _stopAudio : _playAudio,
            icon: Icon(
              _isPlaying ? Icons.stop : Icons.play_arrow,
              size: 32.0,
            ),
          ),
          SizedBox(height: 16.0),
          if (_audioFilePath != null)
            Text( '${_getFormattedDuration(_recordDuration)}'),
        ],
      ),
    );
  }
}
