import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:mindframe_user/values/strings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'projects_event.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc() : super(ProjectsInitialState()) {
    on<ProjectsEvent>((event, emit) async {
      try {
        final SupabaseQueryBuilder table =
            Supabase.instance.client.from('ideas');

        if (event is GetProjectsEvent) {
          emit(ProjectsLoadingState());
          PostgrestFilterBuilder<List<Map<String, dynamic>>> query = table
              .select('*, added_by:user_profiles(*), category:categories(*)');

          if (event.categoryId != null) {
            query = query.eq('category_id', event.categoryId!);
          }

          List<Map<String, dynamic>> projects =
              await query.order('created_at', ascending: false);

          emit(ProjectsGetSuccessState(projects: projects));
        } else if (event is AddProjectEvent) {
          emit(ProjectsLoadingState());
          event.projectDetails['added_by'] =
              Supabase.instance.client.auth.currentUser!.id;
          await table.insert(event.projectDetails);
          emit(ProjectsSuccessState());
        } else if (event is EditProjectEvent) {
          emit(ProjectsLoadingState());
          await table.update(event.projectDetails).eq('id', event.projectId);
          emit(ProjectsSuccessState());
        } else if (event is DeleteProjectEvent) {
          emit(ProjectsLoadingState());
          await table.delete().eq('id', event.projectId);
          emit(ProjectsSuccessState());
        } else if (event is FundProjectEvent) {
          emit(ProjectsLoadingState());
          final response = await table
              .select('funded_amount')
              .eq('id', event.projectId)
              .single();
          final currentAmount = response['funded_amount'] ?? 0;
          final newAmount = currentAmount + event.amount;
          await table
              .update({'funded_amount': newAmount}).eq('id', event.projectId);
          emit(ProjectsSuccessState());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(ProjectsFailureState());
      }
    });
  }
}
