import 'dart:io';

import 'package:emart_app/consts/consts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var profileImgPath = ''.obs;

  //to store the location of the new image
  var profileImageLink = '';

  var isLoading = false.obs;

  //text controller
  var nameController = TextEditingController();
  var pssController = TextEditingController();

//function to add a new image by picking from the gallery

  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) return;
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  //method to upload the profile
  uploadProfileImage() async {
    var filename = (profileImgPath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImageLink = await ref.getDownloadURL();
  }

// //method to update the profile

  // updateProfile({name, password, imgUrl}) async {
  //   var store = firestore.collection(userCollection).doc(currentUser!.uid);
  //   await store.set({'name': name, 'password': password, 'imageUrl': imgUrl},
  //       SetOptions(merge: true));
  //   isLoading(false);
  // }
}
