import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:schoolapp/const.dart';

extension e on DateTime{
  standard(){
      return  "${Constants.months["${this.month}"]} ${this.day}, ${this.year}";
  }

}
extension ev on NepaliDateTime{
  standard(){
    return  "${Constants.monthsNep["${this.month}"]} ${this.day}, ${this.year}";
  }
  standardWithDay(){
    return  " ${Constants.days["${this.weekday}"]} ${Constants.monthsNep["${this.month}"]} ${this.day}, ${this.year}";
  }
}