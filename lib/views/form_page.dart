import 'package:flutter/material.dart';
import 'package:mirathi_book_app/custom_bloc/custom_bloc.dart';
import 'package:mirathi_book_app/graphql_qqls/mutations.dart';
import 'package:mirathi_book_app/model/user_model.dart';
import 'package:mirathi_book_app/operations/user_module/user_operation.dart';
import 'package:mirathi_book_app/reusable_widget/custom_input_field.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  CustomBloc<User, UserFilter, UserPayload> customTBloc =
      CustomBloc<User, UserFilter, UserPayload>();

  final TextEditingController textController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dropdownController = TextEditingController();
  bool termsAccepted = false;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    setState(() {
      emailController.text = "michael.michael@eganet.go.tz";
    });
    super.initState();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      UserPayload payload = UserPayload(
        profileEmail: emailController.text,
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
        whenErrorAction: (error) {
          print("-------------------E-");
          print(error);
          // Handle error dynamically
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error),
              duration: Duration(seconds: 2),
            ),
          );
        },
        whenLoadingAction: () {
          print("-------------------L-");
          // Show loading indicator
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Loading..."),
              duration: Duration(seconds: 2),
            ),
          );
        },
        whenSuccessAction: (response) {
          print("-------------------S-");
          print(response.response!.toJson());
          // Handle successful response
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("User created successfully!"),
              duration: Duration(seconds: 2),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomInputField(
                label: "Text Field",
                controller: textController,
                // isRequired: true,
              ),
              CustomInputField(
                label: "Phone Number",
                controller: phoneController,
                // inputType: TextInputType.phone,
                isPhone: true,
                // isRequired: true,
              ),
              CustomInputField(
                label: "Email",
                controller: emailController,
                isEmail: true,
                // isRequired: true,
              ),
              CustomInputField(
                label: "Password",
                controller: passwordController,
                isPassword: true,
                // isRequired: true,
              ),
              // CustomInputField(
              //   label: "Dropdown",
              //   controller: dropdownController,
              //   isDropdown: true,
              //   dropdownItems: ["MM", "KKK"]
              //       .map((e) => DropdownModel(item: e, value: e))
              //       .toList(),
              //   // isRequired: true,
              // ),
              SizedBox(height: 16),
              CustomInputField(
                label: "Accept Terms & Conditions",
                controller: TextEditingController(
                    text: termsAccepted ? 'true' : 'false'),
                isCheckbox: true, // Checkbox input
                // isRequired: true, // Makes the checkbox field required
                onCheckboxChanged: (value) {
                  setState(() {
                    termsAccepted = value;
                  });
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  13.0), // Vertical padding for the button
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12.0), // Rounded corners
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 18), // Text style
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
