import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/domain/failures/frames/frame_failure.dart';
import 'package:osm/features/inventory/domain/repositories/frame_repository.dart';
import 'package:osm/features/inventory/domain/success/frames/frame_success.dart';

class DeleteFrame {
  final FrameRepository repository;

  DeleteFrame(this.repository);

  Future<Either<FrameFailure, FrameDeletedSuccess>> call(
    FrameId id,
  ) {
    return repository.delete(id);
  }
}
