import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _institutionController = TextEditingController();
  final _degreeController = TextEditingController();
  final _fieldController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _selectDate({required bool isStart}) async {
    final initialDate = (isStart ? _startDate : _endDate) ?? DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      helpText: isStart ? 'Pilih tanggal mulai' : 'Pilih tanggal selesai',
    );
    if (selected != null) {
      setState(() {
        if (isStart) {
          _startDate = selected;
          if (_endDate != null && _endDate!.isBefore(selected)) _endDate = null;
        } else {
          _endDate = selected;
        }
      });
    }
  }

  void _showSummary() {
    if (!_formKey.currentState!.validate()) return;
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edukasi berhasil disimpan'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Institusi: ${_institutionController.text.trim()}'),
              Text('Gelar: ${_degreeController.text.trim()}'),
              Text('Bidang studi: ${_fieldController.text.trim()}'),
              Text('Tanggal mulai: ${_formatDate(_startDate)}'),
              Text('Tanggal selesai: ${_formatDate(_endDate)}'),
              if (_notesController.text.trim().isNotEmpty)
                Text('Catatan: ${_notesController.text.trim()}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _institutionController.dispose();
    _degreeController.dispose();
    _fieldController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Edukasi'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Informasi Pendidikan', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                const Text('Isi riwayat pendidikan yang ingin ditambahkan ke portofolio.'),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _institutionController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(labelText: 'Nama institusi', border: OutlineInputBorder(), prefixIcon: Icon(Icons.account_balance)),
                  validator: (value) => value == null || value.trim().isEmpty ? 'Nama institusi wajib diisi.' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _degreeController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(labelText: 'Gelar / jenjang', hintText: 'Contoh: S1, SMA, Bootcamp', border: OutlineInputBorder(), prefixIcon: Icon(Icons.school)),
                  validator: (value) => value == null || value.trim().isEmpty ? 'Gelar atau jenjang wajib diisi.' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _fieldController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(labelText: 'Program studi', border: OutlineInputBorder(), prefixIcon: Icon(Icons.menu_book)),
                  validator: (value) => value == null || value.trim().isEmpty ? 'Program studi wajib diisi.' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  readOnly: true,
                  onTap: () => _selectDate(isStart: true),
                  decoration: InputDecoration(labelText: 'Tanggal mulai', hintText: 'Pilih tanggal mulai', border: const OutlineInputBorder(), prefixIcon: const Icon(Icons.calendar_today), suffixIcon: _startDate == null ? null : IconButton(icon: const Icon(Icons.clear), onPressed: () => setState(() => _startDate = null))),
                  key: ValueKey('start-date-${_startDate?.millisecondsSinceEpoch}'),
                  initialValue: _formatDate(_startDate),
                  validator: (_) => _startDate == null ? 'Tanggal mulai wajib dipilih.' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  readOnly: true,
                  onTap: () => _selectDate(isStart: false),
                  decoration: InputDecoration(labelText: 'Tanggal selesai', hintText: 'Pilih tanggal selesai', border: const OutlineInputBorder(), prefixIcon: const Icon(Icons.event_available), suffixIcon: _endDate == null ? null : IconButton(icon: const Icon(Icons.clear), onPressed: () => setState(() => _endDate = null))),
                  key: ValueKey('end-date-${_endDate?.millisecondsSinceEpoch}'),
                  initialValue: _formatDate(_endDate),
                  validator: (_) {
                    if (_endDate == null) return 'Tanggal selesai wajib dipilih.';
                    if (_startDate != null && _endDate!.isBefore(_startDate!)) return 'Tanggal selesai harus setelah tanggal mulai.';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _notesController,
                  minLines: 2,
                  maxLines: 4,
                  decoration: const InputDecoration(labelText: 'Catatan (opsional)', border: OutlineInputBorder(), alignLabelWithHint: true),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: _showSummary,
                  icon: const Icon(Icons.save_outlined),
                  label: const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Simpan')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



