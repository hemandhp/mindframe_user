import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitialState()) {
    on<CategoriesEvent>((event, emit) async {
      try {
        emit(CategoriesLoadingState());

        List<Map<String, dynamic>> categories = await Supabase.instance.client
            .from('categories')
            .select('*')
            .order('name', ascending: true);

        emit(CategoriesSuccessState(categories: categories));
      } catch (e, s) {
        Logger().e('$e\n$s');

        emit(CategoriesFailureState());
      }
    });
  }
}
