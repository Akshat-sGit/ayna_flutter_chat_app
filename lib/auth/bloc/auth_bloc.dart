import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Define events
abstract class AuthEvent {}

class GoogleSignInRequested extends AuthEvent {}

class SignOutRequested extends AuthEvent {}

// Define states
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(this.user);
}

class AuthError extends AuthState {
  final String error;
  AuthError(this.error);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthBloc() : super(AuthInitial()) {
    on<GoogleSignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        if (_isWeb()) {
          // Trigger Google Sign-in flow for web
          final GoogleAuthProvider googleProvider = GoogleAuthProvider();
          googleProvider.addScope('email');
          googleProvider.addScope('profile');

          final UserCredential userCredential =
              await _auth.signInWithPopup(googleProvider);
          emit(AuthSuccess(userCredential.user!));
        } else {
          // Trigger Google Sign-in flow for mobile
          final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
          if (googleUser == null) return;

          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          final OAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          emit(AuthSuccess(userCredential.user!));
        }
      } catch (error) {
        emit(AuthError(error.toString()));
      }
    });

    on<SignOutRequested>((event, emit) async {
      emit(AuthLoading());
      await _auth.signOut();
      if (!_isWeb()) {
        await _googleSignIn.signOut();
      }
      emit(AuthInitial());
    });
  }

  bool _isWeb() {
    return identical(0, 0.0);
  }
}
