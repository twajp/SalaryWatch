import 'package:flutter/material.dart';
import 'package:salarywatch/save_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});
  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _wageController;

  int hourlyWage = 0;
  Object? args; //argsの受け取り用

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _wageController.dispose();
    super.dispose();
  }

  void _saveSettings() async {
    // 入力された時給を取得
    final newHourlyWage = int.parse(_wageController.text);
    // 時給をストレージに保存
    await saveHourlyWage(newHourlyWage);
    // Navigator.pop()で戻る際に新しい時給を渡す
    Navigator.pop(context, newHourlyWage);
  }

  @override
  Widget build(BuildContext context) {
    // argumentsを受け取る --->
    // ※setStateの度にbuildが呼ばれるので初回(asrgがnull)の時だけ受け取る
    if (args == null) {
      args = ModalRoute.of(context)!.settings.arguments;
      setState(() {
        hourlyWage = args as int; //Object型なので型を指定する
      });
    }
    // 初期値として現在の時給を設定
    _wageController = TextEditingController(text: hourlyWage.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
