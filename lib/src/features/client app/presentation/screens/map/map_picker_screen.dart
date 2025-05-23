// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20app/appBarApp.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20public%20app/widgets%20style/customButtonApp.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20public%20app/widgets%20style/customStyledText.dart';

// ignore: use_key_in_widget_constructors
class MapPickerScreen extends StatefulWidget {
  @override
  _MapPickerScreenState createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  // I want to get current positopn how can I get that

  late GoogleMapController _mapController;
  LatLng _selectedLocation =
      const LatLng(37.7749, -122.4194); // Default location

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onTap(LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
  }

  @override
  initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, request the user to enable it.
      return;
    }

    // Check permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, return.
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, we cannot request permissions.
      return;
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _selectedLocation = LatLng(position.latitude, position.longitude);
    });

    _mapController.animateCamera(
      CameraUpdate.newLatLng(_selectedLocation),
    );
  }

  void _confirmLocation() {
    Navigator.pop(context, _selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarApplicationArrow(
        text: "حدد موقعك",
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _selectedLocation,
              zoom: 14.0,
            ),
            onTap: _onTap,
            markers: {
              Marker(
                markerId: const MarkerId('selected-location'),
                position: _selectedLocation,
              ),
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child:
                CustomButton(text: "تأكيد الموقع", onPressed: _confirmLocation),
          ),
        ],
      ),
    );
  }
}
