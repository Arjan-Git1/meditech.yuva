import "package:flutter/material.dart";

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
class LoginPage extends StatelessWidget {
  

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
              Center(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter your username here",

                  ),

                ),
              ),
              Center(
                child: TextField(

                  decoration: InputDecoration(
                    hintText: "Enter your password"
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}



