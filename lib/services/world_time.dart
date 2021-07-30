import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location;  //location name for the UI
  late String time; //the time in that location
  String flag; //url to an asset flag icon
  String url; //location url for api endpoint
  late bool isDayTime; //true or false if daytime or not

  WorldTime({required this.location,required this.flag,required this.url});
  //async function makes the code not wait for other code to execute
  Future<void> getTime() async{

    try{
      //make the request
      Response response= await get (Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data= jsonDecode(response.body);

      //get properties from data
      String dateTime= data['datetime'];
      String offset= data['utc_offset'].substring(1,3);

      //Create a DateTime object
      DateTime now= DateTime.parse(dateTime);
      now=now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour>6 && now.hour<20 ? true:false;

      //Set the time property by formatting it to a more understandable format
      time = DateFormat.jm().format(now);

    }
    catch(e){
      print('caught error: $e');
      time='could not get time data';
    }


  }


}