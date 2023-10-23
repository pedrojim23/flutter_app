import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login/pages/brujula_page.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorPage extends StatefulWidget {
  @override
  _SensorPageState createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  // Variables para almacenar los valores de los sensores
  double _accelerometerX = 0.0;
  double _accelerometerY = 0.0;
  double _accelerometerZ = 0.0;

  double _gyroscopeX = 0.0;
  double _gyroscopeY = 0.0;
  double _gyroscopeZ = 0.0;

  double _magnetometerX = 0.0;
  double _magnetometerY = 0.0;
  double _magnetometerZ = 0.0;

  // Suscripciones a los eventos de sensores
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  late StreamSubscription<GyroscopeEvent> _gyroscopeSubscription;
  late StreamSubscription<MagnetometerEvent> _magnetometerSubscription;

  @override
  void initState() {
    super.initState();

    // Iniciar la suscripción a eventos del acelerómetro
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      setState(() {
        _accelerometerX = event.x;
        _accelerometerY = event.y;
        _accelerometerZ = event.z;
      });
    });

    // Iniciar la suscripción a eventos del giroscopio
    _gyroscopeSubscription = gyroscopeEvents.listen((event) {
      setState(() {
        _gyroscopeX = event.x;
        _gyroscopeY = event.y;
        _gyroscopeZ = event.z;
      });
    });

    // Iniciar la suscripción a eventos del magnetómetro
    _magnetometerSubscription = magnetometerEvents.listen((event) {
      setState(() {
        _magnetometerX = event.x;
        _magnetometerY = event.y;
        _magnetometerZ = event.z;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    // Cancelar las suscripciones a los sensores cuando el widget se descarta
    _accelerometerSubscription.cancel();
    _gyroscopeSubscription.cancel();
    _magnetometerSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor'),
        actions: [
          IconButton(
            icon: Icon(Icons
                .arrow_forward), // Botón para navegar a la página BrujulaPage
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BrujulaPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Datos del Acelerómetro'),
            Text('X: $_accelerometerX'),
            Text('Y: $_accelerometerY'),
            Text('Z: $_accelerometerZ'),
            SizedBox(height: 20.0),
            Text('Datos del Giroscopio'),
            Text('X: $_gyroscopeX'),
            Text('Y: $_gyroscopeY'),
            Text('Z: $_gyroscopeZ'),
            SizedBox(height: 20.0),
            Text('Datos del Magnetómetro'),
            Text('X: $_magnetometerX'),
            Text('Y: $_magnetometerY'),
            Text('Z: $_magnetometerZ'),
          ],
        ),
      ),
    );
  }
}
