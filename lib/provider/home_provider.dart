import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mile_prix/model/order_model.dart';
import 'package:provider/provider.dart';
import 'map_provider.dart';

class HomeProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  HomeProvider() {
    setListViewItems(MapMarker.all);
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  List<OrderModel> _listViewItems = [];
  List<OrderModel> get listViewItems => _listViewItems;

  List<OrderModel> _showListViewItems = [];
  List<OrderModel> get showListViewItems => _showListViewItems;

  List<OrderModel> pickupOrder = [
    OrderModel(
        id: "464113",
        location: "8 Goldie Street Cross River",
        name: "John Doe",
        size: [12, 12, 18],
        weight: 30,
        orderType: OrderType.Pickup),
    OrderModel(
        id: "414411",
        location: "Ten 11 Lounge",
        name: "John Mor",
        size: [25, 9, 11],
        weight: 28,
        orderType: OrderType.Pickup),
    OrderModel(
        id: "454019",
        location: "Canal View",
        name: "John cena",
        size: [22, 8, 20],
        weight: 25,
        orderType: OrderType.Pickup),
  ];
  List<OrderModel> dropOrder = [
    OrderModel(
        id: "361663",
        location: "Marina Banquet Hall",
        name: "John p",
        size: [15, 8, 9],
        weight: 32,
        orderType: OrderType.DropOff),
    OrderModel(
        id: "310451",
        location: "Babar Block Garden Town",
        name: "John q",
        size: [2, 10, 16],
        weight: 35,
        orderType: OrderType.DropOff),
    OrderModel(
        id: "316781",
        location: "Paradigm Tours PVT",
        name: "John r",
        size: [19, 5, 11],
        weight: 40,
        orderType: OrderType.DropOff),
  ];

  onChangedSearch(String text) {
    List<OrderModel> searchedList = [];
    if (text.isEmpty) {
      final mapType = getMapType(currentIndex);
      setListViewItems(mapType);
    } else {
      for (var element in _listViewItems) {
        if (element.id.toLowerCase().contains(text.toLowerCase()) ||
            element.name.toLowerCase().contains(text.toLowerCase()) ||
            element.location.toLowerCase().contains(text.toLowerCase())) {
          searchedList.add(element);
        }
      }
      _showListViewItems = searchedList;
      notifyListeners();
    }
  }

  changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  tapOnTabBar(int index, context) {
    searchController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    final mapType = getMapType(index);
    Provider.of<MapProvider>(context, listen: false).changeMapMarkers(mapType);
    setListViewItems(mapType);
  }

  MapMarker getMapType(int index) {
    return switch (index) {
      0 => MapMarker.all,
      1 => MapMarker.pickUp,
      2 => MapMarker.dropOff,
      _ => MapMarker.all
    };
  }

  setListViewItems(MapMarker type) {
    List<OrderModel> myListViewItems = [];
    myListViewItems = switch (type) {
      MapMarker.all => myListViewItems
        ..addAll(pickupOrder)
        ..addAll(dropOrder),
      MapMarker.pickUp => myListViewItems..addAll(pickupOrder),
      MapMarker.dropOff => myListViewItems..addAll(dropOrder),
    };
    _listViewItems = myListViewItems;
    _showListViewItems = myListViewItems;
    _showListViewItems.shuffle();
    notifyListeners();
  }

  DateTime? currentBackPressTime;

  onPop(context) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Press back again to exit")));
    } else {
      exit(0);
    }
  }
}
