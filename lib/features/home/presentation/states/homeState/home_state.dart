import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/models/failure/failure.dart';
import '../../../domain/models/post.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required bool isLoading,
    required List<Post> postList,
    required List<Post> announcements,
    required List<Post> posts,
    required List<Post> filteredPostList,
    required String img,
    required String content,
    required String title,
    required String? type,
    required bool isCompleted,
    required Option<Failure> failure,
  }) = _HomeState;

  factory HomeState.initial() => HomeState(
        isLoading: false,
        postList: [],
        filteredPostList: [],
        announcements: [],
        posts: [],
        img: '',
        content: '',
        title: '',
        type: null,
        isCompleted: false,
        failure: none(),
      );

  const HomeState._();
}
