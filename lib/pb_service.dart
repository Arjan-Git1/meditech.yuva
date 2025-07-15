// lib/pb_service.dart
import 'medicine_body.dart';
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase(

    'http://127.0.0.1:8090'       // Android‑emulator localhost
  // 'http://192.168.0.xx:8090', // Wi‑Fi IP
);
Future<void> createMedicine(String name, DateTime time) async {
  await pb.collection('medicines').create(body: {
    'name': name,
    'time': time.toIso8601String(),
    'taken': false,
  });
}

Future<List<Medicine>> fetchMedicines() async {
  final result = await pb.collection('medicines').getFullList();
  return result.map((r) => Medicine.fromJSON(r.toJson())).toList();
}

Future<void> markAsTaken(String id, bool taken) async {
  await pb.collection('medicines').update(id, body: {'taken': taken});
}
