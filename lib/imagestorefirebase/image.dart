import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_fuctions/firebase/adduser.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class ImageStore extends StatefulWidget {
  const ImageStore({super.key});

  @override
  State<ImageStore> createState() => _ImageStoreState();
}

File? selectedImage;

class _ImageStoreState extends State<ImageStore> {
  @override
  Widget build(BuildContext context) {
    Future<void> _pickedImageGallery() async {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }

    //delete post

    Future deletepost(String id) async {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: Icon(Icons.edit),
              ),
              TextButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('image')
                      .doc(id)
                      .delete();
                },
                child: Icon(Icons.delete),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            height: 150,
            // color: Colors.red,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: selectedImage != null
                              ? FileImage(selectedImage!)
                              : const AssetImage('asset/filepicker.png')
                                  as ImageProvider<Object>,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 200,
                  top: 50,
                  child: GestureDetector(
                    onTap: () async {
                      _pickedImageGallery().then((value) async {
                        SettableMetadata metedata =
                            SettableMetadata(contentType: 'image/jpeg');
                        final curenttime = TimeOfDay.now();

                        UploadTask uploadTask = FirebaseStorage.instance
                            .ref()
                            .child('Shoapimage/shoap$curenttime ')
                            .putFile(selectedImage!, metedata);

                        TaskSnapshot snapshot = await uploadTask;

                        await snapshot.ref.getDownloadURL().then((url) {
                          String id = randomString(10);
                          FirebaseFirestore.instance
                              .collection('image')
                              .doc(id)
                              .set({'image': url, 'id': id});
                          // log('image id$id');
                        });
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(),
                      ),
                      width: 40,
                      height: 50,
                      child: Icon(Icons.camera_alt_outlined),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('image').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final gridimage = snapshot.data!.docs;
              return gridimage.isEmpty
                  ? Center(
                      child: Text('image here'),
                    )
                  : Expanded(
                      child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: gridimage.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        final imageurl = gridimage[index]['image'] as String;

                        return GestureDetector(
                          onLongPress: () async {
                            await deletepost(gridimage[index].id);
                            log('the image id  =${gridimage[index].id}');
                          },
                          child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(imageurl),
                              ),
                            ),
                          ),
                        );
                      },
                    ));
            },
          )
        ],
      ),
    );
  }
}
