import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class IdItem {
  var Id;
  IdItem({required this.Id});
}

class Auth with ChangeNotifier {
  List<IdItem> addNewUser = [];
  String userId = '';
  String idToken = '';
  Future<void> _authenticate(
      {required String email,
      required String password,
      required String urlSegment}) async {
    final String urlApi =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=${FirebaseapiKey}';

    try {
      http.Response res = await http.post(
        Uri.parse(urlApi),
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final resData = json.decode(res.body);
      if (resData['error'] != null) {
        throw '${resData['error']['message']}';
      }
      userId = resData['localId'];
      idToken = resData['idToken'];
      addNewUser.add(IdItem(
        Id: userId,
      ));
      print('user Id ====' + userId);
      print('idToken Id ====' + idToken);
    } catch (_) {
      throw _;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(
        email: email, password: password, urlSegment: 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(
        email: email, password: password, urlSegment: 'signInWithPassword');
  }
}









 


  // Authendication _auth = Authendication();

/*    _auth.loginWithEmailAndPassword(email.text, pass.text).then((value) {
            print(value);
            pref.setString("uid", value.user!.uid);

            Navigator.pushNamed(context, '/mainpage',
                arguments: value.user!.uid);
          }).catchError((err) {
            print(err);
          }); */




          
// Future<void> userSetup(String displayname, String passowrd, String uid) async {
//   var users = FirebaseFirestore.instance
//       .collection('Accounts')
//       .doc('${uid}')
//       .collection('User')
//       .doc('Inf');
//   FirebaseAuth auth = FirebaseAuth.instance;
//   // String uid = auth.currentUser!.uid.toString();
//   // SharedPreferences prefs = await SharedPreferences.getInstance();
//   // prefs.setString('idKey', uid);
//   users.set({'Email': displayname, 'Password': passowrd, 'image_url': ''});
//   return;
// }
