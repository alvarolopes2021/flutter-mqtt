import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mqtt/services/impl/mqtt_service_impl.dart';
import 'package:flutter_mqtt/services/imqtt_service.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePage();
  }
}

class _MyHomePage extends State<MyHomePage> {
  final IMqttService _clientMqtt = MqttServiceImpl();
  StreamController controller = StreamController<String>.broadcast();

  @override
  void initState() {
    super.initState();
    _clientMqtt.connect();
    _clientMqtt.readData(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        title: Text('Status'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _clientMqtt.willSave = true;
          await showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: const AlertDialog(
                    title: Text('Leia uma tag'),
                    content: Center(
                      child: Text('ACIONE A TAG'),
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: controller.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('nada');
                }
                if (_clientMqtt.willSave) {
                  _clientMqtt.willSave = false;
                  Navigator.pop(context);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_clientMqtt.error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.error, color: Colors.red),
                              Text(
                                'Erro',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.check, color: Colors.green),
                              Text(
                                'Sucesso',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  });
                }
                return Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Card(
                    elevation: 4,
                    child: Row(
                      children: [
                        Icon(
                          Icons.pets,
                          size: 80,
                          color: Colors.red,
                        ),
                        Text(
                          'Sven',
                          style: TextStyle(fontSize: 25),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
