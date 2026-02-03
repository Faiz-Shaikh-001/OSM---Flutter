// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/value_objects/money.dart';
import 'package:osm/features/orders/domain/entities/payment.dart';
import 'package:osm/features/orders/domain/entities/payment_enums.dart';
import 'package:osm/features/orders/presentation/blocs/order_draft/order_draft_bloc.dart';
import 'package:osm/features/orders/presentation/blocs/order_submission/order_submission_bloc.dart';

class PaymentStep extends StatefulWidget {
  const PaymentStep({super.key});

  @override
  State<PaymentStep> createState() => _PaymentStepState();
}

class _PaymentStepState extends State<PaymentStep> {
  PaymentMethod? _selectedMethod;

  final _formKey = GlobalKey<FormState>();
  final _advancePaymentCtrl = TextEditingController();
  final _discountCtrl = TextEditingController();

  double _discountVal = 0.0;
  double _advanceVal = 0.0;

  @override
  void initState() {
    _discountCtrl.addListener(() {
      setState(() {
        _discountVal = double.tryParse(_discountCtrl.text) ?? 0.0;
      });
    });
    _advancePaymentCtrl.addListener(() {
      setState(() {
        _advanceVal = double.tryParse(_advancePaymentCtrl.text) ?? 0.0;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _discountCtrl.dispose();
    _advancePaymentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderSubmissionBloc, OrderSubmissionState>(
      listener: (context, state) {
        if (state is OrderSubmissionLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is OrderSubmissionSuccess) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

          context.read<OrderDraftBloc>().add(OrderDraftReset());

          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Order Successfully Placed"),
              backgroundColor: Colors.green,
            ),
          );
        }

        if (state is OrderSubmissionFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<OrderDraftBloc, OrderDraftState>(
        builder: (context, state) {
          final totalAmount = state.draft.totalAmount.value;
          final finalTotal = (totalAmount - _discountVal).clamp(
            0.0,
            double.infinity,
          );
          final balanceDue = (finalTotal - _advanceVal).clamp(
            0.0,
            double.infinity,
          );

          return Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _OrderSummaryCard(state),

                    const SizedBox(height: 24,),
                    _sectionTitle("Payment Method"),
                    const SizedBox(height: 10),
                    _buildPaymentGrid(),

                    const SizedBox(height: 24),
                    _sectionTitle("Order Details"),
                    const SizedBox(height: 10),

                    _buildAdjustmentsForm(totalAmount),
                    const SizedBox(height: 24),
                    _buildMathBreakdown(totalAmount, finalTotal, balanceDue),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: _buildBottomBar(state, balanceDue),
          );
        },
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildPaymentGrid() {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: PaymentMethod.values.map((method) {
            final isSelected = _selectedMethod == method;
            final width = (constraints.maxWidth - 10) / 2;

            return InkWell(
              onTap: () => setState(() => _selectedMethod = method),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: width,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.primaryColor.withOpacity(0.1)
                      : Colors.white,
                  border: Border.all(
                    color: isSelected
                        ? theme.primaryColor
                        : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getIconForMethod(method),
                      color: isSelected ? theme.primaryColor : Colors.grey,
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        method.name.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? theme.primaryColor
                              : Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: theme.primaryColor,
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildAdjustmentsForm(double totalAmount) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _discountCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Discount",
              prefixText: "₹ ",
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextFormField(
            controller: _advancePaymentCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Advance / Deposit",
              prefixText: "₹ ",
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  final remaining = totalAmount - _discountVal;
                  _advancePaymentCtrl.text = remaining.toStringAsFixed(2);
                },
                icon: const Icon(Icons.all_inclusive, size: 18),
                tooltip: "Pay Full",
              ),
            ),
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                final v = double.tryParse(value) ?? 0;
                if (v < 0) return "Invalid";
              }

              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMathBreakdown(
    double subtotal,
    double totalAfterDiscount,
    double balance,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _rowMath("Subtotal", subtotal),
          if (_discountVal > 0)
            _rowMath("Discount", -_discountVal, color: Colors.green),
          const Divider(),
          _rowMath("Total Payable", totalAfterDiscount, isBold: true),
          if (_advanceVal > 0)
            _rowMath("Advance Paid", -_advanceVal, color: Colors.blue),
          const Divider(thickness: 1, height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Balance Due",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                "₹ ${balance.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: balance > 0 ? Colors.red : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _rowMath(
    String label,
    double val, {
    bool isBold = false,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.grey[700],
            ),
          ),
          Text(
            "${val < 0 ? '-' : ''}₹ ${val.abs().toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(OrderDraftState state, double balanceDue) {
    final canPay = state.canSubmit && _selectedMethod != null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 50,
          child: FilledButton(
            onPressed: canPay ? () => _confirmPayment(state) : null,
            style: FilledButton.styleFrom(
              backgroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check, size: 18),
                const SizedBox(width: 8),
                Text(
                  _advanceVal > 0
                      ? "Confirm Advance (₹${_advanceVal.toStringAsFixed(2)})"
                      : "Confirm Full Payment",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmPayment(OrderDraftState state) {
    if (!_formKey.currentState!.validate()) return;

    final payment = Payment(
      paymentDate: DateTime.now(),
      amountPaid: _advanceVal > 0
          ? Money(_advanceVal)
          : Money(state.draft.totalAmount.value - _discountVal),
      method: _selectedMethod!,
      status: PaymentStatus.completed,
      transactionId: '',
    );

    context.read<OrderDraftBloc>().add(PaymentAdded(payment));

    context.read<OrderSubmissionBloc>().add(
      SubmitOrderDraft(state.draft.withPayment(payment)),
    );
  }

  IconData _getIconForMethod(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.card:
        return Icons.credit_card;
      case PaymentMethod.cash:
        return Icons.money;
      case PaymentMethod.upi:
        return Icons.qr_code;
      case PaymentMethod.bankTransfer:
        return Icons.money_rounded;
    }
  }
}

class _OrderSummaryCard extends StatelessWidget {
  final OrderDraftState state;

  const _OrderSummaryCard(this.state);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order Summary",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
    
        const SizedBox(height: 8),
    
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(5),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      child: Center(
                        child: Text("#", style: theme.textTheme.bodySmall),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Product",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: Text(
                        "Qty",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
    
              const Divider(),
    
              ...state.draft.items.indexed.map((entry) {
                final index = entry.$1 + 1;
                final item = entry.$2;
    
                return Row(
                  children: [
                    SizedBox(
                      width: 30,
                      child: Center(
                        child: Text(
                          index.toString(),
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item.productName,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: Text(
                        item.quantity.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                );
              }),
    
              const Divider(),
    
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Amount"),
                    Text(
                      "₹${state.draft.totalAmount.value}",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
