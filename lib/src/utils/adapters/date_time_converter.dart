import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:intl/intl.dart';

class DateTimeConverter implements ICustomConverter<DateTime> {
  @override
  DateTime fromJSON(jsonValue, [JsonProperty jsonProperty]) {
    if (jsonValue == null || jsonValue.toString().isEmpty) return null;

    if (jsonValue.toString().length > 10) {
      return DateFormat('yyyy-MM-dd H:m:s').parse(jsonValue.toString());
    } else {
      return DateFormat('yyyy-MM-dd').parse(jsonValue.toString());
    }
  }

  @override
  toJSON(DateTime object, [JsonProperty jsonProperty]) {
    if (object == null) return null;

    if ((object.hour == 0) && (object.minute == 0) && (object.second == 0)) {
      return DateFormat('yyyy-MM-dd').format(object);
    }

    return DateFormat('yyyy-MM-dd H:m:s').format(object);
  }
}
