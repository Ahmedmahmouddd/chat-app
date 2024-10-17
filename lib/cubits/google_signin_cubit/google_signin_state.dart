part of 'google_signin_cubit.dart';

@immutable
sealed class GoogleSignInState {}

class GoogleSigninInitial extends GoogleSignInState {}

class GoogleSignInLoading extends GoogleSignInState {}
class GoogleSignInCancelled extends GoogleSignInState {}


class GoogleSignInSuccessNewUser extends GoogleSignInState {}

class GoogleSignInSuccessExistingUser extends GoogleSignInState {}

class GoogleSignInFailure extends GoogleSignInState {
  final String errMessage;
  GoogleSignInFailure({required this.errMessage});
}
