// lib/app/services/social_auth_service.dart
import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialIdentity {
  final String email;
  final String? idToken; // OIDC token (useful if you verify server-side later)
  SocialIdentity({required this.email, this.idToken});
}

class SocialAuthService {
  // For 6.x you can (optionally) pass clientId for iOS and serverClientId (Web client ID)
  // If your server doesn't verify tokens, you can omit these and just keep scopes: ['email'].
  final GoogleSignIn _google = GoogleSignIn(
    scopes: ['email'],
    // Provide these if you have them set up:
    // clientId: Platform.isIOS ? '<YOUR_IOS_CLIENT_ID>.apps.googleusercontent.com' : null,
    // serverClientId: '<YOUR_WEB_CLIENT_ID>.apps.googleusercontent.com',
    // hostedDomain: null,
    // forceCodeForRefreshToken: false,
  );

  /// Google Sign-In (works on 6.3.0)
  Future<UserCredential> google() async {
    print('Hi1');
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    print('Hi2');

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /// Apple Sign-In (iOS only)
  Future<SocialIdentity> apple() async {
    if (!Platform.isIOS) {
      throw Exception('Apple Sign In is only available on iOS');
    }

    final cred = await SignInWithApple.getAppleIDCredential(
      scopes: [AppleIDAuthorizationScopes.email],
    );

    final email = cred.email;
    if (email == null || email.isEmpty) {
      throw Exception(
        'Apple did not return an email. Please sign in once with email/password to link.',
      );
    }

    return SocialIdentity(
      email: email,
      idToken: cred.identityToken,
    );
  }

  /// Optional: sign-out helpers
  Future<void> signOutGoogle() => _google.signOut();
}
