import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:pruebaflutter/Servicios/FacebookAuth.dart';

class Autenticacion {
  final authService = FacebookAuth();
  final facebook = FacebookLogin();

  Stream<FirebaseUser> get currentUser => authService.currentUser;
  loginFacebook() async {
    print('Iniciando sesion con facebook');

    final res = await facebook.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email
    ]);

    switch (res.status) {
      case FacebookLoginStatus.Success:
        print('Funciona');

        //Obtener el toke
        final FacebookAccessToken token = res.accessToken;

        //Credencial de autenticacion
        final AuthCredential credencial =
            FacebookAuthProvider.getCredential(accessToken: token.token);

        //Crear usuario firebase
        final usuario = await authService.signInWithCredential(credencial);

        print('${usuario.user.displayName} inicio sesion');

        break;
      case FacebookLoginStatus.Cancel:
        print('Inicio de sesion cancelado');
        break;
      case FacebookLoginStatus.Error:
        print('No se pudo conectar con facebook');
        break;
    }
  }

  logout() {
    authService.logout();
  }
}
