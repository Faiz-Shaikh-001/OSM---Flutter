import 'package:osm/core/either.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/failures/frames/frame_failure.dart';
import 'package:osm/features/inventory/domain/repositories/frame_repository.dart';

class GetFramesByCompany {
  final FrameRepository repository;

  GetFramesByCompany(this.repository);

  Future<Either<FrameFailure, List<Frame>>> call(
    String companyName,
  ) {
    return repository.getByCompany(companyName);
  }
}
