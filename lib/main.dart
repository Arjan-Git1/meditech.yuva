import "package:flutter/material.dart";
import 'pb_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

final emailCtrl    = TextEditingController();
final passwordCtrl = TextEditingController();


void main()=> runApp(MaterialApp(
  home: Home(),
));
class  Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar:AppBar(),
        body:Container(
          width: double.infinity,
          height: double.infinity,
          decoration:BoxDecoration(
          image: DecorationImage(
              image:
              AssetImage('images/image.png'),
              fit: BoxFit.cover

          ),
    ),
    child: Align(alignment: Alignment(0.1, -0.2),child:Column(

        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("MEDITECH", style: TextStyle(fontSize: 45, fontFamily: 'Azonix')),
        SizedBox(height: 0),
        Text("Your Smart Health Companion", style: TextStyle(fontFamily: 'Azonix',fontSize: 15)),
        SizedBox(height: 1,),
        ElevatedButton(onPressed: (){
          Navigator.push(context, 
            MaterialPageRoute(builder: (context)=>LoginPage(),)          
          );
        },
            child: Text("GET STARTED",),
            style: ElevatedButton.styleFrom(

            ),)
      ],
    ),
    ),),

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

// your build() method stays unchanged


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(

        ),
        child: Align(
          alignment: Alignment(0.1, -0.2),
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            
            children: [
              Container(
                  padding: EdgeInsets.all(150),

                  child: TextField(
                  controller: emailCtrl,
                  decoration: InputDecoration(
                    hintText: "Enter your email here",

                  ),

                
              ),
        ),

              Container(
                padding: EdgeInsets.all(150),
                child:
              Center(
                widthFactor:10.0,

                child: TextField(
                  style:TextStyle(
                    fontSize: 10,
                    height: 2.0,

                  ),

                  controller: passwordCtrl,
                  obscureText: true,
                  decoration: InputDecoration(

                      hintText: "Enter your password"
                  ),
                ),
              ),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await pb.collection('users').authWithPassword(
                      emailCtrl.text.trim(),
                      passwordCtrl.text.trim(),
                    );
                    // success ➜ replace page so user can’t go back
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => Welcomepage()),
                    );
                  } catch (err) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login failed: $err')),
                    );
                  }
                },
                child: const Text('Submit'),

              ),
              TextButton(
                onPressed: () async {
                  try {
                    await pb.collection('users').create(body: {
                      'email': emailCtrl.text.trim(),
                      'password': passwordCtrl.text,
                      'passwordConfirm': passwordCtrl.text,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Account created – now log in.')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Sign‑up failed: $e')),
                    );
                  }
                },
                child: const Text('Sign Up'),

              ),
        ],),



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
          style: TextStyle(
            fontFamily: 'Azonix',
            fontSize: 25,
          ),

        ),


      ),
        body:   Scrollbar(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Text("Medicine reminder"),
                      ElevatedButton(onPressed: (){}, child:Text("MEDREM"))
                    ],
                  ),
                )
              ],
            )
        ),
    );
  }
}