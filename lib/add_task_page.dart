import 'package:flutter/material.dart';
import 'home_page.dart';

class AddTaskPage extends StatefulWidget {
  final Todo? todo;
  const AddTaskPage({Key? key, this.todo}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late TextEditingController _titleController;
  DateTime? _deadline;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo?.title ?? '');
    _deadline = widget.todo?.deadline;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickDeadline() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _deadline ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (pickedDate != null) {
      setState(() {
        _deadline = pickedDate;
      });
    }
  }

  void _save() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul tugas tidak boleh kosong')),
      );
      return;
    }
    final newTodo = Todo(
      title: title,
      isDone: widget.todo?.isDone ?? false,
      deadline: _deadline,
    );
    Navigator.pop(context, newTodo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo == null ? 'Tambah Tugas' : 'Edit Tugas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _save,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Judul Tugas'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(_deadline == null
                    ? 'Pilih deadline'
                    : 'Deadline: ${_deadline!.toLocal().toString().split(' ')[0]}'),
                const Spacer(),
                ElevatedButton(
                  onPressed: _pickDeadline,
                  child: const Text('Pilih Tanggal'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
