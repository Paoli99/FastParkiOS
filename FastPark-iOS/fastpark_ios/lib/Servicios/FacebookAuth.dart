import 'package:firebase_auth/firebase_auth.dart';

class FacebookAuth {
  final _auth = FirebaseAuth.instance;

  //Cambio de estado del usuario
  Stream<FirebaseUser> get currentUser => _auth.onAuthStateChanged;
  Future<AuthResult> signInWithCredential(AuthCredential credential) =>
      _auth.signInWithCredential(credential);
  Future<void> logout() => _auth.signOut();
}
