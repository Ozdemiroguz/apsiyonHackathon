import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation_error_visibility.freezed.dart';

@freezed
class ValidationErrorVisibility with _$ValidationErrorVisibility {
  const factory ValidationErrorVisibility.hide() = _Hide;
  const factory ValidationErrorVisibility.show() = _Show;
}
