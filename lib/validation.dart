import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Validation',
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
      ],
      home: Scaffold(
        appBar: AppBar(title: Text('Form Validasi Lengkap')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RegistrationForm(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  void _submit() {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState!.value;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Form berhasil divalidasi!")),
      );
      print("Data terkirim: $formData");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        children: [
          FormBuilderTextField(
            name: 'name',
            decoration: InputDecoration(labelText: 'Nama Lengkap'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Nama wajib diisi'),
              FormBuilderValidators.minLength(3,
                  errorText: 'Nama terlalu pendek'),
            ]),
          ),
          SizedBox(height: 16),
          FormBuilderTextField(
            name: 'email',
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Email wajib diisi'),
              FormBuilderValidators.email(errorText: 'Email tidak valid'),
            ]),
          ),
          SizedBox(height: 16),
          FormBuilderTextField(
            name: 'password',
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Password wajib diisi'),
              FormBuilderValidators.minLength(8,
                  errorText: 'Minimal 8 karakter'),
              FormBuilderValidators.match(
                RegExp(r'(?=.*[A-Za-z])(?=.*\d)'),
                errorText: 'Harus kombinasi huruf & angka',
              ),
            ]),
          ),
          SizedBox(height: 16),
          FormBuilderTextField(
            name: 'confirm_password',
            obscureText: _obscureConfirm,
            decoration: InputDecoration(
              labelText: 'Konfirmasi Password',
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirm = !_obscureConfirm;
                  });
                },
              ),
            ),
            validator: (value) {
              final password =
                  _formKey.currentState?.fields['password']?.value ?? '';
              if (value == null || value.isEmpty) {
                return 'Konfirmasi password wajib diisi';
              }
              if (value != password) {
                return 'Password tidak cocok';
              }
              return null;
            },
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submit,
            child: Text('Daftar'),
          ),
        ],
      ),
    );
  }
}
