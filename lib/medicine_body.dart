class Medicine {
  final String id;
  final String name;
  final DateTime time;
  final bool taken;

  Medicine(
      {required this.id, required this.name, required this.time, required this.taken});

  factory Medicine.fromJSON(Map<String, dynamic> json)
  {
    return Medicine(
      id: json['id'],
      name: json['name'],
      time: DateTime.parse(json['time']),
      taken: json['taken'],
    );
  }
}