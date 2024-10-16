import 'package:bloc/bloc.dart';
import 'package:chat_app/auth/methods/save_user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUp(String email, password, userName) async {
    emit(SignUpLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      saveUserDetails(userName);
      emit(SignUpValidate());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpFailure(errMessage: "The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpFailure(
            errMessage: "An account already exists for that email. If it is yours, Login instead."));
      } else if (e.code == 'invalid-email') {
        emit(SignUpFailure(errMessage: "The email provided is invalid."));
      }
    }
  }
}
