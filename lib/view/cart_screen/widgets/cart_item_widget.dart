import 'dart:math';

import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.title,
    required this.desc,
    required this.qty,
    required this.price,
    this.onIncrement,
    this.onDecrement,
    this.onRemove,
    this.image,
  });
  final String title;
  final String desc;
  final String qty;
  final String price;

  final String? image;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    //   decoration: BoxDecoration(
    //       color: Colors.grey.shade300, borderRadius: BorderRadius.circular(15)),
    //   child: Column(
    //     children: [
    //       Row(
    //         children: [
    //           ClipRRect(
    //             borderRadius: BorderRadius.circular(15),
    //             child: Image.network(
    //               image!,
    //               height: 100,
    //               width: 100,
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //           SizedBox(width: 16),
    //           Expanded(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   title,
    //                   style:
    //                       TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    //                 ),
    //                 SizedBox(height: 10),
    //                 Text(
    //                   desc,
    //                   maxLines: 1,
    //                   overflow: TextOverflow.ellipsis,
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Spacer(),
    //           Column(
    //             children: [
    //               ElevatedButton(
    //                   onPressed: onIncrement, child: Icon(Icons.add)),
    //               Text(
    //                 qty,
    //                 style: TextStyle(
    //                     color: Colors.red,
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 22),
    //               ),
    //               ElevatedButton(
    //                   onPressed: onDecrement, child: Icon(Icons.remove)),
    //             ],
    //           ),
    //         ],
    //       ),
    //       InkWell(
    //         onTap: onRemove,
    //         child: Container(
    //           padding: EdgeInsets.all(5),
    //           width: double.infinity,
    //           alignment: Alignment.center,
    //           decoration: BoxDecoration(
    //               color: Colors.red, borderRadius: BorderRadius.circular(10)),
    //           child: Text(
    //             "Remove",
    //             style: TextStyle(
    //                 color: Colors.white,
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 20),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );

    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            image!,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  desc,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey),
                ),
                Text(price),
                SizedBox(
                  width: 5,
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(width: .1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: onDecrement,
                            child: Text(
                              "-",
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(qty),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: onIncrement,
                            child: Text(
                              "+",
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Colors.red),
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.white)),
                        onPressed: onRemove,
                        child: Text("Delete"))
                  ],
                )
              ],
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
