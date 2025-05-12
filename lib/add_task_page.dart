import 'package:flutter/material.dart';
import 'home_page.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _controller = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveTask() {
    if (_controller.text.trim().isEmpty) return;

    final newTodo = Todo(
      title: _controller.text.trim(),
      deadline: _selectedDate,
    );

    Navigator.pop(context, newTodo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Tugas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Nama Tugas'),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'Tidak ada tenggat waktu'
                        : 'Tenggat: ${_selectedDate!.toString().split(' ')[0]}',
                  ),
                ),
                TextButton(
                  onPressed: _pickDate,
                  child: const Text('Pilih Tanggal'),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _saveTask,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
