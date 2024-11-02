import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shoppingcart_api_/controller/cart_screen_controller.dart';
import 'package:shoppingcart_api_/view/cart_screen/widgets/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CartScreenController>().getProducts();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerobj = context.watch<CartScreenController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return CartItemWidget(
                  title: providerobj.cart[index].name.toString(),
                  desc: providerobj.cart[index].desc.toString(),
                  price: providerobj.cart[index].price.toString(),
                  qty: providerobj.cart[index].qty.toString(),
                  image: providerobj.cart[index].image.toString(),
                  onIncrement: () {
                    context.read<CartScreenController>().incrementQty(index);
                  },
                  onDecrement: () {
                    context.read<CartScreenController>().decrementQty(index);
                  },
                  onRemove: () {
                    context.read<CartScreenController>().removeproduct(index);
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(height: 15),
              itemCount: providerobj.cart.length)),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "total amount : Rs ${providerobj.totalcartAmount}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            InkWell(
              onTap: () {
                Razorpay razorpay = Razorpay();
                var options = {
                  'key': 'rzp_live_ILgsfZCZoFIKMb',
                  'amount': 100,
                  'name': 'Acme Corp.',
                  'description': 'Fine T-Shirt',
                  'retry': {'enabled': true, 'max_count': 1},
                  'send_sms_hash': true,
                  'prefill': {
                    'contact': '8888888888',
                    'email': 'test@razorpay.com'
                  },
                  'external': {
                    'wallets': ['paytm']
                  }
                };
                razorpay.on(
                    Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                    handlePaymentSuccessResponse);
                razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                    handleExternalWalletSelected);
                razorpay.open(options);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    "checkout",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(context, "Payment Successful",
        "Payment ID: ${response.paymentId},Payment ID: ${response.signature},Payment ID: ${response.orderId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
