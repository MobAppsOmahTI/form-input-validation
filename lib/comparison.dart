import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ComparisonScreen(),
    );
  }
}

class ComparisonScreen extends StatefulWidget {
  @override
  _ComparisonScreenState createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  final _formKey = GlobalKey<FormState>(); //validasi form
  final _textFieldController =
      TextEditingController(); //controller buat TextField
  final _textFormFieldController =
      TextEditingController(); //controller buat TextFormField

  final String _name = '';
  String _email = '';

  void resetFields() {
    _formKey.currentState?.reset();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data direset'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Form valid'),
          duration: const Duration(seconds: 1),
        ),
      );
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data disimpan: Nama: $_name, Email: $_email'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TextField vs TextFormField')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("TextField (tanpa validasi):"),
            const SizedBox(height: 10),
            TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(
                labelText: 'Nama (TextField)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text("TextFormField (dengan validasi):"),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _textFormFieldController,
                    decoration: const InputDecoration(
                      labelText: 'Email (TextFormField)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong';
                      } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Format email tidak valid';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value ?? '';
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: submitForm,
                  child: const Text("Simpan Data"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: resetFields,
                  child: const Text("Reset"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
