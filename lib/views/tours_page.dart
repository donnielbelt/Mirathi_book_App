import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirathi_book_app/custom_bloc/custom_bloc.dart';
import 'package:mirathi_book_app/graphql_qqls/queries.dart';
import 'package:mirathi_book_app/model/tour_model.dart';
import 'package:mirathi_book_app/operations/tour_module/tour_operation.dart';

class ToursPage extends StatefulWidget {
  const ToursPage({super.key});

  @override
  State<ToursPage> createState() => _ToursPageState();
}

class _ToursPageState extends State<ToursPage> {
  CustomBloc<List<Tour>, TourFilter, TourPayload> customLTBloc =
      CustomBloc<List<Tour>, TourFilter, TourPayload>();

  @override
  void initState() {
    TourOperation(customLTBloc: customLTBloc).listData(
        objectType: "getTours",
        classQueryString: queryTourString,
        filter: TourFilter());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<CustomBloc<List<Tour>, TourFilter, TourPayload>,
            CustomState<List<Tour>, TourFilter, TourPayload>>(
          bloc: customLTBloc,
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
                          if (state is LoadingState<List<Tour>, TourFilter,
                              TourPayload>) {
                            return Center(child: Text("Loading ..."));
                          }

                          if (state is ErrorState<List<Tour>, TourFilter,
                              TourPayload>) {
                            return Center(child: Text(state.errorMessage));
                          }

                          if (state is SuccessState<List<Tour>, TourFilter,
                              TourPayload>) {
                            final data = state.responseBody.data;

                            if (data == null || data.isEmpty) {
                              return Center(child: Text("No Tour Found"));
                            }

                            return Column(
                              children: data.map<Widget>((tour) {
                                return ListTile(
                                  title: Text(tour.description ??
                                      'No description available'),
                                );
                              }).toList(),
                            );
                          }

                          return Center(child: Text("Something went wrong"));
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
