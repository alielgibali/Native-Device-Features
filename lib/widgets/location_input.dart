import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function addPlace;
  LocationInput(this.addPlace);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImgageUrl;
  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);
    setState(() {
      _previewImgageUrl = staticMapImageUrl;
    });
    setState(() {});
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locData = await Location().getLocation();

      _showPreview(locData.latitude, locData.longitude);

      widget.addPlace(
        locData.latitude,
        locData.longitude,
      );
    } catch (_) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (_) => MapScreen(
          isselecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.addPlace(
      selectedLocation.latitude,
      selectedLocation.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImgageUrl == null
              ? Text('No Location Choosen!', textAlign: TextAlign.center)
              : Image.network(
                  _previewImgageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              onPressed: _getCurrentLocation,
              icon: Icon(Icons.location_on),
              textColor: Theme.of(context).primaryColor,
              label: Text(
                'Current Location',
              ),
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              textColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.map),
              label: Text(
                'Select On MAp',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
