import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hao12345/bean/all_urls_bean.dart';
import 'package:hao12345/repository/navigation_repository.dart';

final navigationRepositoryProvider = Provider<NavigationRepository>((ref) {
  return NavigationRepository();
});

final navigationViewModelProvider =
    AsyncNotifierProvider<NavigationViewModel, AllUrlsBean?>(
        NavigationViewModel.new);

class NavigationViewModel extends AsyncNotifier<AllUrlsBean?> {
  late final NavigationRepository _repo;

  @override
  Future<AllUrlsBean?> build() async {
    _repo = ref.read(navigationRepositoryProvider);
    return _safeFetch();
  }

  Future<AllUrlsBean?> _safeFetch() async {
    try {
      final data = await _repo.fetch();
      return data;
    } catch (_) {
      return null;
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => await _repo.fetch());
  }

  Future<void> saveDraft(AllUrlsBean bean) async {
    await _repo.save(bean);
    state = AsyncData(bean);
  }

  String exportJson() => _repo.exportCurrentJson();

}
