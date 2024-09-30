class Stadium {
  final String name;
  final String city;
  final String status;
  final String imageName;
  final int seatingCapacity;

  Stadium({
    required this.name,
    required this.city,
    required this.status,
    required this.imageName,
    required this.seatingCapacity,
  });

  static Stadium fromJson(Map<String, dynamic> json) {
    return Stadium(
      name: json['name'],
      city: json['city'],
      status: json['status'],
      imageName: json['imageName'],
      seatingCapacity: json['seatingCapacity'],
    );
  }
}
