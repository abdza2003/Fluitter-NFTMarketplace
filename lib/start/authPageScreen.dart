import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sampleproject/Database/dataInf.dart';
import 'package:sampleproject/Firebase/Auth.dart';
import 'package:sampleproject/getScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class authPageScreen extends StatefulWidget {
  AuthMode? authMode = AuthMode.Login;
  authPageScreen({this.authMode});
  @override
  State<authPageScreen> createState() => _authPageScreenState();
}

enum AuthMode {
  SignUp,
  Login,
}

class _authPageScreenState extends State<authPageScreen> {
  ////
  ////
  /////
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
  ////
  ////
  ///
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'userName': '',
  };
  bool showPass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              margin: EdgeInsets.all(20),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: AnimatedContainer(
                margin: EdgeInsets.all(15),
                duration: Duration(milliseconds: 500),
                width: double.infinity,
                height: widget.authMode == AuthMode.Login ? 400 : 650,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: widget.authMode == AuthMode.Login ? 30 : 40,
                        ),
                        if (widget.authMode == AuthMode.SignUp)
                          GestureDetector(
                            onTap: fetchImage,
                            child: pickedImage == null
                                ? CircleAvatar(
                                    radius: 90,
                                    backgroundColor: Colors.blue[200],
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.grey[200],
                                          radius: 80,
                                          child: Icon(
                                            FontAwesomeIcons.user,
                                            size: 60,
                                          ),
                                        ),
                                        Transform.translate(
                                          offset: Offset(-10, 110),
                                          child: Icon(
                                            Icons.camera,
                                            color: Colors.blue,
                                            size: 50,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 100,
                                    backgroundColor: Colors.cyan[200],
                                    child: FutureBuilder(
                                      future: Future.delayed(
                                        Duration(seconds: 2),
                                      ),
                                      builder: (context, snapshot) {
                                        return snapshot.connectionState !=
                                                ConnectionState.waiting
                                            ? ClipOval(
                                                child: Image.file(
                                                  pickedImage!,
                                                  fit: BoxFit.cover,
                                                  width: 180,
                                                  height: 180,
                                                ),
                                              )
                                            : CircularProgressIndicator();
                                      },
                                    ),
                                  ),
                          ),
                        SizedBox(
                          height: 30,
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 600),
                          constraints: BoxConstraints(
                            minHeight:
                                widget.authMode == AuthMode.SignUp ? 20 : 0,
                            maxHeight:
                                widget.authMode == AuthMode.SignUp ? 120 : 0,
                          ),
                          child: widget.authMode == AuthMode.SignUp
                              ? TextFormField(
                                  enabled: widget.authMode == AuthMode.SignUp,
                                  decoration: InputDecoration(
                                    hintText: 'User Name',
                                    prefixIcon: Icon(FontAwesomeIcons.user),
                                    label: Text('User Name'),
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.all(15),
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Invalid password!';
                                    }
                                  },
                                  onSaved: (val) {
                                    _authData['userName'] = val.toString();
                                  },
                                )
                              : null,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'E-mail',
                            prefixIcon: Icon(FontAwesomeIcons.at),
                            label: Text('E-mail'),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(15),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) {
                            if (val!.isEmpty || !val.contains('@')) {
                              return 'Invalid email !';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            _authData['email'] = val.toString();
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.key),
                            label: Text('Password'),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(15),
                            suffixIcon: IconButton(
                              icon: showPass
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  showPass == false
                                      ? showPass = true
                                      : showPass = false;
                                });
                              },
                            ),
                          ),
                          obscureText: showPass,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (val) {
                            if (val!.isEmpty || val.contains(' ')) {
                              return 'Invalid password!';
                            } else if (val.length < 5) {
                              return 'short password';
                            }
                          },
                          onSaved: (val) {
                            _authData['password'] = val.toString();
                          },
                        ),
                        isLoading == false
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: ElevatedButton(
                                      onPressed: _submit,
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        // padding: EdgeInsets.all(20),
                                        child: Text(
                                          widget.authMode == AuthMode.Login
                                              ? 'LOGIN'
                                              : 'SING UP',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      textStyle: MaterialStateProperty.all(
                                        TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    onPressed: (() {
                                      setState(() {
                                        widget.authMode == AuthMode.Login
                                            ? widget.authMode = AuthMode.SignUp
                                            : widget.authMode = AuthMode.Login;
                                      });
                                    }),
                                    child: Text(
                                      widget.authMode == AuthMode.Login
                                          ? 'SING UP'
                                          : 'LOGIN',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Transform.translate(
                                offset: Offset(0, 20),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 4,
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      return;
    } else {
      FocusScope.of(context).unfocus();
      _formKey.currentState!.save();
    }

    SharedPreferences s1 = await SharedPreferences.getInstance();

    setState(() {
      isLoading = true;
    });
    try {
      if (widget.authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'] as String,
          _authData['password'] as String,
        );

        var x = Provider.of<Auth>(context, listen: false).addNewUser;
        print('================== ${x[0].Id}');
        /////
        ////////////////////////
        s1.setString('key', '${x[0].Id}');
        s1.setBool('fetch', true);

        /////////////////////
        ///
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => getScreen(
                  idKey: x[0].Id,
                )),
          ),
        );
      } else {
        await Provider.of<Auth>(context, listen: false).signUp(
          _authData['email'] as String,
          _authData['password'] as String,
        );
        var x = Provider.of<Auth>(context, listen: false).addNewUser;
        print('================== ${x[0].Id}');
        ////////////////
        ////////////////////////////////////
        ///////////
        s1.setString('key', '${x[0].Id}');
        s1.setBool('fetch', true);

        ///////////////////////
        //////////
        ///
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child('${x[0].Id}.jpg');

        ///
        ////
        var urlImage;
        if (pickedImage != null) {
          await ref.putFile(pickedImage!);
          urlImage = await ref.getDownloadURL();
          await ref.putFile(pickedImage!);
        } else {
          urlImage =
              'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png';
        }

        ///
        ///

        await FirebaseFirestore.instance
            .collection('newAccount')
            .doc('${x[0].Id}')
            .collection('user')
            .doc('personalInf')
            .set({
          'userName': _authData['userName'],
          'email': _authData['email']!,
          'password': _authData['password']!,
          'image_url': urlImage,
          'bio': '',
          'background':
              'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
        });
        ////
        ////
        for (int i = 0; i < dataInf.length; i++) {
          await FirebaseFirestore.instance
              .collection('newAccount')
              .doc('${x[0].Id}')
              .collection('favorite')
              .doc('${i}')
              .set({'id': ''});
        }
        ///////
        /////
        ///
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => getScreen(
                  idKey: x[0].Id,
                )),
          ),
        );
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      var errorMessage = 'Authenticatio Faild';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      showErrorDialog(errorMessage);
    }
  }

  bool isLoading = false;
  showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                // isLoading = true;
              });
              Navigator.pop(context);
            },
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }
}
