// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirathi_book_app/custom_bloc/custom_bloc.dart';
import 'package:mirathi_book_app/graphql_qqls/queries.dart';
import 'package:mirathi_book_app/model/user_model.dart';
import 'package:mirathi_book_app/operations/user_module/user_operation.dart';
import 'package:mirathi_book_app/reusable_widget/custom_table_widget.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
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
                    Text("This is Scroll pagination Page "),
                    SizedBox(
                      height: 20,
                    ),
                    if (true)
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

                              return CustomTable();
                            }
                            return Center(
                                child: Text("Something went wrong ..."));
                          },
                        ),
                      ),
                    if (true) Text("data")
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
