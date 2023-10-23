import 'dart:math' as math; // Importación de la biblioteca math con un alias
import 'package:flutter/material.dart'; // Importación de la biblioteca de Flutter
import 'package:flutter_compass/flutter_compass.dart'; // Importación de la biblioteca para el sensor de brújula
import 'package:login/pages/camera_page.dart'; // Importación de la página CameraPage
import 'package:permission_handler/permission_handler.dart'; // Importación de la biblioteca para gestionar permisos

class BrujulaPage extends StatefulWidget {
  @override
  _BrujulaPageState createState() => _BrujulaPageState();
}

class _BrujulaPageState extends State<BrujulaPage> {
  bool _hasPermissions =
      false; // Variable para almacenar el estado de los permisos
  CompassEvent? _lastRead; // Último evento de brújula leído
  DateTime? _lastReadAt; // Hora de la última lectura de la brújula

  @override
  void initState() {
    super.initState();
    _fetchPermissionStatus(); // Verificar el estado de los permisos al inicializar la página
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Configuración del color de fondo
      appBar: AppBar(
        title: Text('Flutter Compass'), // Título de la aplicación
        actions: [
          IconButton(
            icon: Icon(Icons
                .arrow_forward), // Icono para navegar a otra página (CameraPage)
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CameraPage()), // Navegar a CameraPage
              );
            },
          ),
        ],
      ),
      body: Builder(builder: (context) {
        if (_hasPermissions) {
          return Column(
            children: <Widget>[
              _buildManualReader(), // Widget para realizar una lectura manual de la brújula
              Expanded(
                  child:
                      _buildCompass()), // Widget para mostrar la brújula en tiempo real
            ],
          );
        } else {
          return _buildPermissionSheet(); // Widget para solicitar permisos de ubicación
        }
      }),
    );
  }

  // Widget para realizar una lectura manual de la brújula
  Widget _buildManualReader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          ElevatedButton(
            child: Text('Leer Valor'),
            onPressed: () async {
              final CompassEvent tmp = await FlutterCompass.events!.first;
              setState(() {
                _lastRead = tmp;
                _lastReadAt = DateTime.now();
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Última Lectura: $_lastRead',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    'Hora de la Última Lectura: $_lastReadAt',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget para mostrar la brújula en tiempo real
  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error al leer el rumbo: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data!.heading;

        // Si direction es nulo, el dispositivo no admite este sensor
        // Mostrar mensaje de error
        if (direction == null)
          return Center(
            child: Text("¡El dispositivo no tiene sensores!"),
          );

        return Material(
          shape: CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Transform.rotate(
              angle: (direction * (math.pi / 180) * -1),
              child: Image.asset('assets/brujula.jpg'),
            ),
          ),
        );
      },
    );
  }

  // Widget para solicitar permisos de ubicación
  Widget _buildPermissionSheet() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Se requiere permiso de ubicación'),
          ElevatedButton(
            child: Text('Solicitar Permisos'),
            onPressed: () {
              Permission.locationWhenInUse.request().then((ignored) {
                _fetchPermissionStatus();
              });
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            child: Text('Abrir Configuración de la Aplicación'),
            onPressed: () {
              openAppSettings().then((opened) {
                //
              });
            },
          )
        ],
      ),
    );
  }

  // Función para verificar el estado de los permisos de ubicación
  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() => _hasPermissions = status == PermissionStatus.granted);
      }
    });
  }
}
