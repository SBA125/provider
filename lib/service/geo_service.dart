import 'package:dio/dio.dart';
import '../model/geo.dart';

class GeoService {
  final dio = Dio();
  Future<Geo> getGeo(int userId) async {
    Response response;
    response =
        await dio.get("https://jsonplaceholder.typicode.com/users/$userId");
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      final Map<String, dynamic> geoData = data['address']['geo'];
      Geo geo = Geo(
        lat: geoData['lat'],
        lng: geoData['lng'],
      );
      return geo;
    } else {
      throw Exception("Failed to get geo data");
    }
  }
}
