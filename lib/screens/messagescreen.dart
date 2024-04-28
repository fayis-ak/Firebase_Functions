import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_fuctions/firebase/adduser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  Stream? user;

  var searchname = "";

  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    getHello();
  }

  getHello() async {
    user = await firebase().getuser();

    setState(() {});
  }

  Widget userFetch() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('todo')
          .where('Name', isGreaterThanOrEqualTo: searchname)
          .where('Name', isLessThanOrEqualTo: searchname + '\uf8ff')
          .orderBy('Name')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
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
                      horizontal: MediaQuery.of(context).size.width * .010,
                      vertical: MediaQuery.of(context).size.height * .010,
                    ),
                    child: Column(
                      children: [
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 30,
                            ),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("name: " + ds["Name"]),
                                    GestureDetector(
                                        onTap: () {
                                          // _nameController.text = ds["Name"];
                                          // _detailsController.text =
                                          //     ds["detail"];

                                          // edtinguser(ds['id']);
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
                                    GestureDetector(
                                        onTap: () {
                                          firebase().delete(ds['id']);
                                        },
                                        child: Icon(Icons.delete))
                                  ],
                                ),
                              ],
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchname = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: userFetch(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // FloatingActionButton(
                  //   onPressed: () {
                  //     // Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //       builder: (context) => UserAdd(),
                  //     //     ));
                  //   },
                  //   child: Icon(Icons.add),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
