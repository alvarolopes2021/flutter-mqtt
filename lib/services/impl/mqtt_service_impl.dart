import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter_mqtt/services/ihttp_service.dart';
import 'package:flutter_mqtt/services/impl/http_service_impl.dart';
import 'package:flutter_mqtt/services/imqtt_service.dart';

class MqttServiceImpl implements IMqttService {
  final client = MqttServerClient.withPort(
      'xxx',
      'xxx',
      8883);

  bool willSave = false;
  bool error = false;

  late IHttpService _httpService;

  MqttServiceImpl() {
    _httpService = HttpServiceImpl();
  }

  @override
  void connect() async {
    try {
      // the next 2 lines are necessary to connect with tls, which is used by HiveMQ Cloud
      client.secure = true;
      client.securityContext = SecurityContext.defaultContext;
      client.keepAlivePeriod = 20;
      await client.connect("xxx", "xxx");

      print('con status: ');
      print(client.connectionStatus);

      client.subscribe('xxx', MqttQos.atLeastOnce);
    } catch (e) {
      print('client exception - $e');
      client.disconnect();
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
  void readData(StreamController controller) async {
    // TODO: implement readData
    client.updates!.listen((event) async {
      final recMess = event[0].payload as MqttPublishMessage;

      final tag =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      Map<String, dynamic> data = Map<String, dynamic>();
      data.addAll({"TAG": tag});

      if (willSave) {
        var response = await _httpService.post(
            "192.168.15.14:3000", "/api/v1/register", data);
        if (response == "") {
          error = true;
        } else {
          error = false;
        }
      }

      controller.add(tag);
    });
  }

  @override
  void sendData() {
    // TODO: implement sendData
  }
}
