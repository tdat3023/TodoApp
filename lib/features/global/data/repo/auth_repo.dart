import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  static Future<Either<String, UserCredential>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCre = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return Right(userCre);
    } on FirebaseAuthException catch (err) {
      return Left(err.message ?? "");
    } catch (e) {
      return const Left("");
    }
  }

  static Future<Either<String, UserCredential>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCre = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return Right(userCre);
    } on FirebaseAuthException catch (err) {
      return Left(err.message ?? "");
    } catch (e) {
      return const Left("");
    }
  }

  static Future<Either<String, bool>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return const Right(true);
    } on FirebaseAuthException catch (err) {
      return Left(err.message ?? "");
    } catch (e) {
      return const Left("");
    }
  }

  static Future<Either<String, bool>> updatePassword({
    required String newPassword,
    required UserCredential userCredential,
  }) async {
    try {
      await userCredential.user?.updatePassword(newPassword);
      return const Right(true);
    } on FirebaseAuthException catch (err) {
      return Left(err.message ?? "Đổi mật khẩu không thành công");
    } catch (e) {
      return const Left("Đổi mật khẩu không thành công");
    }
  }
}
