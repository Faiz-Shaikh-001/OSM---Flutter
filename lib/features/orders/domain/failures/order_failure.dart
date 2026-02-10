import 'package:flutter/material.dart';

@immutable
abstract class OrderFailure {
  final String message;

  const OrderFailure(this.message);
}

class OrderNotFoundFailure extends OrderFailure {
  const OrderNotFoundFailure() : super('Order not found');
}

class OrderStorageFailure extends OrderFailure {
  const OrderStorageFailure(super.message);
}

class InvalidOrderFailure extends OrderFailure {
  const InvalidOrderFailure(super.message);
}

class PaymentFailure extends OrderFailure {
  const PaymentFailure(super.message);
}

class OrderAlreadyCompletedFailure extends OrderFailure {
  const OrderAlreadyCompletedFailure(super.message);
}

class RefundNotAllowedFailure extends OrderFailure {
  const RefundNotAllowedFailure(super.message);
}

class OrderValidationFailure extends OrderFailure {
  const OrderValidationFailure(super.message);
}

class OrderUnknownFailure extends OrderFailure {
  const OrderUnknownFailure() : super('Unexpected order failure.');
}