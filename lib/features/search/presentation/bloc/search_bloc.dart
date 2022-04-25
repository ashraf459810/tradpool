import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tradpool/features/add_auction/data/models/brands_for_sub_category.dart';
import 'package:tradpool/features/add_auction/data/models/main_category.dart';
import 'package:tradpool/features/add_auction/data/models/sub_category.dart';
import 'package:tradpool/features/add_auction/domain/usecases/get_brands_for_sub_use_case.dart';
import 'package:tradpool/features/add_auction/domain/usecases/get_main_category_use_case.dart';
import 'package:tradpool/features/add_auction/domain/usecases/get_sub_categories_use_case.dart';
import 'package:tradpool/features/search/data/models/search_request_model.dart';
import 'package:tradpool/features/search/data/models/search_response_model.dart';
import 'package:tradpool/features/search/domain/usecases/search_use_case.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetMainCategoriesUseCase getMainCategoriesUseCase;
    final GetSubCategoriesUseCase getSubCategoriesUseCase;
      final BrandsForSubCategoryUseCase brandsForSubCategoryUseCase;
      final SearchUseCase searchUseCase;


  SearchBloc(this.getMainCategoriesUseCase, this.getSubCategoriesUseCase, this.brandsForSubCategoryUseCase, this.searchUseCase) : super(SearchInitial()) {


          List<SearchResult> searchResult=[];
    on<SearchEvent>((event, emit) async {
       if (event is GetMainCategoryEvent) {
        
        emit(Loading());

      final  mainCategoryResponse = await getMainCategoriesUseCase.call();

        mainCategoryResponse.fold((l) => emit(Error(l.error)),
            (r) => emit(GetMainCategoriesState(r)));
      }
      if (event is GetSubCategoryEvent) {
        emit(LoadingSubCategory());
       
      final subCategoryResponse = await getSubCategoriesUseCase.call(event.parentIdl);
        subCategoryResponse.fold((l) => emit(Error(l.error)), (r) {
          emit(GetSubCategoriesState(r));
        });
      }
      if (event is GetBrandsForSubCategoriesEvent) {
        emit(LoadingBrand());
     final   brandsresponse = await brandsForSubCategoryUseCase.call(event.parentId);
        brandsresponse.fold((l) => emit(Error(l.error)), (r) {
          emit(GetBransForSubCategoryState(r));
        });
      }
    if (event is GetSearchEvent){
      emit (LoadingSearch());
      var response = await searchUseCase.searchUseCase(event.searchRequestModel);
      response.fold((l) => emit(Error(l.error)), (r) { 

            searchResult.addAll(r.content);

        emit(GetSearchState(SearchResponseModel(content: searchResult)));
        });

    }
    });
  }
}
