import 'package:avmv005/Model/user_model.dart';

abstract class AuthBase {
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<bool> signOut();
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<User> signInWithEmailPassword(String email, String password);
  Future<User> createUserWithEmailPassword(String email, String password);
}
