import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirathi_book_app/custom_bloc/custom_bloc.dart';
import 'package:mirathi_book_app/graphql_qqls/mutations.dart';
import 'package:mirathi_book_app/graphql_qqls/queries.dart';
import 'package:mirathi_book_app/model/response_model.dart';
import 'package:mirathi_book_app/model/user_model.dart';
import 'package:mirathi_book_app/operations/user_module/user_operation.dart';
import 'package:mirathi_book_app/reusable_widget/pagination_widget.dart';
import 'package:mirathi_book_app/reusable_widget/search_widget.dart';
import 'package:mirathi_book_app/views/user_details.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  CustomBloc<List<User>, UserFilter, UserPayload> customLTBloc =
      CustomBloc<List<User>, UserFilter, UserPayload>();

  CustomBloc<User, UserFilter, UserPayload> customTBloc =
      CustomBloc<User, UserFilter, UserPayload>();
  List<int> pageSizes = [1, 2, 3];

  @override
  void initState() {
    fiterUser(filter: UserFilter(itemsPerPage: pageSizes[0], pageNumber: 1));
    super.initState();
  }

  fiterUser({required UserFilter filter}) {
    UserOperation(customLTBloc: customLTBloc).listData(
        objectType: "getUsers",
        classQueryString: queryUserString,
        filter: filter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<CustomBloc<List<User>, UserFilter, UserPayload>,
            CustomState<List<User>, UserFilter, UserPayload>>(
          bloc: customLTBloc,
          listener: (context, state) {},
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("This is User Page "),
                    // THIS IS FOR CUSTO PAGINATION
                    (state is SuccessState<List<User>, UserFilter, UserPayload>)
                        ? Column(
                            children: [
                              PaginationWidget(
                                pageSizes: pageSizes,
                                currentPageSizes: state.filter!.itemsPerPage!,
                                page: state.responseBody.page!,
                                viewBanner: true,
                              ),
                              PaginationWidget(
                                pageSizes: pageSizes,
                                currentPageSizes: state.filter!.itemsPerPage!,
                                page: state.responseBody.page!,
                                viewNextPreviousAction: true,
                                goToNext: () {
                                  UserFilter currentFilter = state.filter!;
                                  ResponseBody<List<User>> body =
                                      state.responseBody;
                                  int currentPage = body.page!.number!;
                                  List<int> pages = body.page!.pages;
                                  if (pages.contains(currentPage + 1)) {
                                    currentFilter.pageNumber = currentPage + 1;
                                    fiterUser(filter: currentFilter);
                                  }
                                },
                                goToPrevious: () {
                                  UserFilter currentFilter = state.filter!;
                                  ResponseBody<List<User>> body =
                                      state.responseBody;
                                  int currentPage = body.page!.number!;
                                  List<int> pages = body.page!.pages;
                                  if (pages.contains(currentPage - 1)) {
                                    currentFilter.pageNumber = currentPage - 1;
                                    fiterUser(filter: currentFilter);
                                  }
                                },
                              ),
                              PaginationWidget(
                                pageSizes: pageSizes,
                                currentPageSizes: state.filter!.itemsPerPage!,
                                page: state.responseBody.page!,
                                viewButtonLists: true,
                                goToCertainPage: (index) {
                                  UserFilter currentFilter = state.filter!;
                                  currentFilter.pageNumber = index;
                                  fiterUser(filter: currentFilter);
                                  return null;
                                },
                              ),
                              PaginationWidget(
                                pageSizes: pageSizes,
                                currentPageSizes: state.filter!.itemsPerPage!,
                                page: state.responseBody.page!,
                                viewPageSizeSelector: true,
                                onPageSizeChanged: (index) {
                                  UserFilter currentFilter = state.filter!;
                                  currentFilter.itemsPerPage = index;
                                  currentFilter.pageNumber = 1;
                                  fiterUser(filter: currentFilter);
                                  return null;
                                },
                              ),
                            ],
                          )
                        : SizedBox(),
                    // CUSTOM PAGINATION END HERE

                    // CUSTOM SEARCH
                    (state is SuccessState<List<User>, UserFilter, UserPayload>)
                        ? SearchWidget(
                            performSearch: (String searchKey) {
                              UserFilter currentFilter = state.filter!;
                              currentFilter.searchKey = searchKey;
                              fiterUser(filter: currentFilter);
                              return null;
                            },
                          )
                        : SizedBox(),
                    // CUSTOM SEARCH END HERE
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: Builder(
                        builder: (context) {
                          if (state is LoadingState<List<User>, UserFilter,
                              UserPayload>) {
                            return Center(child: Text("Loading ..."));
                          }

                          if (state is ErrorState<List<User>, UserFilter,
                              UserPayload>) {
                            return Center(child: Text(state.errorMessage));
                          }

                          if (state is SuccessState<List<User>, UserFilter,
                              UserPayload>) {
                            final data = state.responseBody.data;

                            if (data == null || data.isEmpty) {
                              return Center(child: Text("No User Found"));
                            }

                            return Column(
                              children: data.map<Widget>((user) {
                                return ListTile(
                                  title: Text(user.profileEmail ??
                                      'No email available'),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UserDetailsPage(
                                          profileUniqueId:
                                              user.profileUniqueId!,
                                        ),
                                      ),
                                    );
                                  },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          UserPayload payload = UserPayload(
            profileEmail: "michael.michael@eganet.go.tz",
            profileFirstname: "Michael",
            profileLastname: "Michael",
            profileMiddlename: "Cyril",
            profileOrganization: "eGA",
            profilePassword: "123",
            profilePhone: "0693331836",
          );
          UserOperation(customTBloc: customTBloc).postData(
            context: context,
            body: payload,
            objectType: "createUserMutation",
            classQueryString: postUserString,
            whenErrorAction: (error) {},
            whenLoadingAction: () {
              // CAN CALL CONTEXT HERE
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text("-------llll---"),
              //     duration: Duration(seconds: 2),
              //   ),
              // );
            },
            whenSuccessAction: (response) {
              print("------------------");
              print(response.data!.toJson());
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
