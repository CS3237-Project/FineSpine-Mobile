import 'dart:convert';
import 'dart:io';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:flutter/services.dart' show Uint8List;

class MqttClientManager {
  static MqttServerClient client =
  MqttServerClient.withPort('10.0.2.2', 'mobile_client', 1883);

  static Future<int> connect() async {
    client.logging(on: true);
    client.keepAlivePeriod = 60;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;

    final connMessage =
    MqttConnectMessage().startClean().withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      print('MQTTClient::Client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      print('MQTTClient::Socket exception - $e');
      client.disconnect();
    }

    return 0;
  }

  static void disconnect(){
    client.disconnect();
  }

  static void subscribe(String topic) {
    client.subscribe(topic, MqttQos.atLeastOnce);
  }

  static void onConnected() {
    print('MQTTClient::Connected');
  }

  static void onDisconnected() {
    print('MQTTClient::Disconnected');
  }

  static void onSubscribed(String topic) {
    print('MQTTClient::Subscribed to topic: $topic');
  }

  static void pong() {
    print('MQTTClient::Ping response received');
  }

  static void publishMessage(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }

  static Future<void> sendImage(String fileLocalPath, String topic)  async {
    Directory folder = Directory(fileLocalPath);
    folder.list().forEach((element) async {
      File imageFile = File(element.path); //convert Path to File
      Uint8List imageBytes = await imageFile.readAsBytes(); //convert to bytes
      String base64string = base64.encode(imageBytes);
      publishMessage(topic, base64string);
      await imageFile.delete(); //delete file after publishing
    });
  }

  Stream<List<MqttReceivedMessage<MqttMessage>>>? getMessagesStream() {
    return client.updates;
  }
}