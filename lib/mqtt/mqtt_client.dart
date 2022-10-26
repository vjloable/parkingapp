import 'dart:io';
import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;

class WrapperMQTT{
  String broker           = '4f65d161a8d94f0a89bf377bbe7164a4.s1.eu.hivemq.cloud';          // Change
  int port                = 8883;                                                           // Change
  String username         = 'parksysapp';                                                   // Change
  String passwd           = 'Psa12345678';                                                  // Change
  String clientIdentifier = 'android';                                                      // Change

  late mqtt.MqttClient client;
  late mqtt.MqttConnectionState connectionState;
  late StreamSubscription subscription;

  //double _temp = 20;                                                                      // Change

  void _subscribeToTopic(String topic) {
    if (connectionState == mqtt.MqttConnectionState.connected) {
      print('[MQTT client] Subscribing to ${topic.trim()}');
      client.subscribe(topic, mqtt.MqttQos.exactlyOnce);
    }
  }

  void _connect() async {
    client = mqtt.MqttClient(broker, '');
    client.port = port;
    client.logging(on: true);
    client.keepAlivePeriod = 30;
    client.onDisconnected = _onDisconnected;

    final mqtt.MqttConnectMessage connMess = mqtt.MqttConnectMessage()
        .withClientIdentifier(clientIdentifier)
        .startClean() // Non persistent session for testing
        .withWillQos(mqtt.MqttQos.atMostOnce);
    print('[MQTT client] MQTT client connecting....');
    client.connectionMessage = connMess;

    try {
      await client.connect(username, passwd);
    } catch (e) {
      print(e);
      _disconnect();
    }

    if (client.connectionStatus!.state == mqtt.MqttConnectionState.connected) {
      print('[MQTT client] connected');
      /*
      setState(() {
        connectionState = client.connectionStatus;
      });
      */
    } else {
      print('[MQTT client] ERROR: MQTT client connection failed - '
          'disconnecting, state is ${client.connectionStatus!.state}');
      _disconnect();
    }
    subscription = client.updates!.listen(_onMessage);

    _subscribeToTopic("temp");
  }

  void _disconnect() {
    print('[MQTT client] _disconnect()');
    client.disconnect();
    _onDisconnected();
  }

  void _onDisconnected() {
    print('[MQTT client] _onDisconnected');
    /*
    setState(() {
      //topics.clear();
      connectionState = client.connectionState;
      client = null;
      subscription.cancel();
      subscription = null;
    });
    */
    print('[MQTT client] MQTT client disconnected');
  }

  void _onMessage(List<mqtt.MqttReceivedMessage> event) {
    print(event.length);
    final mqtt.MqttPublishMessage recMess =
    event[0].payload as mqtt.MqttPublishMessage;
    final String message =
    mqtt.MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    print('[MQTT client] MQTT message: topic is <${event[0].topic}>, '
        'payload is <-- $message -->');
    print(client.connectionState);
    print("[MQTT client] message with topic: ${event[0].topic}");
    print("[MQTT client] message with message: $message");

    /*
    setState(() {
      _temp = double.parse(message);
    });
    */
  }
}
