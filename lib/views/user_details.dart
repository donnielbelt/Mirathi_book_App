import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirathi_book_app/custom_bloc/custom_bloc.dart';
import 'package:mirathi_book_app/graphql_qqls/queries.dart';
import 'package:mirathi_book_app/model/user_model.dart';
import 'package:mirathi_book_app/operations/user_module/user_operation.dart';

class UserDetailsPage extends StatefulWidget {
  final String profileUniqueId;
  const UserDetailsPage({super.key, required this.profileUniqueId});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  CustomBloc<User, UserFilter, UserPayload> customTBloc =
      CustomBloc<User, UserFilter, UserPayload>();

  @override
  void initState() {
    UserOperation(customTBloc: customTBloc).singleData(
      objectType: "getUserProfileAndRole",
      classQueryString: queryUserDetailsString,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<CustomBloc<User, UserFilter, UserPayload>,
              CustomState<User, UserFilter, UserPayload>>(
            bloc: customTBloc,
            listener: (context, state) {},
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("This is Tour Page "),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        child: Builder(
                          builder: (context) {
                            if (state is LoadingState<User, UserFilter,
                                UserPayload>) {
                              return Center(child: Text("Loading ..."));
                            }

                            if (state
                                is ErrorState<User, UserFilter, UserPayload>) {
                              return Center(child: Text(state.errorMessage));
                            }

                            if (state is SuccessState<User, UserFilter,
                                UserPayload>) {
                              final user = state.responseBody.data;

                              if (user == null) {
                                return Center(
                                    child: Text("No user data available"));
                              }

                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(user.profileEmail ??
                                        'No email available'),
                                    subtitle: Text(user.profileOrganization ??
                                        'No organization available'),
                                  ),
                                ],
                              );
                            }

                            return Center(child: Text("Loading ..."));
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
      ),
    );
  }
}
