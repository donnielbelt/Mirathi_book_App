import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirathi_book_app/custom_bloc/custom_bloc.dart';
import 'package:mirathi_book_app/graphql_qqls/queries.dart';
import 'package:mirathi_book_app/model/response_model.dart';
import 'package:mirathi_book_app/operations/project_module/project_operation.dart';
import 'package:mirathi_book_app/reusable_widget/pagination_widget.dart';

import '../model/project_model.dart';

class ProjectScrollPage extends StatefulWidget {
  const ProjectScrollPage({super.key});

  @override
  State<ProjectScrollPage> createState() => _ProjectScrollPageState();
}

class _ProjectScrollPageState extends State<ProjectScrollPage> {
  CustomBloc<List<Project>, ProjectFilter, ProjectPayload> customLTBloc =
      CustomBloc<List<Project>, ProjectFilter, ProjectPayload>();

  CustomBloc<Project, ProjectFilter, ProjectPayload> customTBloc =
      CustomBloc<Project, ProjectFilter, ProjectPayload>();
  List<int> pageSizes = [1, 2, 3];

  @override
  void initState() {
    fiterProject(filter: ProjectFilter(pageSize: pageSizes[0], pageNumber: 1));
    super.initState();
  }

  fiterProject({required ProjectFilter filter}) {
    ProjectOperation(customLTBloc: customLTBloc).listData(
        objectType: "getProjects",
        classQueryString: queryProjectString,
        filter: filter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<
            CustomBloc<List<Project>, ProjectFilter, ProjectPayload>,
            CustomState<List<Project>, ProjectFilter, ProjectPayload>>(
          bloc: customLTBloc,
          listener: (context, state) {},
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("This is Scroll pagination Page "),
// THIS IS FOR CUSTO PAGINATION
                    (state is SuccessState<List<Project>, ProjectFilter,
                            ProjectPayload>)
                        ? Column(
                            children: [
                              PaginationWidget(
                                pageSizes: pageSizes,
                                currentPageSizes: state.filter!.pageSize!,
                                page: state.responseBody.page!,
                                viewBanner: true,
                              ),
                              PaginationWidget(
                                pageSizes: pageSizes,
                                currentPageSizes: state.filter!.pageSize!,
                                page: state.responseBody.page!,
                                viewNextPreviousAction: true,
                                goToNext: () {
                                  ProjectFilter currentFilter = state.filter!;
                                  ResponseBody<List<Project>> body =
                                      state.responseBody;
                                  int currentPage = body.page!.number!;
                                  List<int> pages = body.page!.pages;
                                  if (pages.contains(currentPage + 1)) {
                                    currentFilter.pageNumber = currentPage + 1;
                                    fiterProject(filter: currentFilter);
                                  }
                                },
                                goToPrevious: () {
                                  ProjectFilter currentFilter = state.filter!;
                                  ResponseBody<List<Project>> body =
                                      state.responseBody;
                                  int currentPage = body.page!.number!;
                                  List<int> pages = body.page!.pages;
                                  if (pages.contains(currentPage - 1)) {
                                    currentFilter.pageNumber = currentPage - 1;
                                    fiterProject(filter: currentFilter);
                                  }
                                },
                              ),
                              PaginationWidget(
                                pageSizes: pageSizes,
                                currentPageSizes: state.filter!.pageSize!,
                                page: state.responseBody.page!,
                                viewButtonLists: true,
                                goToCertainPage: (index) {
                                  ProjectFilter currentFilter = state.filter!;
                                  currentFilter.pageNumber = index;
                                  fiterProject(filter: currentFilter);
                                  return null;
                                },
                              ),
                              PaginationWidget(
                                pageSizes: pageSizes,
                                currentPageSizes: state.filter!.pageSize!,
                                page: state.responseBody.page!,
                                viewPageSizeSelector: true,
                                onPageSizeChanged: (index) {
                                  ProjectFilter currentFilter = state.filter!;
                                  currentFilter.pageSize = index;
                                  currentFilter.pageNumber = 1;
                                  fiterProject(filter: currentFilter);
                                  return null;
                                },
                              ),
                            ],
                          )
                        : SizedBox(),
                    // CUSTOM PAGINATION END HERE
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: Builder(
                        builder: (context) {
                          if (state is LoadingState<List<Project>,
                              ProjectFilter, ProjectPayload>) {
                            return Center(child: Text("Loading ..."));
                          }

                          if (state is ErrorState<List<Project>, ProjectFilter,
                              ProjectPayload>) {
                            return Center(child: Text(state.errorMessage));
                          }

                          if (state is SuccessState<List<Project>,
                              ProjectFilter, ProjectPayload>) {
                            final data = state.responseBody.data;

                            if (data == null || data.isEmpty) {
                              return Center(child: Text("No Project Found"));
                            }

                            return Column(
                              children: data.map<Widget>((Project) {
                                return ListTile(
                                  title: Text(Project.projectName ??
                                      'No email available'),
                                );
                              }).toList(),
                            );
                          }
                          return Center(
                              child: Text("Something went wrong ..."));
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
