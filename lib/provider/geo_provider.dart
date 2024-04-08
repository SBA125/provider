import 'package:flutter/material.dart';
import '../model/geo.dart';
import '../service/geo_service.dart';

class GeoProvider extends ChangeNotifier {
  final _service = GeoService();
  bool isLoading = true;
  late Geo _geo;

  Geo get geo => _geo;

  Future<void> getGeo(int userId) async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getGeo(userId);
    _geo = response;
    isLoading = false;
    notifyListeners();
  }
}
