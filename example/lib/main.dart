import 'package:flutter/material.dart';
import 'package:debounce_tap/debounce_tap.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debounce Tap Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int _inkwellCount = 0;
  int _gestureCount = 0;
  int _iconCount = 0;
  int _textButtonCount = 0;
  int _blockedCount = 0;
  String _lastBlockedMessage = '';

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debounce Tap Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Engellenen Tıklama: $_blockedCount',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_lastBlockedMessage.isNotEmpty)
                      Text(
                        _lastBlockedMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // InkWell Demo
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'InkWell Tıklama: $_inkwellCount',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Debounce.inkwell(
                      onTap: () {
                        setState(() {
                          _inkwellCount++;
                        });
                        _showSnackBar('InkWell tıklandı! (500ms debounce)');
                      },
                      onTapBlocked: (remainingMs) {
                        setState(() {
                          _blockedCount++;
                          _lastBlockedMessage =
                              'InkWell engellendi! Kalan süre: ${remainingMs}ms';
                        });
                      },
                      debounceDuration: const Duration(milliseconds: 5000),
                      borderRadius: BorderRadius.circular(8),
                      splashColor: Colors.blue,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: const Text(
                          'InkWell ile Debounce (500ms)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // GestureDetector Demo
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Gesture Tıklama: $_gestureCount',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Debounce.gestureDetector(
                      onTap: () {
                        setState(() {
                          _gestureCount++;
                        });
                        _showSnackBar(
                          'GestureDetector tıklandı! (300ms debounce)',
                        );
                      },
                      debounceDuration: const Duration(milliseconds: 300),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green.shade200),
                        ),
                        child: const Text(
                          'GestureDetector ile Debounce (300ms)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // IconButton Demo
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Icon Button Tıklama: $_iconCount',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Debounce.iconButton(
                      onTap: () {
                        setState(() {
                          _iconCount++;
                        });
                        _showSnackBar('IconButton tıklandı! (200ms debounce)');
                      },
                      icon: const Icon(Icons.favorite),
                      debounceDuration: const Duration(milliseconds: 200),
                      color: Colors.red,
                      tooltip: 'Favori Ekle',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // TextButton Demo
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Text Button Tıklama: $_textButtonCount',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Debounce.textButton(
                      onTap: () {
                        setState(() {
                          _textButtonCount++;
                        });
                        _showSnackBar('TextButton tıklandı! (100ms debounce)');
                      },
                      debounceDuration: const Duration(milliseconds: 100),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.orange.shade200),
                        ),
                        child: const Text(
                          'TextButton ile Debounce (100ms)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Reset Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _inkwellCount = 0;
                  _gestureCount = 0;
                  _iconCount = 0;
                  _textButtonCount = 0;
                  _blockedCount = 0;
                  _lastBlockedMessage = '';
                });
                _showSnackBar('Sayaçlar sıfırlandı!');
              },
              child: const Text('Sayaçları Sıfırla'),
            ),
          ],
        ),
      ),
    );
  }
}
