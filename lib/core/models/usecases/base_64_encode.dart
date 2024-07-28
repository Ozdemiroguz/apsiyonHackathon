// ignore_for_file: unreachable_from_main

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../failure/failure.dart';
import 'usecase.dart';

@LazySingleton(as: UseCase<String, Uint8List>)
class Base64Encode implements UseCase<String, Uint8List> {
  const Base64Encode();

  @override
  Future<Either<Failure, String>> call(Uint8List params) async {
    try {
      final result = await compute(_encode, params);

      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.unknownError(e.toString()));
    }
  }
}

@pragma("vm:entry-point")
String _encode(Uint8List message) {
  return base64Encode(message);
}
