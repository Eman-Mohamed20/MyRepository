
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class HomePage extends StatefulWidget {
  
@override
_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
double initiallat=0.0;
double initiallong=0.0;
double finallat=0.0;
double finallong=0.0;

double initialspeed=0.0;
double timeToReach30=0.0;
double timeToReach10=0.0;

double distancePM=0.0;
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
        if(speedInKph?.round()==10)
        {
         
           initiallat  =position.latitude;
           initiallong=position.longitude;

        }
        else if( speedInKph?.round()==30)
        {
           finallat  =position.latitude;
           finallong=position.longitude;
        distancePM =Geolocator().distanceBetween(initiallat, initiallong, finallat, finallong) as double;
        initialspeed=10.0;
        timeToReach30=(distancePM*0.001) /((initialspeed+speedInKph)/2);
        timeToReach30=timeToReach30*3600;
        ///return time
         initialspeed=30.0;
         speedInKph=10.0;
         distancePM =Geolocator().distanceBetween(finallat, finallong,initiallat, initiallong) as double;

        timeToReach10=(distancePM*0.001) /((initialspeed+speedInKph)/2);
        timeToReach10=timeToReach30*3600;
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