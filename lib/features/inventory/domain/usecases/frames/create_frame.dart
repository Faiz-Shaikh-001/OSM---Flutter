import 'package:osm/core/either.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/failures/frames/frame_failure.dart';
import 'package:osm/features/inventory/domain/repositories/frame_repository.dart';
import 'package:osm/features/inventory/domain/success/frames/frame_success.dart';

class CreateFrame {
  final FrameRepository repository;

  CreateFrame(this.repository);

  Future<Either<FrameFailure, FrameCreatedSuccess>> call(
    Frame frame,
  ) async {
    if (frame.name.isEmpty) {
      return const Left(
        FrameValidationFailure('Frame name is required'),
      );
    }

    if (frame.variants.isEmpty) {
      return const Left(
        FrameValidationFailure('At least one variant is required'),
      );
    }

    return repository.create(frame);
  }
}
