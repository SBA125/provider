import 'package:flutter/material.dart';
import '../model/company.dart';
import '../service/company_service.dart';

class CompanyProvider extends ChangeNotifier {
  final _service = CompanyService();
  bool isLoading = true;
  late Company _company;

  Company get company => _company;

  Future<void> getCompany(int userId) async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getCompany(userId);
    _company = response;
    isLoading = false;
    notifyListeners();
  }
}
