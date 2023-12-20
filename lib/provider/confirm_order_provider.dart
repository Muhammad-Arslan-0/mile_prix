import 'dart:io';

import 'package:flutter/material.dart';

class ConfirmOrderProvider extends ChangeNotifier {
  List<File> pickUpOrdersImages = [];
  List<File> dropOffOrdersImages = [];

  bool _isVerifiedName = true;
  bool get isVerifiedName => _isVerifiedName;

  bool _isVerifiedDelivery = true;
  bool get isVerifiedDelivery => _isVerifiedDelivery;

  bool _isPackageIntact = true;
  bool get isPackageIntact => _isPackageIntact;

  bool _isFitDesc = true;
  bool get isFitDesc => _isFitDesc;

  changeVerifyName(bool value) {
    _isVerifiedName = value;
    notifyListeners();
  }

  changeVerifyDelivery(bool value) {
    _isVerifiedDelivery = value;
    notifyListeners();
  }

  changePackageIntact(bool value) {
    _isPackageIntact = value;
    notifyListeners();
  }

  changeFitDesc(bool value) {
    _isFitDesc = value;
    notifyListeners();
  }

  removeImageFromList(bool isPick, File image) {
    if (isPick) {
      pickUpOrdersImages.remove(image);
      notifyListeners();
    } else {
      dropOffOrdersImages.remove(image);
      notifyListeners();
    }
  }

  clearAllImages(bool isPick) {
    if (isPick) {
      pickUpOrdersImages.clear();
      notifyListeners();
    } else {
      dropOffOrdersImages.clear();
      notifyListeners();
    }
  }
}
