import 'package:flutter/material.dart';
import 'package:widget_test_practice/fifa_youth_tools/main.dart';

class AddEditPlayerScreen extends StatefulWidget {
  const AddEditPlayerScreen({Key? key, this.player}) : super(key: key);

  final PlayerModel? player;

  @override
  State<AddEditPlayerScreen> createState() => _AddEditPlayerScreenState();
}

class _AddEditPlayerScreenState extends State<AddEditPlayerScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _positionCtrl = TextEditingController();
  final TextEditingController _minPotCtrl = TextEditingController();
  final TextEditingController _maxPotCtrl = TextEditingController();
  bool sold = false;

  @override
  void initState() {
    super.initState();
    sold = widget.player?.sold ?? false;
    _nameCtrl.text = widget.player?.name ?? '';
    _positionCtrl.text = widget.player?.position ?? '';
    _minPotCtrl.text = widget.player?.minPotential.toString() ?? '0';
    _maxPotCtrl.text = widget.player?.maxPotential.toString() ?? '100';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.player == null ? 'Add Player' : 'Edit Player'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Name'),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _positionCtrl,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Position'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Sold'),
                      Checkbox(
                        value: sold,
                        onChanged: (value) {
                          setState(() {
                            sold = value!;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: _minPotCtrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Min Potential'),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: _maxPotCtrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Max Potential'),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                if (validateInput()) {
                  int id = 0;
                  if (fakePlayers.isNotEmpty) {
                    id = int.tryParse(fakePlayers.last.id) ?? 0 + 1;
                  }
                  fakePlayers.add(
                    PlayerModel(
                      id: id.toString(),
                      position: _positionCtrl.text,
                      name: _nameCtrl.text,
                      minPotential: int.tryParse(_minPotCtrl.text) ?? 0,
                      maxPotential: int.tryParse(_maxPotCtrl.text) ?? 0,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('SAVE'),
            )
          ],
        ),
      ),
    );
  }

  bool validateInput() {
    return _nameCtrl.text.trim().isNotEmpty &&
        _positionCtrl.text.trim().isNotEmpty &&
        _minPotCtrl.text.trim().isNotEmpty &&
        _maxPotCtrl.text.trim().isNotEmpty;
  }
}
