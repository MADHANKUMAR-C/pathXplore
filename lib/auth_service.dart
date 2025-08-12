import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> signUp({
    required String email,
    required String password,
    required String name,
    required String userType,
    required List<String> skills, // Added skills parameter
  }) async {
    try {
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user ID
      String uid = userCredential.user!.uid;

      // Prepare user data to store in Firestore
      Map<String, dynamic> userData = {
        'name': name,
        'email': email,
        'userType': userType,
        'skills': skills, // Save the skills here
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Save user data to Firestore
      await _firestore.collection('users').doc(uid).set(userData);

      return null; // Success
    } catch (e) {
      print(e.toString());
      return e.toString(); // Return error message if there's an error
    }
  }


  Future<String?> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
