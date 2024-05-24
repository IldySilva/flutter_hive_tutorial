import 'package:intl/intl.dart';

extension DateExtensions on DateTime{

  String getDayAndHour(){
    var now=DateTime.now();

    if(day==now.day && month==now.month && year==now.year) {
      return DateFormat("hh:mm").format(this);
    }


    return DateFormat("dd/MM/yy || hh:mm").format(this);

  }

}