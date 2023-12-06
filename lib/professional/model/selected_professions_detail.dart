import 'dart:io';

import 'package:flutter/material.dart';

import 'ProfessionsUnitList_model.dart';

class SelectedProfessionsDetailClass {
  String id;
  String serviceName;
  TextEditingController priceController;
  UnitList? servicePer;
  File? image;
  String? netImg;

  SelectedProfessionsDetailClass(
      {required this.id,
        required this.serviceName,
        required this.priceController,
        required this.servicePer,
        this.image,
        this.netImg
      });
}
