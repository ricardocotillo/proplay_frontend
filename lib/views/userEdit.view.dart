import 'package:flutter/material.dart';
import 'package:proplay/models/user.model.dart';
import 'package:proplay/services/auth.service.dart';

class UserEditView extends StatefulWidget {
  const UserEditView({super.key});

  @override
  State<UserEditView> createState() => _UserEditViewState();
}

class _UserEditViewState extends State<UserEditView> {
  Future<User>? _future;
  final _formKey = GlobalKey<FormState>();
  final authService = AuthService();
  final Map<String, dynamic> fields = {};

  @override
  void initState() {
    super.initState();
    _future = authService.me();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.done) {
              final user = snap.data!;
              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Nombre'),
                        ),
                        initialValue: user.firstName,
                        onChanged: (s) => fields['first_name'] = s,
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Apellido'),
                        ),
                        initialValue: user.lastName,
                        onChanged: (s) => fields['last_name'] = s,
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Email'),
                        ),
                        initialValue: user.email,
                        onChanged: (s) {
                          fields['email'] = s;
                          fields['username'] = s;
                        },
                      ),
                      const SizedBox(height: 8.0),
                      MaterialButton(
                        onPressed: () async {
                          if ((_formKey.currentState?.validate() ?? false) &&
                              fields.isNotEmpty) {
                            await authService.partialUpdate(fields);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text(
                                  'Perfil actualizado correctamente',
                                ),
                                backgroundColor: theme.colorScheme.tertiary,
                              ));
                            }
                          }
                        },
                        color: theme.colorScheme.primary,
                        textColor: theme.colorScheme.onPrimary,
                        child: const Text('Actualizar'),
                      )
                    ],
                  ),
                ),
              );
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
