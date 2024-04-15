import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.currentHourlyWage});

  final int currentHourlyWage;

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  late TextEditingController _wageController;

  @override
  void initState() {
    super.initState();
    // 初期値として現在の時給を設定
    _wageController = TextEditingController(
        text: widget.currentHourlyWage.toString());
  }

  @override
  void dispose() {
    _wageController.dispose();
    super.dispose();
  }

  void _saveSettings() {
    // 入力された時給を取得
    final newHourlyWage = int.parse(_wageController.text);
    // `Navigator.pop()`で戻る際に新しい時給を渡します
    Navigator.pop(context, newHourlyWage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _wageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '時給',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveSettings,
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}
