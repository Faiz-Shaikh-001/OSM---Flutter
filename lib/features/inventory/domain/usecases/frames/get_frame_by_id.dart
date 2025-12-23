import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/failures/frames/frame_failure.dart';
import 'package:osm/features/inventory/domain/repositories/frame_repository.dart';

class GetFrameById {
  final FrameRepository repository;

  GetFrameById(this.repository);

  Future<Either<FrameFailure, Frame>> call(
    FrameId id,
  ) {
    return repository.getById(id);
  }
}
