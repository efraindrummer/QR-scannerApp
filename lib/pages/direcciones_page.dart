import 'package:flutter/material.dart';
import 'package:qreader/widgets/scan_tiles.dart';


class DireccionesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipo: 'http');
  }
}