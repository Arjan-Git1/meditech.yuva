import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'pb_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

final emailCtrl    = TextEditingController();
final passwordCtrl = TextEditingController();
final medCtrl = TextEditingController();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('loggedIn') ?? false;
  runApp(MaterialApp(home: isLoggedIn ? Welcomepage() : Home()));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment(0.1, -0.2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("MEDITECH", style: TextStyle(fontSize: 45, fontFamily: 'Azonix')),
              SizedBox(height: 0),
              Text("Your Smart Health Companion", style: TextStyle(fontFamily: 'Azonix', fontSize: 15)),
              SizedBox(height: 1),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
                },
                child: Text("GET STARTED"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailCtrl;
  late TextEditingController passwordCtrl;

  @override
  void initState() {
    super.initState();
    emailCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Align(
          alignment: Alignment(0.1, -0.2),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Email
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                  child: TextField(
                    controller: emailCtrl,
                    decoration: InputDecoration(
                      hintText: "Enter your email here",
                      filled: true,
                      fillColor: Colors.yellow.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                // Password
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                  child: TextField(
                    controller: passwordCtrl,
                    obscureText: true,
                    style: TextStyle(fontSize: 14, height: 1.5),
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      filled: true,
                      fillColor: Colors.yellow.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                // Login Button
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await pb.collection('users').authWithPassword(
                          emailCtrl.text.trim(),
                          passwordCtrl.text.trim(),
                        );

                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('loggedIn', true);

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => Welcomepage()));
                      } catch (err) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login failed: $err')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[700],
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Submit'),
                  ),
                ),

                // Sign Up
                TextButton(
                  onPressed: () async {
                    try {
                      await pb.collection('users').create(body: {
                        'email': emailCtrl.text.trim(),
                        'password': passwordCtrl.text,
                        'passwordConfirm': passwordCtrl.text,
                      });

                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('loggedIn', true);

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => Welcomepage()));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Sign‑up failed: $e')),
                      );
                    }
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Welcomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("MEDITECH",
          style: TextStyle(fontFamily: 'Azonix', fontSize: 25),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              pb.authStore.clear();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Home()));
            },
          )
        ],
      ),
      body: Container(
        color: const Color(0xFFFFF8E1),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.medical_services_outlined, size: 44, color: Colors.deepPurple),
                    const SizedBox(height: 8),
                    const Text(
                      "Medicine Reminder",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => medrem()));
                      },
                      icon: const Icon(Icons.alarm, size: 15),
                      label: const Text("Go to MedRem"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class medrem extends StatefulWidget {
  @override
  _medremState createState() => _medremState();
}

class _medremState extends State<medrem> {
  final TextEditingController medCtrl = TextEditingController();
  final TextEditingController dosectrl = TextEditingController();
  DateTime? selectedDateTime;

  Future<void> pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(minutes: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    setState(() {
      selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("MEDITECH",
          style: TextStyle(fontFamily: 'Azonix', fontSize: 25),
        ),
      ),
      body: Container(
        color: const Color(0xFFFFF8E1),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              margin: EdgeInsets.all(20),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: medCtrl,
                      decoration: InputDecoration(
                        hintText: "Med Name here",
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: dosectrl,
                      decoration: InputDecoration(
                        hintText: "Enter Dosage",
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: pickDateTime,
                      child: Text("Pick Date & Time"),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        final userId = pb.authStore.model.id;
                        try {
                          await pb.collection('medicines').create(
                            body: {
                              'medicine': medCtrl.text.trim(),
                              'dosage': dosectrl.text.trim(),
                              'reminder': selectedDateTime?.toIso8601String(),
                              'user': userId,
                            },
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Medicine saved")),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error saving medicine: $e")),
                          );
                        }
                      },
                      child: Text("Save"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}






