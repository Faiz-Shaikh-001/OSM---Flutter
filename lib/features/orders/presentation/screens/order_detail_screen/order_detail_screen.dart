import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:osm/features/customer/presentation/bloc/customer_details/customer_details_bloc.dart';
import 'package:osm/features/orders/presentation/blocs/order_submission/order_submission_bloc.dart';
import 'package:osm/features/orders/presentation/screens/order_detail_screen/widgets/add_payment_sheet.dart';
import 'package:osm/features/orders/presentation/screens/order_detail_screen/widgets/customer_section.dart';
import 'package:osm/features/orders/presentation/screens/order_detail_screen/widgets/item_section.dart';
import 'package:osm/features/orders/presentation/screens/order_detail_screen/widgets/pay_pending_bar.dart';
import 'package:osm/features/orders/presentation/screens/order_detail_screen/widgets/payment_history_section.dart';
import 'package:osm/features/orders/presentation/screens/order_detail_screen/widgets/payment_summary_section.dart';
import 'package:osm/features/orders/presentation/screens/order_detail_screen/widgets/status_banner.dart';
import 'package:osm/features/store/domain/entities/store_location.dart';
import 'package:osm/features/store/presentation/bloc/store_location_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

// Domain Imports
import 'package:osm/features/orders/domain/entities/order.dart';
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
    context.read<CustomerDetailsBloc>().add(
      LoadCustomerDetails(_currentOrder.customerId),
    );
  }

  Future<void> _refreshOrder() async {
    final repo = context.read<OrderRepository>();
    final result = await repo.getById(_currentOrder.id);

    if (!mounted) return;

    result.fold((failure) => null, (updatedOrder) {
      setState(() {
        _currentOrder = updatedOrder;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(title: const Text("Order Details"), centerTitle: true),
      body: BlocBuilder<CustomerDetailsBloc, CustomerDetailsState>(
        builder: (context, customerState) {
          return BlocBuilder<StoreLocationBloc, StoreLocationState>(
            builder: (context, storeState) {
              Customer? customer;
              StoreLocation? store;
              bool isLoading = true;

              if (customerState is CustomerDetailsLoaded &&
                  storeState is StoreLocationLoaded) {
                customer = customerState.details.customer;
                store = storeState.activeStore;
                isLoading = false;
              } else if (customerState is CustomerDetailsError ||
                  storeState is StoreLocationError) {
                isLoading = false;
              }

              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StatusBanner(order: _currentOrder),
                              const SizedBox(height: 16),

                              CustomerSection(
                                order: _currentOrder,
                                customer: customer,
                                isLoading: isLoading,
                              ),

                              const SizedBox(height: 16),
                              ItemsSection(items: _currentOrder.items),
                              const SizedBox(height: 16),
                              PaymentSummarySection(order: _currentOrder),
                              const SizedBox(height: 16),
                              PaymentHistorySection(
                                payments: _currentOrder.payments,
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),

                      if (!_currentOrder.isFullyPaid)
                        PayPendingBar(
                          pendingAmount: _currentOrder.pendingAmount,
                          onPayPressed: () => _showPaymentModal(context),
                        ),
                    ],
                  ),

                  if (customer != null && store != null)
                    Positioned(
                      bottom: 0,
                      right: 16,
                      child: SafeArea(
                        child: FloatingActionButton.small(
                          heroTag: "print_btn",
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          onPressed: () =>
                              _generatePdf(_currentOrder, customer!, store!),
                          child: const Icon(Icons.print),
                        ),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _showPaymentModal(BuildContext context) {
    final orderSubmissionBloc = context.read<OrderSubmissionBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: BlocProvider.value(
          value: orderSubmissionBloc,
          child: AddPaymentSheet(
            order: _currentOrder,
            onPaymentSuccess: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Payment recorded successfully"),
                  backgroundColor: Colors.green,
                ),
              );
              _refreshOrder();
            },
          ),
        ),
      ),
    );
  }

  Future<void> _generatePdf(
    Order order,
    Customer customer,
    StoreLocation store,
  ) async {
    try {
      final pdf = pw.Document();

      pw.MemoryImage? logoImage;
      if (store.storeLogoUrl != null && store.storeLogoUrl!.isNotEmpty) {
        try {
          final response = await http.get(Uri.parse(store.storeLogoUrl!));
          if (response.statusCode == 200) {
            logoImage = pw.MemoryImage(response.bodyBytes);
          }
        } catch (e) {
          debugPrint("Could not load store logo: $e");
        }
      }

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(40), // Ensure margins are set
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // --- HEADER SECTION ---
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    if (logoImage != null)
                      pw.Container(
                        width: 80,
                        height: 80,
                        child: pw.Image(logoImage),
                      )
                    else
                      pw.SizedBox(width: 80, height: 80),

                    pw.SizedBox(width: 20),

                    // Fixed the Expanded constraints by ensuring Row is in a Column
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            store.name.toUpperCase(),
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            store.address,
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                          pw.Text(
                            "${store.city}, ${store.state}, ${store.postalCode}",
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                          pw.Text(
                            "Phone: ${store.phoneNumber}",
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                          pw.Text(
                            "License: ${store.licenseNumber}",
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),

                    pw.Text(
                      "Optical Invoice",
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ),

                pw.SizedBox(height: 15),
                pw.Divider(thickness: 1, color: PdfColors.grey300),
                pw.SizedBox(height: 15),

                // --- BILL TO & INVOICE DETAILS ---
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Bill To",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                        pw.Text(
                          customer.fullName,
                          style: const pw.TextStyle(fontSize: 11),
                        ),
                        if (customer.city != null)
                          pw.Text(
                            customer.city!,
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                        pw.Text(
                          "Contact: ${customer.primaryPhoneNumber}",
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          "Invoice Number: ${order.id.value}",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                        pw.Text(
                          "Date: ${DateFormat('dd/MM/yyyy').format(order.createdAt)}",
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),

                pw.SizedBox(height: 30),

                // --- ITEMS TABLE ---
                pw.TableHelper.fromTextArray(
                  border: pw.TableBorder.all(
                    color: PdfColors.grey400,
                    width: 0.5,
                  ),
                  headerStyle: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 10,
                  ),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.grey200,
                  ),
                  cellStyle: const pw.TextStyle(fontSize: 9),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(4),
                    1: const pw.FlexColumnWidth(1),
                    2: const pw.FlexColumnWidth(1.5),
                    3: const pw.FlexColumnWidth(1.5),
                  },
                  headers: ["Description", "Quantity", "Unit price", "Amount"],
                  data: order.items.map((item) {
                    return [
                      item.productName,
                      item.quantity.toString(),
                      item.unitPrice.toString(),
                      item.total.toString(),
                    ];
                  }).toList(),
                ),

                // --- TOTAL SECTION ---
                pw.Row(
                  children: [
                    pw.Spacer(flex: 3),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(
                            bottom: pw.BorderSide(width: 1),
                            left: pw.BorderSide(
                              width: 0.5,
                              color: PdfColors.grey400,
                            ),
                            right: pw.BorderSide(
                              width: 0.5,
                              color: PdfColors.grey400,
                            ),
                          ),
                        ),
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Total",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(order.totalAmount.toString()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                pw.SizedBox(height: 40),

                // --- FOOTER NOTE ---
                pw.Text(
                  "Insurance copay due at order. Balance before pickup. Frame warranty: 1 year.",
                  style: const pw.TextStyle(
                    fontSize: 8,
                    color: PdfColors.grey700,
                  ),
                ),
                pw.Text(
                  "Order Ref: #[${order.id.value}]",
                  style: const pw.TextStyle(
                    fontSize: 8,
                    color: PdfColors.grey700,
                  ),
                ),
              ],
            );
          },
        ),
      );

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
        name: 'receipt_${order.id.value}.pdf',
      );
    } catch (e) {
      debugPrint("PDF Generation Error: $e");
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed to generate PDF: $e")));
      }
    }
  }
}
