import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/common_widget/bg_widget.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/auth/login_screen.dart';
import 'package:emart_app/views/auth/profile_screen/components/details_card.dart';
import 'package:emart_app/views/auth/profile_screen/edit_profile_screen.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //initliziing the profile Controller
    // ignore: unused_local_variable
    var controller = Get.put(ProfileController());
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
                stream: FirestoreServices.getUser(currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ));
                  } else {
                    var data = snapshot.data!.docs[0];
                    return SafeArea(
                        child: Column(children: [
                      //edit profile button
                      const Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20, top: 10),
                            child: Icon(
                              Icons.edit,
                              color: whiteColor,
                            ),
                          )).onTap(() {
                        controller.nameController.text = data['name'];
                        controller.pssController.text = data['password'];

                        Get.to(EditProfileScreen(
                          data: data,
                        ));
                      }),

                      //users details section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            data['imageUrl'] == ''
                                ? Image.network(
                                    "https://avatars.githubusercontent.com/u/105273927?v=4",
                                    width: 100,
                                    fit: BoxFit.cover)
                                : Image.network(
                                    data['imageUrl'],
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ).box.roundedFull.clip(Clip.antiAlias).make(),
                            10.widthBox,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .white
                                    .make(),
                                "${data['email']}".text.white.make()
                              ],
                            )),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: whiteColor)),
                                onPressed: () async {
                                  Get.put(AuthController())
                                      .signoutMethod(context);
                                  Get.offAll(() => const LoginScreen());
                                },
                                child: "logout"
                                    .text
                                    .fontFamily(semibold)
                                    .white
                                    .make())
                          ],
                        ),
                      ),
                      20.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          detailsCard(
                              count: data['cart_count'],
                              title: "in your cart",
                              width: context.screenWidth / 3.4),
                          detailsCard(
                              count: data['wishlist_count'],
                              title: "in your wishlist",
                              width: context.screenWidth / 3.4),
                          detailsCard(
                              // count: "0",
                              count: data['order_count'],
                              title: "your orders",
                              width: context.screenWidth / 3.4)
                        ],
                      ),

                      //button screen

                      ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  color: lightGrey,
                                );
                              },
                              itemCount: profileButtonList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: Image.asset(
                                    proflileButtonIcon[index],
                                    width: 22,
                                  ),
                                  title: profileButtonList[index]
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                );
                              })
                          .box
                          .white
                          .rounded
                          .margin(const EdgeInsets.all(12))
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .shadowSm
                          .make()
                          .box
                          .color(redColor)
                          .make()
                    ]));
                  }
                })));
  }
}
