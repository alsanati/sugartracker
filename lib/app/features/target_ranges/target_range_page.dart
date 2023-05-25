import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SugarLevelTargetPage extends StatefulWidget {
  const SugarLevelTargetPage({Key? key}) : super(key: key);

  @override
  _SugarLevelTargetPageState createState() => _SugarLevelTargetPageState();
}

class _SugarLevelTargetPageState extends State<SugarLevelTargetPage> {
  double _minTarget = 80;
  double _maxTarget = 180;
  double _avgTarget = 130;

  @override
  void initState() {
    super.initState();
    _loadTargetRange();
  }

  _loadTargetRange() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _minTarget = (prefs.getDouble('minTarget') ?? 80);
      _maxTarget = (prefs.getDouble('maxTarget') ?? 180);
      _avgTarget =
          (prefs.getDouble('avgTarget') ?? ((_minTarget + _maxTarget) / 2));
    });
  }

  Future<bool> _saveTargetRange() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setDouble('minTarget', _minTarget) &&
        await prefs.setDouble('maxTarget', _maxTarget) &&
        await prefs.setDouble('avgTarget', _avgTarget);
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Target range saved successfully'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Sugar Level Targets'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  title: Text(
                    'Current target range',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  subtitle: Text(
                      'Min: $_minTarget, Max: $_maxTarget, Avg: $_avgTarget'),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Set new target range.',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Min',
                          labelStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _minTarget = double.tryParse(value) ?? _minTarget;
                            _avgTarget = (_minTarget + _maxTarget) / 2;
                          });
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Max',
                          labelStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _maxTarget = double.tryParse(value) ?? _maxTarget;
                            _avgTarget = (_minTarget + _maxTarget) / 2;
                          });
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                            labelText: 'Avg',
                            labelStyle: Theme.of(context).textTheme.labelLarge),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _maxTarget = double.tryParse(value) ?? _maxTarget;
                            _avgTarget = (_minTarget + _maxTarget) / 2;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.tertiary)),
                        onPressed: () async {
                          bool saveSuccess = await _saveTargetRange();
                          if (saveSuccess) {
                            _showSnackBar();
                          }
                        },
                        child: Text('Set Target Range',
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onTertiary)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
