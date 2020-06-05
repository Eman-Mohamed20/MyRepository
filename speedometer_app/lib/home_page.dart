

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class HomePage extends StatefulWidget {
  
@override
_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

double timeToReach30=0.0;
double timeToReach10=0.0;
Stopwatch timer=new Stopwatch();
Stopwatch timer2=new Stopwatch();
double speedInMps=0.0;
double speedInKph=0.0;
 final Geolocator  geolocator = Geolocator()..forceAndroidLocationManager = true;
 var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

 

@override
void initState() {
  super.initState();

 
    try {
     
      geolocator.getPositionStream((locationOptions)).listen((position) async {
      speedInMps = position.speed;
      setState(() {
       
        speedInKph = speedInMps * 3.6;
      
        if(speedInKph.round()>= 10 && speedInKph.round()<30)
        {

         timer.start();

        }
         if(speedInKph.round()>=30 ){
           timeToReach30= (timer.elapsedMilliseconds*1000) as double;
           timer.stop();
          timer2.start();
          }
        
        else if(speedInKph.round()<=10 ){
           timeToReach10= (timer.elapsedMilliseconds*1000) as double;
           timer2.stop();
          }

      });

      print(speedInKph.round().toString());
    });
  } catch (e) {
    print(e);
  }
}






@override
Widget build(BuildContext context) {

return MaterialApp(
    home: Scaffold(  
     appBar: AppBar(
        title: Text('SPEEDOMETER'),
        centerTitle: true,
      ),

      body: Center(
       
        child: Column
        (
          
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 90.0)),
      Text(
  ' current Speed',
       style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
           
          ),
        
      
          ),
         Padding(padding: EdgeInsets.only(top: 40.0)),
          Text(
       speedInKph.round().toString() +' Km/h',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
           
          ),
          
          ),
           Padding(padding: EdgeInsets.only(top: 40.0)),
          Text(
         'From 10 To 30 ',
         style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
           
          ),
      
          ),
           Padding(padding: EdgeInsets.only(top: 40.0)),
          Text(
        timeToReach30.toString()+" sec",
          style: TextStyle(
          
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
           
          ),
          
          ),
         
           Padding(padding: EdgeInsets.only(top: 40.0)),
          Text(
         'From 30 To 10 ',
         style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
           
          ),
      
          ),
           Padding(padding: EdgeInsets.only(top: 40.0)),
          Text(
        timeToReach10.toString()+"  sec",
          style: TextStyle(
          
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
           
          ),
          
          )
        
       
        
        ])

      ),

    )
 );
}
}