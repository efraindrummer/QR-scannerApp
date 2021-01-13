import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qreader/providers/scan_list_provider.dart';

class ScanButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: ()async{
        //String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3D8BEF', 'Cancelar', false, ScanMode.QR);
        final barcodeScanRes = 'https://efraincode.netlify.app/';
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

        scanListProvider.nuevoScan(barcodeScanRes);
        scanListProvider.nuevoScan('geo: 15.33,15.66');
      },
    );
  }
}