import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_fuctions/auth/loggin.dart';
import 'package:firebase_fuctions/firebase/adduser.dart';
import 'package:firebase_fuctions/screens/messagescreen.dart';
import 'package:firebase_fuctions/screens/useradd.dart';
import 'package:firebase_fuctions/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({
    super.key,
  });

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  Stream? user;
  var searchname = "";

  final _auth = FirebaseAuth.instance;

  final firestor = FirebaseFirestore.instance;

  bool updateload = false;

  @override
  void initState() {
    super.initState();

    getHello();
  }

  getHello() async {
    user = await firebase().getuser();

    setState(() {});
  }

  Future<void> _showMyDialog(String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          iconPadding: EdgeInsets.all(0),
          icon: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Delete your todo'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('conform delete'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                firebase().delete(id);

                log('================delete id${id} ==============================================');
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  final _nameController = TextEditingController();
  final _detailsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Widget userFetch() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('todo')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .orderBy('Name')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          log('Error: ${snapshot.error}');
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No data available'));
        }
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .050,
                      vertical: MediaQuery.of(context).size.height * .030,
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onLongPress: () {
                            _showMyDialog(ds.id);
                          },
                          child: Material(
                            color: Color(0xFFD68C7C),
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 30,
                              ),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Name: " + ds["Name"]),
                                      GestureDetector(
                                          onTap: () {
                                            _nameController.text = ds["Name"];
                                            _detailsController.text =
                                                ds["detail"];

                                            edtinguser(ds.id);

                                            log('gpt new id add cheyyan ${ds.id}');

                                            // log('id id ${ds['id']}');
                                          },
                                          child: Icon(Icons.edit))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('details: ' + ds["detail"]),
                                      Text(ds['time'].toString())
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [Text(ds['date'].toString())],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('id :${ds.id}'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }

  Future edtinguser(String id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Container(
              child: SingleChildScrollView(
                child: Column(children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.close),
                      ),
                    ],
                  ),
                  Column(
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
                          try {
                            setState(() {
                              updateload = true;
                            });
                            Map<String, dynamic> updatete = {
                              "Name": _nameController.text,
                              "detail": _detailsController.text,
                            };
                            print(
                                '--------------Updating todo with ID:--$id-----------------------');

                            await firebase()
                                .updatetodo(id, updatete)
                                .then((value) => Navigator.pop(context));
                            setState(() {
                              updateload = false;
                            });
                          } catch (e) {
                            setState(() {
                              updateload = false;
                            });
                            log('error update $e');
                          }
                        },
                        child: Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: updateload
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Center(child: Text('Update')),
                        ),
                      )
                    ],
                  ),
                ]),
              ),
            ),
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          radius: ResponsiveHelper.getWidth(context) * .070,
        ),
        automaticallyImplyLeading: false,
        title: Text(
          FirebaseAuth.instance.currentUser != null
              ? FirebaseAuth.instance.currentUser!.email ?? 'loading'
              : 'No user logged in',
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessageScreen(),
                    ));
              },
              child: IconButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signOut().then((value) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LogginScreen(),
                            ),
                            (route) => false);
                        Fluttertoast.showToast(
                            msg: "logout succes",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      });
                      log('logout succes');
                    } catch (e) {
                      log('Error${e.toString()}');
                    }
                  },
                  icon: Icon(Icons.logout))),
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Search name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            // onChanged: (value) {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => MessageScreen(),
            //       ));
            // },
          ),
          Expanded(
            child: userFetch(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserAdd(),
                      ));
                },
                child: Icon(Icons.add),
              ),
            ],
          )
        ],
      ),
    );
  }
}






 // .collection('todo')
      // .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      // .where('Name', isGreaterThanOrEqualTo: searchname)
      // .where('Name', isGreaterThanOrEqualTo: searchname + '\uf8ff')
      // .orderBy('Name')
      // .snapshots(),