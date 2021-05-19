import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:souqy/model/ads.dart';
import 'package:souqy/service/database_repo.dart';
import 'package:souqy/service/locator.dart';
import 'package:souqy/service/storage_repo.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class AdsController {
  FirestoreDatabase _databaseRepo = locator.get<FirestoreDatabase>();

  StorageRepo _storageRepo = locator.get<StorageRepo>();

  List<Ads> addData;
  AdsController() {
    readAds();
    print(addData);
  }
  Future<void> createAds(Ads data) async {
    try {
      var uuid = Uuid(options: {'grng': UuidUtil.cryptoRNG});
      if (data.moreInfo.listImage.length > 0) {
        for (int i = 0; i < data.moreInfo.listImage.length; i++) {
          String path = "ads/${uuid.v1()}";
          data.moreInfo.listImage[i] = await _storageRepo.uploadFile(
              File(data.moreInfo.listImage[i]), path);
        }
        data.cardInfo.urlThumb = data.moreInfo.listImage[0];
      }
      _databaseRepo.createAds(data.toJson());
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readAds() {
    // FirestoreDatabase _databaseRepo = locator.get<FirestoreDatabase>();
    // StorageRepo _storageRepo = locator.get<StorageRepo>();
    return _databaseRepo.readAds();
    // try {
    // } catch (e) {
    //   print(e);
    //   return null;
    // }
  }
}
