import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nextalk_community/core/constants/app_constants.dart';
import 'package:nextalk_community/core/error/exceptions.dart';
import 'package:nextalk_community/features/auth/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<UserModel> signUpWithEmailAndPassword(
      String email, String password, String username);
  Future<UserModel> signInWithGoogle();
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
  Stream<User?> get authStateChanges;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl(
      {required this.firebaseAuth,
      required this.firestore,
      required this.googleSignIn});

  @override
  Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = credential.user;
      if (user == null) {
        throw const AuthException('Sign in failed');
      }
      return await _getUserFromFirestore(user.uid);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Authentication failed');
    } catch (e) {
      throw AuthException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      // Check if username already exists
      final querySnapshot = await firestore
          .collection(AppConstants.usersCollection)
          .where('username', isEqualTo: username)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        throw const AuthException('Username already exists');
      }

      final credential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = credential.user;
      if (user == null) {
        throw const AuthException('Sign up failed');
      }

      final userModel = UserModel(
          uid: user.uid,
          email: user.email ?? email,
          username: username,
          role: AppConstants.roleUser,
          createdAt: DateTime.now());

      await firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid)
          .set(userModel.toFirestore());

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Registration failed');
    } catch (e) {
      throw AuthException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw const AuthException('Google sign-in aborted');
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) {
        throw const AuthException('Google sign-in failed');
      }

      // Check if user exists in Firestore
      final userDoc = await firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        return UserModel.fromFirestore(userDoc);
      }

      // Create new user
      final username = user.displayName?.replaceAll(' ', '_').toLowerCase() ??
          'user_${user.uid.substring(0, 8)}';

      // Check if username exists
      var finalUsername = username;
      var counter = 1;
      while (true) {
        final usernameQuery = await firestore
            .collection(AppConstants.usersCollection)
            .where('username', isEqualTo: finalUsername)
            .limit(1)
            .get();

        if (usernameQuery.docs.isEmpty) break;
        finalUsername = '$username$counter';
        counter++;
      }

      final userModel = UserModel(
        uid: user.uid,
        email: user.email ?? '',
        username: finalUsername,
        profileImageUrl: user.photoURL,
        role: AppConstants.roleUser,
        createdAt: DateTime.now(),
      );

      await firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid)
          .set(userModel.toFirestore());

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Google sign-in failed');
    } catch (e) {
      throw AuthException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.wait([
        firebaseAuth.signOut(),
        googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw AuthException('Sign out failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user == null) return null;
    return await _getUserFromFirestore(user.uid);
  }

  @override
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<UserModel> _getUserFromFirestore(String uid) async {
    try {
      final doc = await firestore
          .collection(AppConstants.usersCollection)
          .doc(uid)
          .get();
      if (!doc.exists) {
        throw const AuthException('User not found');
      }
      return UserModel.fromFirestore(doc);
    } catch (e) {
      throw AuthException('Failed to get user: ${e.toString()}');
    }
  }
}
