import 'package:flutter/material.dart';

class MapasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: ( _, i) => ListTile(
        leading: Icon(Icons.map, color: Theme.of(context).primaryColor),
        title: Text('http://facebook.com'),
        subtitle: Text('ID: 1s'),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blueGrey),
        onTap: () => print('abrio el qr...'),
      ),
    );
  }
}