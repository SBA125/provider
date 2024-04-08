import 'package:flutter/material.dart';
import '../model/address.dart';
import '../service/address_service.dart';

class AddressProvider extends ChangeNotifier {
  final _service = AddressService();
  bool isLoading = true;
  late Address _address;

  Address get address => _address;

  Future<void> getAddress(int userId) async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getAddress(userId);
    _address = response;
    isLoading = false;
    notifyListeners();
  }
}
