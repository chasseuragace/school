import 'package:schoolapp/const.dart';

extension e on DateTime{
  standard(){
      return "${Constants.months["${this.month}"]} ${this.day}, ${this.year}";
  }

}