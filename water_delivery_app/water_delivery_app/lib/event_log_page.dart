import 'package:flutter/material.dart';
import 'event_logger.dart';

class EventLogPage extends StatefulWidget {
  const EventLogPage({super.key});

  @override
  State<EventLogPage> createState() => _EventLogPageState();
}

class _EventLogPageState extends State<EventLogPage> {
  @override
  Widget build(BuildContext context) {
    final logs = EventLogger.getLogs();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Logs"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: "Clear Logs",
            onPressed: () {
              EventLogger.clear();

              setState(() {});

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Event logs cleared"),
                ),
              );
            },
          )
        ],
      ),

      body: logs.isEmpty
          ? const Center(
              child: Text(
                "No events recorded yet.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.history,
                      color: Colors.blue,
                    ),
                    title: Text(logs[index]),
                  ),
                );
              },
            ),
    );
  }
}