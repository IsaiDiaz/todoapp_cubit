import 'package:flutter/material.dart';

class TaskForm extends StatefulWidget {
  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  final _tagsController = TextEditingController();

  String _taskName = '';
  DateTime _dueDate = DateTime.now();
  List<String> _tags = [];

  @override
  void dispose() {
    _tagsController.dispose();
    super.dispose();
  }

  void _addTag() {
    setState(() {
      _tags.add(_tagsController.text);
      _tagsController.clear();
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, do something with the data
      print('Task name: $_taskName');
      print('Due date: $_dueDate');
      print('Tags: $_tags');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Task Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a task name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _taskName = value!;
                },
              ),
              SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Text('Due Date: '),
                  TextButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _dueDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (date != null) {
                        setState(() {
                          _dueDate = date;
                        });
                      }
                    },
                    child: Text(
                      '${_dueDate.day}/${_dueDate.month}/${_dueDate.year}',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _tagsController,
                      decoration: InputDecoration(
                        labelText: 'Tags',
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: _addTag,
                    child: Text('Add Tag'),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField(
                value: null,
                hint: Text('Select a tag'),
                items: _tags.map((tag) {
                  return DropdownMenuItem(
                    value: tag,
                    child: Text(tag),
                  );
                }).toList(),
                onChanged: (value) {},
              ),
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Add Task'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}