import "package:flutter/material.dart";

void main()=> runApp(MaterialApp(
  home: Home(),
));
class  Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(centerTitle:true,backgroundColor:Colors.orange,
             title: Text("MediTech",textAlign:TextAlign.center, )
           ),
    );
  }
}


