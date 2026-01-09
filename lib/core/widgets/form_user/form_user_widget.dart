import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news/core/environment/environment.dart';
import 'package:news/core/model/country.dart';
import 'package:news/core/model/user.dart';
import 'package:news/core/services/auth/auth_service.dart';
import 'package:news/core/services/http/http_service.dart';
import 'package:news/core/services/toast/toast_service.dart';
import 'package:news/core/widgets/button/button_widget.dart';
import 'package:news/core/widgets/input/input_widget.dart';

class FormUserWidget extends StatefulWidget {
  final bool isRegister;

  const FormUserWidget({super.key, this.isRegister = true});

  @override
  State<FormUserWidget> createState() => _FormUserWidgetState();
}

class _FormUserWidgetState extends State<FormUserWidget> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final name2Controller = TextEditingController();
  final lastNameController = TextEditingController();
  final lastName2Controller = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final countryController = TextEditingController();
  final httpService = HttpService();

  void back() {
    context.pop();
  }

  String? notNull(String? value, String inputName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $inputName';
    }
    return null;
  }

  void register() async {
    if (_formKey.currentState!.validate()) {
      final name = nameController.text;
      final name2 = name2Controller.text;
      final lastName = lastNameController.text;
      final lastName2 = lastName2Controller.text;
      final email = emailController.text;
      final password = passwordController.text;
      final country = countryController.text;

      final user = User(
        name: name,
        name2: name2,
        lastName: lastName,
        lastName2: lastName2,
        email: email,
        password: password,
        country: country,
      );

      final isSuccessful = await AuthService.register(user);
      if (isSuccessful) {
        // ignore: use_build_context_synchronously
        ToastService.show(context, 'Successful registration', Colors.green, 2);
        // ignore: use_build_context_synchronously
        context.pop();
        return;
      }
      // ignore: use_build_context_synchronously
      ToastService.show(context, 'Error', Colors.red, 2);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    name2Controller.dispose();
    lastName2Controller.dispose();
    lastName2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 10,
        children: [
          InputWidget(
            controller: nameController,
            labelText: 'Name *',
            validator: (value) => notNull(value, 'name'),
          ),
          InputWidget(controller: name2Controller, labelText: 'Second name'),
          InputWidget(
            controller: lastNameController,
            labelText: 'Last name *',
            validator: (value) => notNull(value, 'last name'),
          ),
          InputWidget(
            controller: lastName2Controller,
            labelText: 'Second last name',
          ),
          InputWidget(
            controller: emailController,
            labelText: 'email *',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@') || !value.contains('.')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          InputWidget(
            controller: passwordController,
            labelText: 'password',
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          FutureBuilder(
            future: httpService.get<Country>(
              Environment.countryUrl.value,
              (json) => Country.fromJson(json),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text('Error al consumir la api');
              }

              final data = snapshot.data;

              return DropdownButtonFormField(
                isExpanded: true,
                items: (data!.data..sort((a, b) => a.name.compareTo(b.name)))
                    .map(
                      (c) => DropdownMenuItem<String>(
                        value: c.name,
                        child: Text(c.name),
                      ),
                    )
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your country';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value != null) {
                    countryController.text = value;
                  }
                },
              );
            },
          ),
          ButtonWidget(text: 'Register', click: register),
        ],
      ),
    );
  }
}
