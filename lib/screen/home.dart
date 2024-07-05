import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List <dynamic> sensors = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest API Call'),
      ),
      body: ListView.builder(
        itemCount: sensors.length,
        itemBuilder: (context, index) {
          final sensor = sensors[index];
          final entity_id = sensor['entity_id'];
          final state = sensor['state'];
          return ListTile(
            title: Text(entity_id),
            subtitle: Text(state),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchSensors,
      ),
    );
  }

  void fetchSensors() async {
    print('fetchSensors called !');
    const url = 'http://192.168.43.76:8123/api/states';
    final uri = Uri.parse(url);
    const String accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiIzMzA4NGEwMWMyM2M0MGZmOTRlMmJlMDIzMGQ5ZjdmMSIsImlhdCI6MTcyMDE3NzY1NywiZXhwIjoyMDM1NTM3NjU3fQ.ZGYQuyqYmlt_OJpUdYEkEL9aMhZA-zGZGXj1hFvW_zc';
    const headers = {
      'Authorization': 'Bearer $accessToken',
    };
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      setState(() {
        // Mise à jour de l'état du widget ici, par exemple en stockant les données récupérées
      });

      print('fetchSensors completed !');
    }
  }
}
