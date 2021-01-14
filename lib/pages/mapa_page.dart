import 'package:flutter/material.dart';
import 'package:qreader/model/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    final CameraPosition puntoInical = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17.5,
      tilt: 50
    );

    //marcadores
    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
      markerId: MarkerId('geo-location'),
      position: scan.getLatLng()
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        markers: markers,
        initialCameraPosition: puntoInical,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
} 
  