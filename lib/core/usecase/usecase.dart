import 'package:fpdart/fpdart.dart';
import 'package:vit_ap_student_app/core/error/failure.dart';

abstract interface class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
