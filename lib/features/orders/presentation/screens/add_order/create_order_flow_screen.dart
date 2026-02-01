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

  void _goTo(OrderStep step) {
    setState(() {
      _currentStep = step;
    });
  }

  bool _handleBack() {
    switch (_currentStep) {
      case OrderStep.customer:
        return true;
      case OrderStep.product:
        _goTo(OrderStep.customer);
        return false;
      case OrderStep.payment:
        _goTo(OrderStep.product);
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderRepository = context.read<OrderRepository>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OrderDraftBloc()),
        BlocProvider(
          create: (context) => OrderSubmissionBloc(
            createOrderFromDraft: CreateOrderFromDraft(orderRepository),
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final storeState = context.read<StoreLocationBloc>().state;

            if (storeState is StoreLocationLoaded &&
                storeState.activeStore != null) {
              context.read<OrderDraftBloc>().add(
                StoreSelected(storeState.activeStore!.id!),
              );
            }
          });

          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;
              final shouldExit = _handleBack();
              if (shouldExit && Navigator.canPop(context)) {
                Navigator.pop(context, result);
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text('Create Order'),
                leading: IconButton(
                  onPressed: () {
                    final shouldPop = _handleBack();
                    if (shouldPop && Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.chevron_left),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: _buildStep(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
