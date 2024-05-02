import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:proplay/forms/login.form.dart';
import 'package:proplay/providers/auth.provider.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();
  final validator = ValidationBuilder(localeName: 'es');

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final loginForm = Provider.of<LoginForm>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const FlutterLogo(
                size: 150.0,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  validator: ValidationBuilder(
                    localeName: 'es',
                  ).required().email().build(),
                  decoration: const InputDecoration(
                    label: Text('Email'),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (s) => loginForm.email = s,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  validator: ValidationBuilder(
                    localeName: 'es',
                  ).required().build(),
                  decoration: const InputDecoration(
                    label: Text('Password'),
                  ),
                  obscureText: true,
                  onSaved: (s) => loginForm.password = s,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              MaterialButton(
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    formKey.currentState?.save();
                    final ok = await authProvider.login(loginForm);
                    if (ok && context.mounted) GoRouter.of(context).refresh();
                  }
                },
                textColor: colorScheme.onPrimary,
                color: colorScheme.primary,
                child: const Text('Ingresar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
