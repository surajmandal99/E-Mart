import 'package:emart_app/consts/consts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        body: SafeArea(
            child: Container(
      color: whiteColor,
      child: const Center(child: Text("Cart Is Empty")),
    ))));
  }
}
