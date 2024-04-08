import 'package:flutter/material.dart';
import 'package:flutter_app/provider/todo_provider.dart';
import 'package:provider/provider.dart';

import 'model/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoProvider>(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TodoProvider>(context, listen: false).getAllTodos();
    });
  }

  void _showTodoDetails(BuildContext context, Todo todo) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID: ${todo.id}'),
              Text('Name: ${todo.name}'),
              Text('Username: ${todo.username}'),
              Text('Email: ${todo.email}'),
              Text(
                  'Address: ${todo.address.street}, ${todo.address.suite}, ${todo.address.city}, ${todo.address.zipcode}'),
              Text('Phone: ${todo.phone}'),
              Text('Website: ${todo.website}'),
              Text('Company: ${todo.company.name}'),
              Text('Catchphrase: ${todo.company.catchPhrase}'),
              Text('BS: ${todo.company.bs}'),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TodoProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const CircularProgressIndicator();
            } else {
              final todos = value.todos;
              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (BuildContext context, int index) {
                  final todo = todos[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(todos[index].id.toString()),
                      ),
                      title: Text(todos[index].name),
                      onTap: () {
                        _showTodoDetails(context, todo);
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
