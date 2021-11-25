import 'package:flutter/material.dart';
class Second extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}
class  _SecondState extends State<Second>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: SafeArea(
       child: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text('Wellcome User'),
             SizedBox(height: 50,),
             OutlineButton.icon(
               onPressed: (){},
               icon: Icon(
                 Icons.access_alarm ,
                 size: 18,
               ),
               label: Text("Logout"),
             )
           ],
         ),
       ),
     )
   );
  }
  
}