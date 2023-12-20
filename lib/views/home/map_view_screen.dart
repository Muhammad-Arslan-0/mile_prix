import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../provider/map_provider.dart';

class MapViewScreen extends StatelessWidget {
  const MapViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MapProvider>(context, listen: true);
    return GoogleMap(
      mapToolbarEnabled: true,
      myLocationEnabled: true,
      compassEnabled: true,
      myLocationButtonEnabled: true,
      onMapCreated: (controller) => provider.onMapCreated(controller, context),
      markers: provider.markers,
      onTap: (value) {},
      initialCameraPosition: CameraPosition(
        target: provider.point,
        zoom: 16.0,
      ),
    );
  }
}
