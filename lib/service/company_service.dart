import 'package:dio/dio.dart';
import '../model/company.dart';

class CompanyService {
  final Dio dio = Dio();

  Future<Company> getCompany(int userId) async {
    try {
      Response response =
          await dio.get("https://jsonplaceholder.typicode.com/users/$userId");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final Map<String, dynamic> companyData = data['company'];
        Company company = Company(
          name: companyData['name'],
          catchPhrase: companyData['catchPhrase'],
          bs: companyData['bs'],
        );
        return company;
      } else {
        throw Exception("Failed to get company data");
      }
    } catch (e) {
      throw Exception("Failed to fetch data: $e");
    }
  }
}
