import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medicare/data/models/medicine/medicine_search_result.dart';
import 'package:medicare/data/repository/medicine/medicine_repository.dart';

part 'search_state.dart';
part 'search_cubit.freezed.dart';

class SearchCubit extends Cubit<SearchState> {
  final MedicineRepository medicineRepository;

  SearchCubit({
    required this.medicineRepository,
  }) : super(const SearchState.initial());

  Future<void> searchMedicine(String query) async {
    emit(const SearchState.loading());
    final MedicineSearchResult? medicineSearchResult =
        await medicineRepository.searchMedicine(query);
    if (medicineSearchResult != null) {
      emit(SearchState.loaded(result: medicineSearchResult));
    } else {
      emit(const SearchState.initial());
    }
  }

  void resetSearch() {
    emit(const SearchState.initial());
  }
}
