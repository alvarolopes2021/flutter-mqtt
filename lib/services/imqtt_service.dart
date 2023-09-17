import 'dart:async';

abstract class IMqttService {
  void connect();
  void disconnect();
  void sendData();
  void readData(StreamController controller);

  late bool willSave;
}