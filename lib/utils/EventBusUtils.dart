
import 'package:event_bus/event_bus.dart';

class EventBusUtils {
  static final EventBus instance=EventBus();

}


class StringContentEvent{
  String str;
  StringContentEvent(this.str);
}