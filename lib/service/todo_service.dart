import 'package:dio/dio.dart';
import '../model/todo.dart';
import '../model/address.dart'; // Import the Address model
import '../model/company.dart'; // Import the Company model

class TodoService {
  final dio = Dio();

  Future<List<Todo>> getAllTodos() async {
    Response response;
    response = await dio.get("https://jsonplaceholder.typicode.com/users");

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      List<Todo> todoList = data.map((e) {
        // Create Address object
        Address address = Address.fromJson(e['address']);

        // Create Company object
        Company company = Company.fromJson(e['company']);

        // Create Todo object
        return Todo(
          id: e['id'],
          name: e['name'],
          username: e['username'],
          email: e['email'],
          address: address,
          phone: e['phone'],
          website: e['website'],
          company: company,
        );
      }).toList();
      return todoList;
    } else {
      throw Exception("Failed to get data");
    }
  }
}
