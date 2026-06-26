class EventLogger {


  EventLogger._();



  static final List<String> _logs = [];




  // Add new event
  static void add(String event) {


    _logs.add(

      "${DateTime.now().toLocal()} : $event",

    );


  }




  // Get all events
  static List<String> getLogs() {


    return List.from(
      _logs.reversed,
    );


  }




  // Clear events
  static void clear() {


    _logs.clear();


  }




  // Get latest event
  static String? latest() {


    if (_logs.isEmpty) {

      return null;

    }


    return _logs.last;


  }


}