import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:esport_flame/app/entitiles/failure.dart';
import 'package:esport_flame/core/base_response/base_response.dart';
import 'package:esport_flame/features/admin/infrastructure/entities/add_ads_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as path;

final adminRepository =
    Provider<IAdminRepository>((ref) => AdminRepository(ref.read));

abstract class IAdminRepository {
  Future<Either<BaseResponse, Failure>> addAds({
    required AddAdsRequest addAdsRequest,
  });
}

class AdminRepository implements IAdminRepository {
  AdminRepository(Reader read) : _read = read;

  // ignore: unused_field
  final Reader _read;
  @override
  Future<Either<BaseResponse, Failure>> addAds({
    required AddAdsRequest addAdsRequest,
  }) async {
    try {
      final fileName = path.basename(addAdsRequest.adsImage.path);
      final reference = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('ads_images')
          .child(fileName);
      final uploadImage = reference.putFile(addAdsRequest.adsImage);
      firebase_storage.TaskSnapshot storageTaskSnapshot;
      await uploadImage.then(
        (value) {
          storageTaskSnapshot = value;
          storageTaskSnapshot.ref.getDownloadURL().then(
            (downloadUrl) async {
              await FirebaseFirestore.instance.collection('ads').doc().set(
                {
                  'adsTitle': addAdsRequest.adsTitle,
                  'aboutInfo': addAdsRequest.adsDescpription,
                  'image': downloadUrl,
                },
              );
            },
          );
        },
      );
      return const Left(
        BaseResponse(code: 200, data: null, message: 'Success'),
      );
    } on FirebaseAuthException catch (e) {
      return Right(
        Failure(
          errorMessage:
              e.message ?? 'Something went wrong, try in few moments !',
        ),
      );
    } catch (e) {
      return Right(
        Failure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
