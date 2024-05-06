import 'package:flutter/material.dart';
import 'package:myproject/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _todos = []; // List to store to-do items

  
  // Function to add a new to-do item
  void _addTodo(String newTodo) {
    setState(() {
      _todos.add(newTodo);
    });
    _saveTodos();
  }
  Future<void> _saveTodos() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('todos', _todos);
}
  @override
void initState() {
  super.initState();
  _checkLogin();
}

Future<void> _checkLogin() async {
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.containsKey('user name');
  if (!isLoggedIn){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter To-Do List'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_todos[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  _todos.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final TextEditingController _textFieldController =
                  TextEditingController();
              return AlertDialog(
                title: const Text('Add New To-Do'),
                content: TextField(
                  controller: _textFieldController,
                  decoration: const InputDecoration(labelText: 'New To-Do'),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      _addTodo(_textFieldController.text);
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
