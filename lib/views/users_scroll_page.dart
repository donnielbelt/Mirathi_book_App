import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirathi_book_app/custom_bloc/custom_bloc.dart';
import 'package:mirathi_book_app/graphql_qqls/queries.dart';
import 'package:mirathi_book_app/model/user_model.dart';
import 'package:mirathi_book_app/operations/user_module/user_operation.dart';
import 'package:mirathi_book_app/reusable_widget/timerange_filter_widget.dart';
import 'package:mirathi_book_app/views/user_details.dart';

class UsersScrollPage extends StatefulWidget {
  const UsersScrollPage({super.key});

  @override
  State<UsersScrollPage> createState() => _UsersScrollPageState();
}

class _UsersScrollPageState extends State<UsersScrollPage> {
  CustomBloc<List<User>, UserFilter, UserPayload> customLTBloc =
      CustomBloc<List<User>, UserFilter, UserPayload>();

  CustomBloc<User, UserFilter, UserPayload> customTBloc =
      CustomBloc<User, UserFilter, UserPayload>();
  List<int> pageSizes = [1, 2, 3];

  // FOR TIME RANGE
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  String? selectedTimeRange;
  DateTime? fromDate;
  DateTime? toDate;
  // END HERE

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
                    // FOR CUSTOM
                    TimeRangeFilterWidget(
                      key: formKey1,
                      viewCustomTimeRange: true,
                      onCustomRangeSelected: (timeRange) {
                        setState(() {
                          selectedTimeRange = timeRange;
                          fromDate = null;
                          toDate = null;
                        });
                        fiterUser(
                            filter: UserFilter(
                          itemsPerPage: pageSizes[0],
                          pageNumber: 1,
                        ));
                      },
                      currentCustom: selectedTimeRange,
                    ),

                    // FOR RANGE
                    TimeRangeFilterWidget(
                      key: formKey2,
                      viewDateRangePicker: true,
                      onTimeRangeSelected: (from, to) {
                        setState(() {
                          fromDate = from;
                          toDate = to;
                          selectedTimeRange = null;
                        });
                        // Re-fetch users with the selected date range
                        fiterUser(
                            filter: UserFilter(
                          itemsPerPage: pageSizes[0],
                          pageNumber: 1,
                        ));
                      },
                      fromDate: fromDate,
                      toDate: toDate,
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
    );
  }
}
