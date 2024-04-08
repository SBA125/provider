import 'package:dio/dio.dart';
import '../model/address.dart';
import '../model/geo.dart';

class AddressService {
  final dio = Dio();
  Future<Address> getAddress(int userId) async {
    Response response;
    response =
        await dio.get("https://jsonplaceholder.typicode.com/users/$userId");
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      final Map<String, dynamic> addressData = data['address'];
      Address address = Address(
        street: addressData['street'],
        suite: addressData['suite'],
        city: addressData['city'],
        zipcode: addressData['zipcode'],
        geo: Geo.fromJson(addressData['geo']),
      );
      return address;
    } else {
      throw Exception("Failed to get address data");
    }
  }
}
