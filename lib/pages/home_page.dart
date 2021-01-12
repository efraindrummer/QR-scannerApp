import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qreader/pages/direcciones_page.dart';
import 'package:qreader/providers/db_provider.dart';
import 'package:qreader/providers/ui_provider.dart';
import 'package:qreader/widgets/custom_navigatorBar.dart';
import 'package:qreader/widgets/scann_button.dart';
import 'mapas_page.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever), 
            onPressed: null
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);
    
    final currentIndex = uiProvider.selectedMenuOpt;

    //leer la base de datos
    //DBProvider.db.database;
    final tempScan = new ScanModel(valor: 'https://efraincode.netlify.app/');
    DBProvider.db.nuevoScan(tempScan);

    switch(currentIndex){
      case 0:
        return MapasPage();
      
      case 1:
        return DireccionesPage();

      default:
        return MapasPage();
    }
  }
}