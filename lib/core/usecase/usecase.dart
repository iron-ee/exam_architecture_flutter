import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:exam_architecture_iron/core/error/failures.dart';

// usecase의 공통 인터페이스
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// 매개변수가 필요 없을 때 사용하는 클래스
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
