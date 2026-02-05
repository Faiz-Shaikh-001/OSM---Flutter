import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:osm/features/customer/presentation/bloc/customer_details/customer_details_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// Domain Imports
import 'package:osm/core/value_objects/money.dart';
import 'package:osm/features/orders/domain/entities/order.dart';
import 'package:osm/features/orders/domain/entities/order_enums.dart';
import 'package:osm/features/orders/domain/entities/order_item.dart';
import 'package:osm/features/orders/domain/entities/order_item_type.dart';
import 'package:osm/features/orders/domain/entities/payment.dart';
import 'package:osm/features/orders/domain/entities/payment_enums.dart';
import 'package:osm/features/orders/domain/repositories/order_repository.dart';

// Customer Domain & Bloc
import 'package:osm/features/customer/domain/entities/customer.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Order order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late Order _currentOrder;

  @override
  void initState() {
    super.initState();
    _currentOrder = widget.order;
    // Trigger the global Bloc to load this customer's details
    context.read<CustomerDetailsBloc>().add(
      LoadCustomerDetails(_currentOrder.customerId),
    );
  }

  /// Re-fetches the order from the repo to update the UI (e.g. after payment)
  Future<void> _refreshOrder() async {
    final repo = context.read<OrderRepository>();
    final result = await repo.getById(_currentOrder.id);
    result.fold(
      (failure) => null, // Handle error if needed
      (updatedOrder) {
        setState(() {
          _currentOrder = updatedOrder;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(title: const Text("Order Details"), centerTitle: true),
      body: BlocBuilder<CustomerDetailsBloc, CustomerDetailsState>(
        builder: (context, state) {
          // Determine the customer object to show
          Customer? customer;
          bool isLoadingCustomer = true;

          if (state is CustomerDetailsLoaded) {
            customer = state.details.customer;
            isLoadingCustomer = false;
          } else if (state is CustomerDetailsError) {
            isLoadingCustomer = false; // Stop loading, show basic info
          }

          return Stack(
            children: [
              // Main Content
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _StatusBanner(order: _currentOrder),
                          const SizedBox(height: 16),

                          // Customer Section
                          _CustomerSection(
                            order: _currentOrder,
                            customer: customer,
                            isLoading: isLoadingCustomer,
                          ),

                          const SizedBox(height: 16),
                          _ItemsSection(items: _currentOrder.items),
                          const SizedBox(height: 16),
                          _PaymentSummarySection(order: _currentOrder),
                          const SizedBox(height: 16),
                          _PaymentHistorySection(
                            payments: _currentOrder.payments,
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),

                  // Payment Bar
                  if (!_currentOrder.isFullyPaid)
                    _PayPendingBar(
                      pendingAmount: _currentOrder.pendingAmount,
                      onPayPressed: () => _showPaymentModal(context),
                    ),
                ],
              ),

              // Floating Print Button
              if (customer != null)
                Positioned(
                  top: 0,
                  right: 16,
                  child: SafeArea(
                    child: FloatingActionButton.small(
                      heroTag: "print_btn",
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      onPressed: () => _generatePdf(_currentOrder, customer!),
                      child: const Icon(Icons.print),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _showPaymentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: _AddPaymentSheet(
          order: _currentOrder,
          onPaymentSuccess: () {
            Navigator.pop(ctx);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Payment recorded successfully"),
                backgroundColor: Colors.green,
              ),
            );
            // Refresh local order state to show new balance
            _refreshOrder();
          },
        ),
      ),
    );
  }

  Future<void> _generatePdf(Order order, Customer customer) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text(
                  "Order Receipt #${order.id.value.substring(0, 8)}",
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "Date: ${DateFormat('yyyy-MM-dd').format(order.createdAt)}",
                  ),
                  pw.Text("Customer: ${customer.fullName}"),
                ],
              ),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.TableHelper.fromTextArray(
                headers: ["Item", "Qty", "Price", "Total"],
                data: order.items
                    .map(
                      (item) => [
                        item.productName,
                        item.quantity,
                        item.unitPrice.toString(),
                        item.total.toString(),
                      ],
                    )
                    .toList(),
              ),
              pw.Divider(),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text("Total: ${order.totalAmount.toString()}"),
                    pw.Text("Paid: ${order.paidAmount.toString()}"),
                    pw.Text(
                      "Balance Due: ${order.pendingAmount.toString()}",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }
}

// -----------------------------------------------------------------------------
// SUB-WIDGETS
// -----------------------------------------------------------------------------

class _CustomerSection extends StatelessWidget {
  final Order order;
  final Customer? customer;
  final bool isLoading;

  const _CustomerSection({
    required this.order,
    this.customer,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person_outline, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  "Customer Details",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),

            if (isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: LinearProgressIndicator(minHeight: 2),
              )
            else if (customer != null)
              Column(
                children: [
                  _buildRow("Name", customer!.fullName, isBold: true),
                  if (customer!.primaryPhoneNumber.isNotEmpty)
                    _buildRow("Phone", customer!.primaryPhoneNumber),
                  if (customer!.email?.isNotEmpty ?? false)
                    _buildRow("Email", customer!.email!),
                  if (customer!.city?.isNotEmpty ?? false)
                    _buildRow("City", customer!.city!),
                ],
              )
            else
              // Fallback if load failed or customer null
              _buildRow("Name", customer!.fullName, isBold: true),

            _buildRow(
              "Customer ID",
              order.customerId.value.length > 8
                  ? "${order.customerId.value.substring(0, 8)}..."
                  : order.customerId.value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBanner extends StatelessWidget {
  final Order order;
  const _StatusBanner({required this.order});

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;

    switch (order.status) {
      case OrderStatus.completed:
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      case OrderStatus.pendingPayment:
        color = Colors.orange;
        icon = Icons.pending;
        break;
      case OrderStatus.cancelled:
        color = Colors.red;
        icon = Icons.cancel;
        break;
      default:
        color = Colors.blue;
        icon = Icons.edit_note;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order Status: ${order.status.label}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 16,
                ),
              ),
              Text(
                "Created on ${DateFormat.yMMMd().format(order.createdAt)}",
                style: TextStyle(color: color.withOpacity(0.8), fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ItemsSection extends StatelessWidget {
  final List<OrderItem> items;
  const _ItemsSection({required this.items});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.shopping_bag_outlined, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  "Ordered Items",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  "${items.length} Items",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const Divider(height: 24),
            ...items.map((item) => _buildItemRow(context, item)),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(BuildContext context, OrderItem item) {
    final isLens = item.type == OrderItemType.lens;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isLens ? Icons.visibility : Icons.sell,
                  size: 20,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.productName,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Qty: ${item.quantity}  ×  ₹${item.unitPrice.toString()}",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    if (isLens) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "SPH: ${item.spherical ?? '-'} | CYL: ${item.cylindrical ?? '-'} | AXIS: ${item.axis ?? '-'}",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "₹${item.total.toString()}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class _PaymentSummarySection extends StatelessWidget {
  final Order order;
  const _PaymentSummarySection({required this.order});

  @override
  Widget build(BuildContext context) {
    double progress = 0;
    if (order.totalAmount.value > 0) {
      progress = (order.paidAmount.value / order.totalAmount.value).clamp(
        0.0,
        1.0,
      );
    }

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildRow(
              "Total Amount",
              "₹${order.totalAmount.toString()}",
              isBold: true,
            ),
            const SizedBox(height: 8),
            _buildRow(
              "Paid Amount",
              "- ₹${order.paidAmount.toString()}",
              color: Colors.green,
            ),
            const Divider(height: 24),
            _buildRow(
              "Balance Due",
              "₹${order.pendingAmount.toString()}",
              isBold: true,
              color: order.pendingAmount.value > 0 ? Colors.red : Colors.green,
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                color: progress == 1 ? Colors.green : Colors.orange,
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "${(progress * 100).toInt()}% Paid",
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
    String label,
    String value, {
    bool isBold = false,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _PaymentHistorySection extends StatelessWidget {
  final List<Payment> payments;
  const _PaymentHistorySection({required this.payments});

  @override
  Widget build(BuildContext context) {
    if (payments.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            "Payment History",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        const SizedBox(height: 8),
        ...payments.map(
          (p) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            elevation: 0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green[50],
                child: Icon(
                  _getMethodIcon(p.method),
                  color: Colors.green,
                  size: 20,
                ),
              ),
              title: Text(
                "₹${p.amountPaid.toString()}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              subtitle: Text(
                "${DateFormat.yMMMd().format(p.paymentDate)} • ${p.method.name.capitalize}",
              ),
              trailing: const Icon(
                Icons.check_circle,
                size: 16,
                color: Colors.green,
              ),
            ),
          ),
        ),
      ],
    );
  }

  IconData _getMethodIcon(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return Icons.money;
      case PaymentMethod.card:
        return Icons.credit_card;
      case PaymentMethod.upi:
        return Icons.qr_code;
      default:
        return Icons.payment;
    }
  }
}

class _PayPendingBar extends StatelessWidget {
  final Money pendingAmount;
  final VoidCallback onPayPressed;

  const _PayPendingBar({
    required this.pendingAmount,
    required this.onPayPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Pending Amount",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  "₹${pendingAmount.toString()}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: onPayPressed,
              icon: const Icon(Icons.payment),
              label: const Text("Pay Balance"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddPaymentSheet extends StatefulWidget {
  final Order order;
  final VoidCallback onPaymentSuccess;

  const _AddPaymentSheet({required this.order, required this.onPaymentSuccess});

  @override
  State<_AddPaymentSheet> createState() => _AddPaymentSheetState();
}

class _AddPaymentSheetState extends State<_AddPaymentSheet> {
  final _amountController = TextEditingController();
  PaymentMethod _selectedMethod = PaymentMethod.cash;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _amountController.text = widget.order.pendingAmount.value.toString();
  }

  void _submitPayment() async {
    final amountVal = double.tryParse(_amountController.text);
    if (amountVal == null || amountVal <= 0) return;

    setState(() => _isLoading = true);

    final payment = Payment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      paymentDate: DateTime.now(),
      amountPaid: Money(amountVal),
      method: _selectedMethod,
      status: PaymentStatus.completed,
    );

    // Context must contain OrderRepository provider
    final repo = context.read<OrderRepository>();
    final result = await repo.addPayment(widget.order.id, payment);

    if (!mounted) return;

    setState(() => _isLoading = false);

    result.fold(
      (fail) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(fail.message))),
      (_) => widget.onPaymentSuccess(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Record Payment",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Amount",
              prefixText: "₹ ",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<PaymentMethod>(
            value: _selectedMethod,
            decoration: const InputDecoration(
              labelText: "Payment Method",
              border: OutlineInputBorder(),
            ),
            items: PaymentMethod.values
                .map(
                  (m) => DropdownMenuItem(
                    value: m,
                    child: Text(m.name.capitalize),
                  ),
                )
                .toList(),
            onChanged: (val) => setState(() => _selectedMethod = val!),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _submitPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text("Confirm Payment"),
            ),
          ),
        ],
      ),
    );
  }
}
