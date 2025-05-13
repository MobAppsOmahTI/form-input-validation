import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Seminar',
      debugShowCheckedModeBanner: false,
      home: SeminarFormPage(),
    );
  }
}

class SeminarFormPage extends StatefulWidget {
  @override
  _SeminarFormPageState createState() => _SeminarFormPageState();
}

class _SeminarFormPageState extends State<SeminarFormPage> {
  final _formKey = GlobalKey<FormBuilderState>(); //kunci untuk form builder

  void _submit() {
    if (_formKey.currentState!.saveAndValidate()) {
      final data = _formKey.currentState!.value;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data berhasil dikirim: $data")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Pendaftaran Seminar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey, //kunci untuk form builder
          child: ListView(
            children: [
              FormBuilderTextField(
                name: 'full_name',
                decoration: InputDecoration(labelText: 'Nama Lengkap'),
                validator: FormBuilderValidators.required(
                    errorText: 'Nama wajib diisi'),
              ),
              SizedBox(height: 16),
              FormBuilderDropdown(
                name: 'education_level',
                decoration: InputDecoration(labelText: 'Jenjang Pendidikan'),
                items: ['SMA', 'Diploma', 'Sarjana', 'Magister', 'Doktor']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                validator: FormBuilderValidators.required(
                    errorText: 'Wajib pilih jenjang'),
              ),
              SizedBox(height: 16),
              FormBuilderDateTimePicker(
                name: 'birth_date',
                decoration: InputDecoration(labelText: 'Tanggal Lahir'),
                inputType: InputType.date,
                validator: FormBuilderValidators.required(
                    errorText: 'Tanggal wajib diisi'),
              ),
              SizedBox(height: 16),
              FormBuilderCheckbox(
                name: 'agree_terms',
                initialValue: false,
                title: Text("Saya setuju dengan syarat dan ketentuan"),
                validator: FormBuilderValidators.equal(true,
                    errorText: 'Wajib menyetujui'),
              ),
              SizedBox(height: 16),
              FormBuilderSwitch(
                name: 'join_whatsapp_group',
                title: Text('Gabung grup WhatsApp peserta?'),
                validator:
                    FormBuilderValidators.required(errorText: 'Wajib memilih'),
              ),
              SizedBox(height: 16),
              FormBuilderSlider(
                name: 'expectation_level',
                min: 0,
                max: 10,
                initialValue: 5,
                divisions: 10,
                decoration: InputDecoration(
                    labelText:
                        'Seberapa besar ekspektasimu terhadap seminar ini?'),
                validator: FormBuilderValidators.required(
                    errorText: 'Isi skala ekspektasi'),
              ),
              SizedBox(height: 16),
              FormBuilderFilePicker(
                name: 'photo',
                decoration:
                    InputDecoration(labelText: 'Upload foto bukti pembayaran'),
                maxFiles: 1,
                typeSelectors: [
                  TypeSelector(
                    type: FileType.any,
                    selector: Text('Select any file'),
                  ),
                ],
                allowMultiple: false,
                validator: FormBuilderValidators.required(
                    errorText: 'Wajib unggah bukti pembayaran'),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: Text("Daftar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
