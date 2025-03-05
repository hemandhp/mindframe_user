part of 'projects_bloc.dart';

@immutable
sealed class ProjectsEvent {}

class GetProjectsEvent extends ProjectsEvent {
  final int? categoryId;
  final bool isFundingPage;

  GetProjectsEvent({this.categoryId, this.isFundingPage = false});
}

class GetMyProjectsEvent extends ProjectsEvent {}

class GetJoinedProjectsEvent extends ProjectsEvent {}

class AddProjectEvent extends ProjectsEvent {
  final Map<String, dynamic> projectDetails;

  AddProjectEvent({required this.projectDetails});
}

class EditProjectEvent extends ProjectsEvent {
  final int projectId;
  final Map<String, dynamic> projectDetails;

  EditProjectEvent({
    required this.projectId,
    required this.projectDetails,
  });
}

class DeleteProjectEvent extends ProjectsEvent {
  final int projectId;

  DeleteProjectEvent({required this.projectId});
}

class FundProjectEvent extends ProjectsEvent {
  final int projectId;
  final int amount;

  FundProjectEvent({
    required this.projectId,
    required this.amount,
  });
}
