import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:esport_flame/app/entitiles/failure.dart';
import 'package:esport_flame/feature/auth/application/entities/login_request.dart';
import 'package:esport_flame/feature/auth/application/entities/login_response.dart';
import 'package:esport_flame/feature/auth/application/entities/signup_request.dart';
import 'package:esport_flame/feature/auth/application/entities/signup_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepository =
    Provider<IAuthRepository>((ref) => AuthRepository(ref.read));

abstract class IAuthRepository {
  /* logout user */
  Future<Either<Unit, Failure>> logout();

  /* Signup new user */
  Future<Either<SignupResponse, Failure>> signupNewUser(
      {required SignupRequest newSignupRequest});

  /* Signup new user */
  Future<Either<LoginResponse, Failure>> loginUser({
    required LoginRequest loginRequest,
  });
}

class AuthRepository implements IAuthRepository {
  AuthRepository(Reader read) : _read = read;

  // ignore: unused_field
  final Reader _read;
  // ignore: unused_field
  final _dio = Dio(); //This is for googlr login

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Either<SignupResponse, Failure>> signupNewUser(
      {required SignupRequest newSignupRequest}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: newSignupRequest.email,
        password: newSignupRequest.password,
      );
      final user = _auth.currentUser;
      newSignupRequest.toJson().removeWhere((key, value) => key == 'password');
      await _firestore.collection('users').doc(user?.uid).set(
            newSignupRequest.toJson(),
          );
      return Left(
        SignupResponse(
          contactNo: newSignupRequest.contactNo,
          email: newSignupRequest.email,
          message: 'Signup success',
          nickName: newSignupRequest.nickName,
        ),
      );
    } on FirebaseAuthException catch (e) {
      final user = _auth.currentUser;
      await user?.delete();
      return Right(
        Failure(
          errorMessage:
              e.message ?? 'Something went wrong, try in few moments !',
        ),
      );
    } catch (e) {
      final user = _auth.currentUser;
      await user?.delete();
      return Right(
        Failure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<LoginResponse, Failure>> loginUser(
      {required LoginRequest loginRequest}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Unit, Failure>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
