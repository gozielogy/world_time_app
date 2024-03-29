import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String? localtime;
  String flag;
  String url;
  bool? isDaytime;

  WorldTime({required this.location, required this.flag, required this.url});
  Future<void> getTime() async {
    try {
      http.Response responseData =
          await http.get(Uri.parse('https://timeapi.io/api/Time/current/zone?timeZone=$url'));
      Map responseInfo = jsonDecode(responseData.body);
      
      String datetime = responseInfo['dateTime'];
      
      // create datetime object
      DateTime now = DateTime.parse(datetime);
      

      // Set the time property
      localtime = DateFormat.jm().format(now);

      // Set the isDaytime property
      isDaytime = now.hour > 6 && now.hour < 20;
    } catch (e) {
      print('caught error: $e');
      localtime = 'time data fetch error';
    }
  }
}
