import 'package:osm/core/either.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/failures/frames/frame_failure.dart';
import 'package:osm/features/inventory/domain/repositories/frame_repository.dart';

class GetFramesByName {
  final FrameRepository repository;

  GetFramesByName(this.repository);

  Future<Either<FrameFailure, List<Frame>>> call(
    String name,
  ) {
    return repository.getByName(name);
  }
}
