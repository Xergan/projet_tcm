import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:projet_tcm/services/notif_service.dart';

class MqttService {
  static final MqttService _instance = MqttService._internal();
  factory MqttService() => _instance;
  MqttService._internal();

  late MqttServerClient client;
  final String server = '51.44.23.21';
  final int port = 8883;
  final String clientId = 'flutter_client_${DateTime.now().millisecondsSinceEpoch}';
  bool isConnected = false;

  Future<bool> initialize() async {
    client = MqttServerClient(server, clientId);
    client.port = port;
    client.secure = true;
    
    SecurityContext context = SecurityContext.defaultContext;
    try {
      context.setTrustedCertificates('assets/mosquitto.crt');
    } catch (e) {
      debugPrint('Erreur lors du chargement du certificat: $e');
      client.onBadCertificate = (dynamic certificate) => true;
    }

    // Configuration des callbacks
    client.logging(on: true);
    client.onConnected = _onConnected;
    client.onDisconnected = _onDisconnected;
    client.onSubscribed = _onSubscribed;
    client.pongCallback = _pong;

    return true;
  }

  Future<bool> connect({required String username, required String password}) async {
    if (isConnected) return true;
    
    try {
      final connMess = MqttConnectMessage()
          .authenticateAs(username, password)
          .withClientIdentifier(clientId)
          .startClean()
          .withWillQos(MqttQos.atLeastOnce);
      
      client.connectionMessage = connMess;
      
      await client.connect();
      return isConnected;
    } catch (e) {
      debugPrint('Erreur de connexion MQTT: $e');
      client.disconnect();
      return false;
    }
  }

  void subscribe(String topic, {MqttQos qos = MqttQos.atLeastOnce}) {
    if (isConnected) {
      client.subscribe(topic, qos);
      debugPrint('Abonnement au topic: $topic');
    }
  }

  void publish(String topic, String message, {MqttQos qos = MqttQos.atLeastOnce}) {
    if (isConnected) {
      final builder = MqttClientPayloadBuilder();
      builder.addString(message);
      client.publishMessage(topic, qos, builder.payload!);
      debugPrint('Message publié sur le topic: $topic');
    }
  }

  void listenToUpdates() {
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
      for (var message in messages) {
        final MqttPublishMessage recMess = message.payload as MqttPublishMessage;
        final String topic = message.topic;
        final String payload = 
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        
        debugPrint('Message reçu sur topic: $topic');
        debugPrint('Contenu du message: $payload');
        
        if (topic == 'test/topic') {
          NotifService().showNotification(
            title: 'Topic de Test',
            body: payload,
          );
        }
      }
    });
  }

  void disconnect() {
    client.disconnect();
  }

  void _onConnected() {
    debugPrint('MQTT Client connecté');
    isConnected = true;
  }

  void _onDisconnected() {
    debugPrint('MQTT Client déconnecté');
    isConnected = false;
  }

  void _onSubscribed(String topic) {
    debugPrint('Abonnement confirmé pour le topic: $topic');
  }

  void _pong() {
    debugPrint('Ping response réception');
  }
}