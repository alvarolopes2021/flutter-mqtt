import 'dart:async';

import 'package:flutter_mqtt/services/imqtt_service.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttServiceImpl implements IMqttService {
  final client = MqttServerClient('mqtt.eclipseprojects.io', 'projetinho');

  @override
  void connect() async {
    try {
      await client.connect();
      print('con status: ');
      print(client.connectionStatus);
      client.subscribe('PET_CONTROLLER_ETE', MqttQos.atMostOnce);
    } catch (e) {
      print('con refused: ');
    }
  }

  @override
  void disconnect() async {
    try {
      client.disconnect();
      print('con status: ');
      print(client.connectionStatus);
    } catch (e) {
      print('con refused: ');
    }
  }

  @override
  void readData(StreamController controller) {
    // TODO: implement readData
    client.updates!.listen((event) {
      final recMess = event[0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      print('EXAMPLE::Change notification:: topic is <${event[0].topic}>, payload is <-- $pt -->');

      controller.add(pt);
          
      print('');
    });
  }

  @override
  void sendData() {
    // TODO: implement sendData
  }
}
