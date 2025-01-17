import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'save_settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});
  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _wageController;

  double hourlyWage = 0;
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
    final newHourlyWage = double.parse(_wageController.text);
    // 時給をストレージに保存
    await saveHourlyWage(newHourlyWage as int);
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
        hourlyWage = args as double; //Object型なので型を指定する
      });
    }
    // 初期値として現在の時給を設定
    _wageController = TextEditingController(text: hourlyWage.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Common'),
            tiles: [
              // tiles: <SettingsTile> [
              // SettingsTile(
              //     title: const Text('時給'),
              //     // subtitle: 'English',
              //     leading: const Icon(Icons.currency_yen),
              //     // trailing: const Icon(Icons.currency_yen),
              //     trailing: Expanded(
              //       child: Expanded(
              //         child: TextField(
              //           controller: _wageController,
              //           keyboardType: TextInputType.number,
              //         ),
              //       ),
              //     ),
              //     description: const Text('時給を入力')
              //     // onPressed: _saveSettings,
              //     ),
              CustomSettingsTile(
                child: Container(
                  // color: Color(0xFFEFEFF4),
                  padding: const EdgeInsetsDirectional.only(start: 22, top: 14, bottom: 14, end: 22),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      const Icon(Icons.currency_yen),
                      Container(
                        padding: const EdgeInsetsDirectional.only(start: 14, top: 14, bottom: 14, end: 22),
                        child: const Text('時給'),
                      ),
                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.right,
                          controller: _wageController,
                          keyboardType: TextInputType.number,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              CustomSettingsTile(
                child: ElevatedButton(
                  onPressed: _saveSettings,
                  child: const Text('保存'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
