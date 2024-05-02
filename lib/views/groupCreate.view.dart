import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:proplay/models/groupuser.model.dart';
import 'package:proplay/models/progroup.model.dart';
import 'package:proplay/models/user.model.dart';
import 'package:proplay/providers/auth.provider.dart';
import 'package:proplay/services/groupuser.service.dart';
import 'package:proplay/services/progroup.service.dart';
import 'package:provider/provider.dart';

class GroupCreateView extends StatelessWidget {
  GroupCreateView({super.key});
  final _formKey = GlobalKey<FormState>();
  final textEditingController = TextEditingController();
  final service = ProGroupService();
  final memberService = GroupUserService();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crea tu grupo'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              TextFormField(
                controller: textEditingController,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  label: Text('Nombre del grupo'),
                ),
              ),
              const SizedBox(height: 8.0),
              MaterialButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    var group = ProGroup(name: textEditingController.text);
                    group = await service.store(group);
                    var member = GroupUser(
                      group: group.id,
                      user: User(),
                      role: GroupUserRole.owner,
                      userId: authProvider.me!.id,
                    );
                    member = await memberService.store(member);
                    if (context.mounted) {
                      context.pop<ProGroup>(group);
                    }
                  }
                },
                color: theme.colorScheme.primary,
                textColor: theme.colorScheme.onPrimary,
                child: const Text('Crear'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
