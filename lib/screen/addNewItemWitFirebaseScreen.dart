import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sampleproject/screen/myAccountScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class addNewItemWitFirebaseScreen extends StatefulWidget {
  String Id;
  addNewItemWitFirebaseScreen({required this.Id});
  @override
  State<addNewItemWitFirebaseScreen> createState() =>
      _addNewItemWitFirebaseScreenState();
}

class _addNewItemWitFirebaseScreenState
    extends State<addNewItemWitFirebaseScreen> {
  Map<String, dynamic> imageData = {
    'current_price': '',
    'image_code': '',
    'description': '',
    'label': ''
  };

  ///
  ////
  ////
  final ImagePicker _picker = ImagePicker();

  File? pickedImage;

  fetchImage() async {
    final image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
    if (image == null) {
      return;
    }

    setState(() {
      pickedImage = File(image.path);
    });
  }

  ///
  ///
  ///
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Future<void> _submit() async {
      if (!_formKey.currentState!.validate()) {
        FocusScope.of(context).unfocus();
        return;
      } else {
        FocusScope.of(context).unfocus();
        _formKey.currentState!.save();
      }
      setState(() {
        isLoading = true;
      });
      Random x = new Random();

      final ref = FirebaseStorage.instance
          .ref()
          .child('items')
          .child('${widget.Id}${x.nextInt(100)}.jpg');

      ///
      ////
      var urlImage;
      if (pickedImage != null) {
        setState(() {
          isLoading = true;
        });
        await ref.putFile(pickedImage!);
        urlImage = await ref.getDownloadURL();
        await ref.putFile(pickedImage!);
      } else {
        urlImage =
            'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png';
      }

      ///
      ///
// FirebaseFirestore
//                                                     .instance
//                                                     .collection('newAccount')
//                                                     .doc(
//                                                         'zV2DIy3WBeNjEttRVEuLPeGnvFB3')
//                                                     .collection('items')
      await FirebaseFirestore.instance
          .collection('newAccount')
          .doc('${widget.Id}')
          .collection('items')
          .add({
        'current_price': imageData['current_price'],
        'image_code': imageData['image_code']!,
        'description': imageData['description']!,
        'image_url_items': urlImage,
        'label': imageData['label'],
        'favorite': false
      });

      ////
      ////
      ///
      ///
      SharedPreferences a1 = await SharedPreferences.getInstance();
      var idKey = a1.getString('key');
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: ((context) => myAccountScreen(
                idKey: idKey,
              )),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedOpacity(
              opacity: isLoading ? .4 : 1,
              duration: Duration(milliseconds: 200),
              child: Container(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      pickedImage == null
                          ? GestureDetector(
                              onTap: fetchImage,
                              child: Container(
                                height: 250,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blueGrey,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                    Text(
                                      'Add Image',
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    )
                                  ],
                                ),
                              ),
                            )
                          : FutureBuilder(
                              future: Future.delayed(
                                Duration(seconds: 2),
                              ),
                              builder: (context, snapshot) {
                                return snapshot.connectionState !=
                                        ConnectionState.waiting
                                    ? Container(
                                        height: 300,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.blueGrey,
                                        ),
                                        child: Image.file(
                                          pickedImage!,
                                          fit: BoxFit.cover,
                                          height: 300,
                                        ),
                                      )
                                    : Container(
                                        height: 300,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.blueGrey,
                                        ),
                                        child: CircularProgressIndicator(),
                                      );
                              },
                            ),
                      SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    maxLength: 5,
                                    decoration: InputDecoration(
                                      fillColor: Colors.blueGrey,
                                      filled: true,
                                      hintText: 'Current Price',
                                      prefixIcon:
                                          Icon(FontAwesomeIcons.ethereum),
                                      label: Text('Current Price'),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.white,
                                      )),
                                      contentPadding: EdgeInsets.all(15),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onSaved: (val) {
                                      imageData['current_price'] =
                                          val.toString();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    maxLength: 3,
                                    decoration: InputDecoration(
                                      fillColor: Colors.blueGrey,
                                      filled: true,
                                      hintText: 'Image Code',
                                      prefixIcon: Icon(FontAwesomeIcons.at),
                                      label: Text('Image Code'),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.white,
                                      )),
                                      contentPadding: EdgeInsets.all(15),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (val) {
                                      if (val.toString().length != 3) {
                                        return '3 numbers assigned';
                                      }
                                    },
                                    onSaved: (val) {
                                      imageData['image_code'] = val.toString();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              maxLength: 19,
                              decoration: InputDecoration(
                                fillColor: Colors.blueGrey,
                                filled: true,
                                hintText: 'Label',
                                prefixIcon: Icon(Icons.description),
                                label: Text('Label'),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                                contentPadding: EdgeInsets.all(15),
                              ),
                              keyboardType: TextInputType.text,
                              onSaved: (val) {
                                imageData['label'] = val.toString();
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              maxLength: 150,
                              maxLines: 4,
                              decoration: InputDecoration(
                                fillColor: Colors.blueGrey,
                                filled: true,
                                hintText: 'Description',
                                prefixIcon: Icon(Icons.description),
                                label: Text('Description'),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                                contentPadding: EdgeInsets.all(15),
                              ),
                              keyboardType: TextInputType.multiline,
                              onSaved: (val) {
                                imageData['description'] = val.toString();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                alignment: Alignment.center,
                              ),
                              onPressed: _submit,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                                child: Text(
                                  'Continue',
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (isLoading == true)
              Transform.translate(
                offset: Offset(0, 0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedOpacity(
                      duration: Duration.zero,
                      opacity: 1,
                      child: Image.asset(
                        'images/v3.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
