import 'dart:convert';

RestaurantOrderResponseModel restaurantOrderResponseModelFromJson(String str) =>
    RestaurantOrderResponseModel.fromJson(json.decode(str));

String restaurantOrderResponseModelToJson(RestaurantOrderResponseModel data) =>
    json.encode(data.toJson());

class RestaurantOrderResponseModel {
  RestaurantOrderResponseModel({
    required this.status,
    required this.message,
    required this.code,
    required this.data,
  });

  String status;
  String message;
  int code;
  Data data;

  factory RestaurantOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      RestaurantOrderResponseModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.restaurantOrder,
  });

  List<RestaurantOrder> restaurantOrder;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        restaurantOrder: List<RestaurantOrder>.from(
            json["restaurant_order"].map((x) => RestaurantOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "restaurant_order":
            List<dynamic>.from(restaurantOrder.map((x) => x.toJson())),
      };
}

class RestaurantOrder {
  RestaurantOrder({
    required this.orderId,
    required this.userId,
    required this.restaurantId,
    required this.cartId,
    required this.orderStatus,
    required this.estimatedDeliveryTime,
    required this.leaveOrderAtDoorstep,
    required this.scheduledDelivery,
    required this.scheduledDeliveryTime,
    required this.orderAdditionalComment,
    required this.orderType,
    required this.orderPromoCode,
    required this.deliveryFee,
    required this.taxFee,
    required this.subTotal,
    required this.totalCost,
    required this.keepSocialDistance,
    required this.priorityDelivery,
    required this.orderAccepted,
    required this.inTheKitchen,
    required this.isReady,
    required this.isDelivered,
    required this.isRefunded,
    required this.refundCompleted,
    required this.priorityDeliveryFee,
    required this.orderNumber,
    required this.reoccuringDelivery,
    required this.reoccuringDeliveryTime,
    required this.createdAt,
    required this.updatedAt,
  });

  int orderId;
  int userId;
  int restaurantId;
  String cartId;
  String orderStatus;
  String estimatedDeliveryTime;
  bool leaveOrderAtDoorstep;
  bool scheduledDelivery;
  String scheduledDeliveryTime;
  String orderAdditionalComment;
  String orderType;
  String orderPromoCode;
  int deliveryFee;
  int taxFee;
  int subTotal;
  int totalCost;
  bool keepSocialDistance;
  bool priorityDelivery;
  bool orderAccepted;
  bool inTheKitchen;
  bool isReady;
  bool isDelivered;
  bool isRefunded;
  bool refundCompleted;
  int priorityDeliveryFee;
  String orderNumber;
  bool reoccuringDelivery;
  String reoccuringDeliveryTime;
  DateTime createdAt;
  DateTime updatedAt;

  factory RestaurantOrder.fromJson(Map<String, dynamic> json) =>
      RestaurantOrder(
        orderId: json["order_id"],
        userId: json["user_id"],
        restaurantId: json["restaurant_id"],
        cartId: json["cart_id"],
        orderStatus: json["order_status"],
        estimatedDeliveryTime: json["estimated_delivery_time"],
        leaveOrderAtDoorstep: json["leave_order_at_doorstep"],
        scheduledDelivery: json["scheduled_delivery"],
        scheduledDeliveryTime: json["scheduled_delivery_time"],
        orderAdditionalComment: json["order_additional_comment"],
        orderType: json["order_type"],
        orderPromoCode: json["order_promo_code"],
        deliveryFee: json["delivery_fee"],
        taxFee: json["tax_fee"],
        subTotal: json["sub_total"],
        totalCost: json["total_cost"],
        keepSocialDistance: json["keep_social_distance"],
        priorityDelivery: json["priority_delivery"],
        orderAccepted: json["order_accepted"],
        inTheKitchen: json["in_the_kitchen"],
        isReady: json["is_ready"],
        isDelivered: json["is_delivered"],
        isRefunded: json["is_refunded"],
        refundCompleted: json["refund_completed"],
        priorityDeliveryFee: json["priority_delivery_fee"],
        orderNumber: json["order_number"],
        reoccuringDelivery: json["reoccuring_delivery"],
        reoccuringDeliveryTime: json["reoccuring_delivery_time"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "user_id": userId,
        "restaurant_id": restaurantId,
        "cart_id": cartId,
        "order_status": orderStatus,
        "estimated_delivery_time": estimatedDeliveryTime,
        "leave_order_at_doorstep": leaveOrderAtDoorstep,
        "scheduled_delivery": scheduledDelivery,
        "scheduled_delivery_time": scheduledDeliveryTime,
        "order_additional_comment": orderAdditionalComment,
        "order_type": orderType,
        "order_promo_code": orderPromoCode,
        "delivery_fee": deliveryFee,
        "tax_fee": taxFee,
        "sub_total": subTotal,
        "total_cost": totalCost,
        "keep_social_distance": keepSocialDistance,
        "priority_delivery": priorityDelivery,
        "order_accepted": orderAccepted,
        "in_the_kitchen": inTheKitchen,
        "is_ready": isReady,
        "is_delivered": isDelivered,
        "is_refunded": isRefunded,
        "refund_completed": refundCompleted,
        "priority_delivery_fee": priorityDeliveryFee,
        "order_number": orderNumber,
        "reoccuring_delivery": reoccuringDelivery,
        "reoccuring_delivery_time": reoccuringDeliveryTime,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
