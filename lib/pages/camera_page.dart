import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;
  List<CameraDescription> cameras = [];
  List<XFile> photos = [];
  bool cameraBusy = false;

  // Variable para rastrear el índice de la cámara activa actualmente.
  int selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  // Inicializa la cámara al cargar la página.
  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    _cameraController =
        CameraController(cameras[selectedCameraIndex], ResolutionPreset.medium);
    await _cameraController!.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  // Captura una foto con la cámara.
  Future<void> takePhoto() async {
    if (cameraBusy) {
      return;
    }
    cameraBusy = true;

    final XFile? image = await _cameraController!.takePicture();
    if (image != null) {
      setState(() {
        photos.add(image);
      });
    }

    cameraBusy = false;
  }

  // Alterna entre las cámaras disponibles.
  void toggleCamera() {
    selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length;
    _cameraController =
        CameraController(cameras[selectedCameraIndex], ResolutionPreset.medium);
    _cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  // Construye la galería de fotos capturadas.
  List<Widget> buildGallery() {
    return List<Widget>.generate(photos.length, (index) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        child: Image.file(
          File(photos[index].path),
          fit: BoxFit.cover,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos'), // Título de la página
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(15.0),
              width: 350.0,
              height: 100.0,
              child: _cameraController != null
                  ? CameraPreview(_cameraController!)
                  : const Center(
                      child:
                          CircularProgressIndicator(), // Muestra un indicador de carga si la cámara no está lista
                    ),
            ),
          ),
          SizedBox(
            height: 200.0,
            width: 200.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children:
                  buildGallery(), // Muestra las fotos capturadas en una galería horizontal
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: takePhoto, // Captura una foto al presionar el botón
            child: Icon(Icons.camera), // Icono de cámara
          ),
          SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed:
                toggleCamera, // Alterna entre las cámaras al presionar el botón
            child: Icon(Icons.switch_camera), // Icono de cambio de cámara
          ),
        ],
      ),
    );
  }
}
