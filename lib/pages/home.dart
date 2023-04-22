import 'package:flutter/material.dart';
import 'add_task.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> _tasks = [];

  void _addTask() {
    setState(() {
      _tasks.insert(0, 'New Task');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  iconColor: MaterialStateProperty.all(Colors.black),  
                  shape: MaterialStateProperty.all(
                    ContinuousRectangleBorder(
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                ),
                onPressed: () =>
                 Navigator.push(context, MaterialPageRoute(builder: (context) => TaskForm())),
                child: const Icon(Icons.add)),
            ),
      
            for (var task in _tasks)
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      right: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      left: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      top: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        task,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Description',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  )
                ),
              ),
          ],
        ),
      ),
    );
  }
}