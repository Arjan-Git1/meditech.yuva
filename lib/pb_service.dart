// lib/pb_service.dart
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase(
  // ⚠️ Windows EXE cannot reach 127.0.0.1 on a different PC.
  // For testing on your own machine keep localhost;
  // for the demo point to the LAN / cloud IP of your PocketBase server.
    'http://127.0.0.1:8090'       // Android‑emulator localhost
  // 'http://192.168.0.xx:8090', // Wi‑Fi IP
);
