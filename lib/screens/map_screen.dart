import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialPlaceLocation;
  final bool isselecting;

  MapScreen(
      {this.initialPlaceLocation =
          const PlaceLocation(latitude: 37.422, longitude: -122.084),
      this.isselecting = false});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;
  void _selectPosition(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: <Widget>[
          if (widget.isselecting)
            IconButton(
                icon: Icon(Icons.check),
                onPressed: _pickedLocation == null || !widget.isselecting
                    ? null
                    : () {
                        Navigator.of(context).pop(_pickedLocation);
                      })
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialPlaceLocation.latitude,
            widget.initialPlaceLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isselecting ? _selectPosition : null,
        markers: (_pickedLocation == null && widget.isselecting)
            ? null
            : {
                Marker(
                  markerId: MarkerId(
                    'm1',
                  ),
                  position: _pickedLocation ??
                      LatLng(
                        widget.initialPlaceLocation.latitude,
                        widget.initialPlaceLocation.longitude,
                      ),
                )
              },
      ),
    );
  }
}
