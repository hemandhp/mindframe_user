import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:mindframe_user/util/file_upload.dart';
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

          List<Map<String, dynamic>> projects = await query
              .neq('user_id', Supabase.instance.client.auth.currentUser!.id)
              .order('created_at', ascending: false);

          emit(ProjectsGetSuccessState(projects: projects));
        } else if (event is GetMyProjectsEvent) {
          emit(ProjectsLoadingState());
          PostgrestFilterBuilder<List<Map<String, dynamic>>> query = table
              .select('*, added_by:user_profiles(*), category:categories(*)');

          List<Map<String, dynamic>> projects = await query
              .eq('user_id', Supabase.instance.client.auth.currentUser!.id)
              .order('created_at', ascending: false);

          emit(ProjectsGetSuccessState(projects: projects));
        } else if (event is AddProjectEvent) {
          emit(ProjectsLoadingState());

          XFile image = event.projectDetails['image'];
          File imageFile = File(image.path);
          String uploadedPath = await uploadFile(
            'project',
            imageFile,
            image.name,
          );

          event.projectDetails['image_url'] = uploadedPath;
          event.projectDetails['user_id'] =
              Supabase.instance.client.auth.currentUser!.id;

          event.projectDetails.remove('image');
          await table.insert(event.projectDetails);
          emit(ProjectsSuccessState());
        } else if (event is EditProjectEvent) {
          emit(ProjectsLoadingState());

          if (event.projectDetails['image'] != null) {
            XFile image = event.projectDetails['image'];
            File imageFile = File(image.path);
            String uploadedPath = await uploadFile(
              'project',
              imageFile,
              image.name,
            );

            event.projectDetails['image_url'] = uploadedPath;
            event.projectDetails.remove('image');
          }
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
