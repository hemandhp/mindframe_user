part of 'projects_bloc.dart';

@immutable
sealed class ProjectsState {}

final class ProjectsInitialState extends ProjectsState {}

final class ProjectsLoadingState extends ProjectsState {}

final class ProjectsSuccessState extends ProjectsState {}

final class ProjectsGetSuccessState extends ProjectsState {
  final List<Map<String, dynamic>> projects;

  ProjectsGetSuccessState({required this.projects});
}

final class ProjectsFailureState extends ProjectsState {
  final String message;

  ProjectsFailureState({this.message = apiErrorMessage});
}
