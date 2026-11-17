import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wastepickup/features/scheduler/domain/models/user_model.dart'; 

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmail({
    required String email,
    required String password,
    required String fullname,
    required String sector,
  }) async {
    try {
      UserCredential identity = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = identity.user;

      if (user != null) {
        UserScheduleModel residential = UserScheduleModel(
          uid: user.uid,
          fullName: fullname, 
          sector: sector,
          collectionDay: 'Tuesday',
          shiftTime: 'Morning',
        );
        
        await _firestore.collection('users').doc(user.uid).set(residential.toMap());
      }
      return user;
    } catch (e) {
      print('Registering error: $e');
      return null;
    }
  }

  Future<User?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print('Sign in error: $e');
      return null;
    }
  }
}