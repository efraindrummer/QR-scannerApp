import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qreader/pages/direcciones_page.dart';
import 'package:qreader/providers/ui_provider.dart';
import 'package:qreader/widgets/custom_navigatorBar.dart';
import 'package:qreader/widgets/scann_button.dart';
import 'package:qreader/providers/scan_list_provider.dart';
import 'mapas_page.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final scanListProvider = Provider.of<ScanListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever), 
            onPressed: (){
              scanListProvider.borrarTodos();
            }
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

    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch(currentIndex){
      case 0:
        scanListProvider.cargarScanPorTipo('geo');
        return MapasPage();
      
      case 1:
        scanListProvider.cargarScanPorTipo('http');
        return DireccionesPage();

      default:
        return MapasPage();
    }
  }
}