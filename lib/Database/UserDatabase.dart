import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDatabase{
  var users = FirebaseFirestore.instance.collection('Users');

  Future<void> createUser(String name,String userType) async {

    if(userType == 'Customer') {
      await users.doc(FirebaseAuth.instance.currentUser.email).set({
        'Name': name,
        'UserType': userType
      });
    }
    else{
      await users.doc(FirebaseAuth.instance.currentUser.email).set({
        'Name': name,
        'UserType': userType,
        'Markets': [],
      });
    }
  }

}