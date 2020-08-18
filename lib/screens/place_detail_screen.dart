import 'package:flutter/material.dart';
import '../screens/map_screen.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routeName = '/place-detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final selectedPlaces =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlaces.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlaces.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlaces.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_)=> MapScreen(
                    initialPlaceLocation: selectedPlaces.location,
                  ),
                ),
              );
            },
            textColor: Theme.of(context).primaryColor,
            child: Text(
              'View on Map',
            ),
          )
        ],
      ),
    );
  }
}
