import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:employee_managment/common/size.dart';
import 'package:employee_managment/common/theme.dart';
import 'package:employee_managment/component/loading_widget.dart';
import 'package:employee_managment/controllers/main/user_provider.dart';
import 'package:employee_managment/controllers/utils.dart';
import 'package:employee_managment/models/users/response_model/restaurant_order_response_model.dart';

class RestaurantOrderList extends StatefulWidget {
  const RestaurantOrderList({
    Key? key,
  }) : super(key: key);

  @override
  State<RestaurantOrderList> createState() => _RestaurantOrderListState();
}

class _RestaurantOrderListState extends State<RestaurantOrderList> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).restaurantOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(FrameSize.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order List",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
            Consumer<UserProvider>(builder: (_, userProvider, __) {
              return userProvider.loading
                  ? const LoadingWidget()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: userProvider
                          .restaurantOrderResponse!.data.restaurantOrder.length,
                      itemBuilder: (BuildContext ctx, i) {
                        RestaurantOrder val = userProvider
                            .restaurantOrderResponse!.data.restaurantOrder[i];
                        return OrdersCard(
                          orderVal: val,
                        );
                      });
            }),
          ],
        ),
      ),
    );
  }
}

class OrdersCard extends StatelessWidget {
  const OrdersCard({
    Key? key,
    required this.orderVal,
  }) : super(key: key);

  final RestaurantOrder orderVal;

  @override
  Widget build(BuildContext context) {
    String itemStatus = MainUtils.convertToTitleCase(orderVal.orderStatus);
    FrameSize.init(context: context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: kSubBlackColor, width: 0.1)),
      child: ExpansionTile(
          backgroundColor: kbgColor,
          collapsedBackgroundColor: kPrimaryLightColor,
          childrenPadding: const EdgeInsets.all(8.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  orderVal.orderNumber,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    const Icon(
                      Icons.watch_later,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${orderVal.estimatedDeliveryTime} min',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.25), // border color
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Center(
                    child: Text(itemStatus,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        )),
                  ),
                ),
              ),
              const Divider()
            ],
          ),
          children: [
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Comment:",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(width: 5),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: kSecondaryColor, width: 0.5),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  orderVal.orderAdditionalComment,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              )),
                        ),
                      ]),
                  SizedBox(
                    width: 300,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Payment Summary",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            PaymentRowWidget(
                              title: "Cart Id:",
                              value: orderVal.cartId,
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Promo code:",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: kSubBlackColor, width: 0.3),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      )),
                                  child: Center(
                                    child: Text(
                                      orderVal.orderPromoCode,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            PaymentRowWidget(
                              title: "Sub-total",
                              value: '${orderVal.subTotal}\$',
                            ),
                            SizedBox(height: 5),
                            PaymentRowWidget(
                              title: "Tax fee",
                              value: "${orderVal.taxFee}\$",
                            ),
                            SizedBox(height: 5),
                            PaymentRowWidget(
                              title: "Delivery fee",
                              value: "${orderVal.deliveryFee}\$",
                            ),
                            SizedBox(height: 5),
                            Divider(),
                            PaymentRowWidget(
                              title: "Total fee",
                              value: "${orderVal.totalCost}\$",
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ])
          ]),
    );
  }
}

class PaymentRowWidget extends StatelessWidget {
  const PaymentRowWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          // "Cart Id:",
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w300,
            fontFamily: 'Poppins',
          ),
        ),
        Text(
          value,
          // orderVal.cartId,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}
