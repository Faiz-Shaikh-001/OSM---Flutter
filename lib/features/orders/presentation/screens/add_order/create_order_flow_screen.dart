import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/features/orders/domain/repositories/order_repository.dart';
import 'package:osm/features/orders/domain/usecases/create_order_from_draft.dart';
import 'package:osm/features/orders/presentation/blocs/order_draft/order_draft_bloc.dart';
import 'package:osm/features/orders/presentation/blocs/order_submission/order_submission_bloc.dart';
import 'package:osm/features/orders/presentation/enum/order_step.dart';
import 'package:osm/features/orders/presentation/screens/customer_step/customer_step.dart';
import 'package:osm/features/orders/presentation/screens/payment_step/payment_step.dart';
import 'package:osm/features/orders/presentation/screens/product_step/product_step.dart';
import 'package:osm/features/orders/presentation/widgets/order_stepper.dart';
import 'package:osm/features/store/presentation/bloc/store_location_bloc.dart';

class CreateOrderFlowScreen extends StatefulWidget {
  const CreateOrderFlowScreen({super.key});

  @override
  State<CreateOrderFlowScreen> createState() => _CreateOrderFlowScreenState();
}

class _CreateOrderFlowScreenState extends State<CreateOrderFlowScreen> {
  OrderStep _currentStep = OrderStep.customer;

  // Navigation logic
  void _goTo(OrderStep step) {
    setState(() => _currentStep = step);
  }

  // Handles back navigation
  Future<bool> _handleBack() async {
    switch (_currentStep) {
      case OrderStep.customer:
        final shouldDiscard = await _showDiscardDialog();
        return shouldDiscard;
      case OrderStep.product:
        _goTo(OrderStep.customer);
        return false;
      case OrderStep.payment:
        _goTo(OrderStep.product);
        return false;
    }
  }

  Future<bool> _showDiscardDialog() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Discard Order?"),
            content: const Text(
              "You have unsaved changes. Are you sure you want to leave?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  "Discard",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final orderRepository = context.read<OrderRepository>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final bloc = OrderDraftBloc();

            // Initialize draft with active store immediately
            final storeState = context.read<StoreLocationBloc>().state;

            if (storeState is StoreLocationLoaded &&
                storeState.activeStore?.id != null) {
              bloc.add(StoreSelected(storeState.activeStore!.id!));
            }
            return bloc;
          },
        ),
        BlocProvider(
          create: (context) => OrderSubmissionBloc(
            createOrderFromDraft: CreateOrderFromDraft(orderRepository),
          ),
        ),
      ],
      child: BlocListener<StoreLocationBloc, StoreLocationState>(
        listener: (context, storeState) {
          if (storeState is StoreLocationLoaded &&
              storeState.activeStore != null) {
            context.read<OrderDraftBloc>().add(
              StoreSelected(storeState.activeStore!.id!),
            );
          }
        },
        child: Builder(
          builder: (context) {
            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) async {
                if (didPop) return;
                final shouldExit = await _handleBack();
                if (shouldExit && context.mounted) {
                  Navigator.pop(context, result);
                }
              },
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Create Order'),
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () async {
                      final shouldExit = await _handleBack();
                      if (shouldExit && context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    icon: _currentStep == OrderStep.customer
                        ? const Icon(Icons.close)
                        : const Icon(Icons.chevron_left),
                  ),
                ),
                body: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: OrderStepper(currentStep: _currentStep),
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: KeyedSubtree(
                          key: ValueKey(_currentStep),
                          child: _buildStep(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (_currentStep) {
      case OrderStep.customer:
        return CustomerStep(onNext: () => _goTo(OrderStep.product));
      case OrderStep.product:
        return ProductStep(onNext: () => _goTo(OrderStep.payment));
      case OrderStep.payment:
        return PaymentStep();
    }
  }
}
