import 'package:osm/core/either.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame_type.dart';
import 'package:osm/features/inventory/domain/failures/frames/frame_failure.dart';
import 'package:osm/features/inventory/domain/repositories/frame_repository.dart';

class GetFramesByType {
  final FrameRepository repository;

  GetFramesByType(this.repository);

  Future<Either<FrameFailure, List<Frame>>> call(
    FrameType type,
  ) {
    return repository.getByType(type);
  }
}
