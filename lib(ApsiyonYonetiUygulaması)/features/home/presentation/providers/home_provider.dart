//Home state ile Home provider

import 'package:apsiyonY/core/models/failure/failure.dart';
import 'package:apsiyonY/services/user_service/user_service_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/injections/locator.dart';
import '../../domain/models/post.dart';
import '../states/homeState/home_state.dart';

final homeProvider = NotifierProvider.autoDispose<_HomeNotifier, HomeState>(
  _HomeNotifier.new,
);

class _HomeNotifier extends AutoDisposeNotifier<HomeState> {
  @override
  HomeState build() {
    Future(() => getHomeData());
    return HomeState.initial();
  }

  Future<void> getHomeData() async {
    state = state.copyWith(isLoading: true);

    final apsiyonId = await ref
        .read(homeRepositoryProvider)
        .getApsiyonPointId(userId: FirebaseAuth.instance.currentUser!.uid);

    final result = await ref.read(homeRepositoryProvider).getPost(
        apsiyonPointId: apsiyonId == null ? "M1qwjBmU9VNia7zz1Sl8" : apsiyonId);
    final result2 = await ref.read(homeRepositoryProvider).getAnnoucments();

    result.fold(
      (l) => state = state.copyWith(failure: some(l)),
      (r) => state = state.copyWith(
        failure: none(),
        posts: r,
      ),
    );

    result2.fold(
      (l) => state = state.copyWith(failure: some(l)),
      (r) => state = state.copyWith(
        failure: none(),
        announcements: r,
      ),
    );

    //posts ve announcements listeleri birleştiriliyor

    for (var i = 0; i < state.posts.length; i++) {
      print(state.posts[i].title);
    }

    final List<Post> postList = state.posts + state.announcements;

    //postlisti zamanına göre sıralıyor
    postList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    state = state.copyWith(
      postList: postList,
      filteredPostList: postList,
      isLoading: false,
    );
  }

  Future<void> setPost() async {
    state = state.copyWith(isLoading: true);

    final result = await ref.read(homeRepositoryProvider).setPost(
          title: state.title,
          content: state.content,
          apsiyonPointId: ref.read(userService).apsiyonPoint!.id,
          userId: ref.read(userService).userData.uid[0] +
              ref.read(userService).userData.uid[1],
          type: state.type!,
          image: state.img,
          username:
              "${ref.read(userService).userData.name} ${ref.read(userService).userData.surname}",
        );

    state = state.copyWith(failure: result, isLoading: false);
  }

  Future<void> deletePost(String postId) async {
    state = state.copyWith(isLoading: true);

    final result =
        await ref.read(homeRepositoryProvider).deletePost(postId: postId);

    getHomeData();

    state = state.copyWith(failure: result, isLoading: false);
  }

  void onChangedContent(String value) {
    state = state.copyWith(content: value);
  }

  void onChangedTitle(String value) {
    state = state.copyWith(title: value);
  }

  void onChangedType(String value) {
    state = state.copyWith(type: value);
  }

  void onChangedImg(String value) {
    state = state.copyWith(img: value);
  }

  void onChangedIsCompleted(bool value) {
    state = state.copyWith(isCompleted: value);
  }

  Future<void> setInitial() async {
    state = state.copyWith(
      content: "",
      title: "",
      type: null,
      img: "",
      isCompleted: false,
    );
  }
}
