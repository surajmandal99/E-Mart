// import 'dart:html';

import 'package:emart_app/common_widget/bg_widget.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../../../common_widget/const_buttons.dart';
import '../../../common_widget/custom_textfield.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    // controller.nameController.text = data['name'];
    // controller.pssController.text = data['password'];
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(
        (() => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // controller.profileImgPath.isEmpty
                //     ?
                Image.network(
                        "https://avatars.githubusercontent.com/u/105273927?v=4",
                        width: 100,
                        fit: BoxFit.cover)
                    .box
                    .roundedFull
                    .clip(Clip.antiAlias)
                    .make(),
                // :
                //  Image.file(File(controller.profileImgPath.value),
                //         width: 100, fit: BoxFit.cover)
                //     .box
                //     .roundedFull
                //     .clip(Clip.antiAlias)
                //     .make(),
                10.heightBox,

                //image button
                constButton(
                    color: redColor,
                    onPress: () {
                      controller.changeImage(context);
                    },
                    textColor: whiteColor,
                    title: "Change Profile"),
                const Divider(),
                20.heightBox,
                customTextField(
                    hint: nameHint,
                    title: name,
                    isPass: false,
                    controller: controller.nameController),
                customTextField(
                    hint: passwordHint,
                    title: password,
                    isPass: true,
                    controller: controller.pssController),
                20.heightBox,

                //save button
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : SizedBox(
                        width: context.screenWidth - 60,
                        child: constButton(
                            color: redColor,
                            onPress: () async {
                              // controller.isLoading(true);
                              // await controller.uploadProfileImage();
                              // await controller.updateProfile(
                              //   imgUrl: controller.profileImageLink,
                              //   name: controller.nameController,
                              //   password: controller.pssController,
                              // );
                              // VxToast.show(context, msg: "Updated");
                            },
                            textColor: whiteColor,
                            title: "Save Profile"),
                      ),
              ],
            )
                .box
                .white
                .shadowSm
                .padding(const EdgeInsets.all(16))
                .margin(const EdgeInsets.only(top: 50, left: 13, right: 13))
                .rounded
                .make()),
      ),
    ));
  }
}
