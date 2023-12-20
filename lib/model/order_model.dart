enum OrderType { Pickup, DropOff }

class OrderModel {
  final String id;
  final String location;
  final String name;
  final List size;
  final int weight;
  final OrderType orderType;
  OrderModel(
      {required this.id,
      required this.location,
      required this.name,
      required this.size,
      required this.weight,
      required this.orderType});
}
