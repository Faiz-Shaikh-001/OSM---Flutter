import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:osm/core/services/isar_service.dart';
import '../../../orders/data/models/store_model.dart';

class InventorySettingsScreen extends StatefulWidget {
  final int storeId; // We now require a store ID to know which settings to load

  const InventorySettingsScreen({
    super.key,
    required this.storeId,
  });

  @override
  State<InventorySettingsScreen> createState() => _InventorySettingsScreenState();
}

class _InventorySettingsScreenState extends State<InventorySettingsScreen> {
  final IsarService isarService = IsarService();
  
  // State variables
  int _stockThreshold = 5;
  double _taxRate = 0.0;
  double _discountRate = 0.0;
  String _invoiceFooterMessage = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStoreSettings();
  }

  Future<void> _loadStoreSettings() async {
    final isar = await isarService.db;
    final store = await isar.stores.get(widget.storeId);

    if (store != null && mounted) {
      setState(() {
        _stockThreshold = store.stockThreshold;
        _taxRate = store.taxRate;
        _discountRate = store.discountRate;
        _invoiceFooterMessage = store.invoiceFooterMessage;
        _isLoading = false;
      });
    }
  }

  // --- Generic Input Dialog ---
  Future<void> _showEditDialog({
    required String title,
    required String currentValue,
    String? suffixText,
    TextInputType inputType = const TextInputType.numberWithOptions(decimal: true),
    required Function(String) onSave,
  }) async {
    final controller = TextEditingController(text: currentValue);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          keyboardType: inputType,
          maxLines: inputType == TextInputType.multiline ? 3 : 1,
          decoration: InputDecoration(
            suffixText: suffixText,
            border: const OutlineInputBorder(),
            hintText: 'Enter value',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // --- Database Update Logic ---
  Future<void> _updateStore(Function(Store) updateAction) async {
    final isar = await isarService.db;
    final store = await isar.stores.get(widget.storeId);
    
    if (store != null) {
      await isar.writeTxn(() async {
        updateAction(store); 
        await isar.stores.put(store); 
      });
    }
  }

  void _updateStockThreshold() {
    _showEditDialog(
      title: 'Set Stock Warning Threshold',
      currentValue: _stockThreshold.toString(),
      suffixText: 'units',
      inputType: TextInputType.number,
      onSave: (value) async {
        final int? newVal = int.tryParse(value);
        if (newVal != null) {
          await _updateStore((store) => store.stockThreshold = newVal);
          setState(() => _stockThreshold = newVal);
        }
      },
    );
  }

  void _updateTaxRate() {
    _showEditDialog(
      title: 'Set Default Tax Rate (GST)',
      currentValue: _taxRate.toString(),
      suffixText: '%',
      onSave: (value) async {
        final double? newVal = double.tryParse(value);
        if (newVal != null) {
          await _updateStore((store) => store.taxRate = newVal);
          setState(() => _taxRate = newVal);
        }
      },
    );
  }

  void _updateDiscountRate() {
    _showEditDialog(
      title: 'Set Default Discount Rate',
      currentValue: _discountRate.toString(),
      suffixText: '%',
      onSave: (value) async {
        final double? newVal = double.tryParse(value);
        if (newVal != null) {
          await _updateStore((store) => store.discountRate = newVal);
          setState(() => _discountRate = newVal);
        }
      },
    );
  }

  void _updateFooterMessage() {
    _showEditDialog(
      title: 'Invoice Footer Message',
      currentValue: _invoiceFooterMessage,
      inputType: TextInputType.multiline,
      onSave: (value) async {
        await _updateStore((store) => store.invoiceFooterMessage = value);
        setState(() => _invoiceFooterMessage = value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Configuration'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSettingsItem(
            Icons.production_quantity_limits_outlined,
            'Stock Warning Threshold',
            subtitle: 'Alert when quantity is less than $_stockThreshold',
            onTap: _updateStockThreshold,
          ),
          const Divider(),
          _buildSettingsItem(
            Icons.price_change_outlined,
            'Default Tax Rate (GST)',
            subtitle: 'Current: $_taxRate%',
            onTap: _updateTaxRate,
          ),
          const Divider(),
          _buildSettingsItem(
            Icons.percent_outlined,
            'Default Discount Rate',
            subtitle: 'Current: $_discountRate%',
            onTap: _updateDiscountRate,
          ),
          const Divider(),
          _buildSettingsItem(
            Icons.edit_note_outlined,
            'Invoice Footer Message',
            subtitle: _invoiceFooterMessage.isEmpty ? 'Not set' : _invoiceFooterMessage,
            onTap: _updateFooterMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    IconData icon,
    String title, {
    VoidCallback? onTap,
    String? subtitle,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withOpacity(0.4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: theme.colorScheme.primary),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}