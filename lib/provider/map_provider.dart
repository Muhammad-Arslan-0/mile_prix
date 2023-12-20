import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'package:mile_prix/helper/app_images.dart';
import 'package:mile_prix/model/order_model.dart';
import 'package:mile_prix/provider/home_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widget/order_tile.dart';

enum MapMarker { all, pickUp, dropOff }

class MapProvider extends ChangeNotifier {
  MapProvider() {
    checkPermission();
    _initializeBitmap();
  }
  BuildContext? _context;
  BuildContext? get myContext => _context;

  _setContext(context) {
    _context = context;
  }

  final Completer<GoogleMapController> mapController = Completer();
  final LatLng point = LatLng(31.501052, 74.322515);

  Set<Marker> _picksMarker = {};
  Set<Marker> _dropMarker = {};
  Set<Marker> _busMarker = {};

  Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;

  void onMapCreated(GoogleMapController controller, context) {
    _setContext(context);
    mapController.complete(controller);
  }

  Future<bool> checkPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      return false;
    }
    return false;
  }

  // convert asset icon to bytes
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  _showSheet(OrderModel orderModel) {
    showModalBottomSheet(
        context: myContext!,
        backgroundColor: Colors.white,
        enableDrag: false,
        builder: (context) {
          return BottomSheet(
            enableDrag: false,
            backgroundColor: Colors.white,
            builder: (BuildContext context) {
              return OrderTile(order: orderModel, isFromMap: true);
            },
            onClosing: () {},
          );
        });
  }

  // Initialize All Icons
  _initializeBitmap() async {
    BitmapDescriptor? pickIcon;
    BitmapDescriptor? dropIcon;
    BitmapDescriptor? busIcon;
    final Uint8List pick = await getBytesFromAsset(AppImages.pick, 120);
    final Uint8List drop = await getBytesFromAsset(AppImages.drop, 120);
    final Uint8List bus = await getBytesFromAsset(AppImages.bus, 120);
    pickIcon = BitmapDescriptor.fromBytes(pick);
    dropIcon = BitmapDescriptor.fromBytes(drop);
    busIcon = BitmapDescriptor.fromBytes(bus);
    _setMarkers(pickIcon, dropIcon, busIcon);
  }

  // this method is return the Marker
  Marker _getMarker(
      String id, LatLng position, OrderModel model, BitmapDescriptor? icon) {
    return Marker(
        markerId: MarkerId(id),
        position: position,
        icon: icon ?? BitmapDescriptor.defaultMarker,
        onTap: () {
          _showSheet(model);
        });
  }

  // Set All Markers
  _setMarkers(BitmapDescriptor? pickIcon, BitmapDescriptor? dropIcon,
      BitmapDescriptor? busIcon) {
    _busMarker = {
      Marker(
          markerId: MarkerId("0"),
          position: LatLng(31.500900, 74.322425),
          icon: busIcon ?? BitmapDescriptor.defaultMarker),
    };
    _picksMarker = {
      // Ali street
      _getMarker("1", LatLng(31.502305, 74.322824),
          HomeProvider().pickupOrder[0], pickIcon),
      // Tipu street
      _getMarker("2", LatLng(31.500713, 74.326300),
          HomeProvider().pickupOrder[1], pickIcon),
      // Marina Benquet Hall
      _getMarker("3", LatLng(31.498609, 74.321745),
          HomeProvider().pickupOrder[2], pickIcon),
    };
    _dropMarker = {
      // Ten 11 Lounge
      _getMarker("4", LatLng(31.499384, 74.320846), HomeProvider().dropOrder[0],
          dropIcon),
      // Paradigm Tours PVT
      _getMarker("5", LatLng(31.498429, 74.323427), HomeProvider().dropOrder[1],
          dropIcon),
      //  Babar Block Garden Town
      _getMarker("6", LatLng(31.497033, 74.323950), HomeProvider().dropOrder[2],
          dropIcon),
    };
    changeMapMarkers(MapMarker.all);
  }

  // Change the Map Markers
  changeMapMarkers(MapMarker mapShowType) {
    Set<Marker> myMarkers = {};
    myMarkers = switch (mapShowType) {
      MapMarker.all => myMarkers
        ..addAll(_busMarker)
        ..addAll(_picksMarker)
        ..addAll(_dropMarker),
      MapMarker.pickUp => myMarkers
        ..addAll(_busMarker)
        ..addAll(_picksMarker),
      MapMarker.dropOff => myMarkers
        ..addAll(_busMarker)
        ..addAll(_dropMarker),
    };
    _markers = myMarkers;
    notifyListeners();
  }
}
