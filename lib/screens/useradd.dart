import 'package:firebase_fuctions/firebase/adduser.dart';
import 'package:firebase_fuctions/screens/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:random_string/random_string.dart';

class UserAdd extends StatefulWidget {
  UserAdd({super.key});

  @override
  State<UserAdd> createState() => _UserAddState();
}

class _UserAddState extends State<UserAdd> {
  final _nameController = TextEditingController();

  final _detailsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool addtodo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adduser'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _detailsController,
                  decoration: InputDecoration(
                    hintText: 'details',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        addtodo = true;
                      });
                      String id = randomString(10);
                      DateTime currentTime = DateTime.now();

                      Map<String, dynamic> empoyementInfoMap = {
                        "Name": _nameController.text,
                        "detail": _detailsController.text,
                        "id": id,
                        "time": "${currentTime.hour}:${currentTime.minute}",
                        "date":
                            "${currentTime.year}-${currentTime.month}-${currentTime.day}"
                      };
                      await firebase().addtodo(
                        empoyementInfoMap,
                      );
                      const snackBar = SnackBar(
                        content: Text('create todo'),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      Navigator.pop(context);
                    } else {
                      setState(() {
                        addtodo = false;
                      });
                      const snackBar = SnackBar(
                        content: Text('error'),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: addtodo
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Text('Save')),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
