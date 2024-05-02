import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:proplay/providers/auth.provider.dart';
import 'package:provider/provider.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final me = authProvider.me;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(400),
                border: Border.all(
                  width: 2.0,
                ),
              ),
              child: me?.image != null
                  ? Image.network(
                      me!.image!,
                      width: 150,
                      height: 150,
                    )
                  : const Icon(
                      LineAwesomeIcons.user,
                      size: 100,
                    ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(me?.fullName ?? ''),
            const ListTile(
              leading: Icon(LineAwesomeIcons.bell),
              title: Text('Notificaciones'),
              trailing: Icon(LineAwesomeIcons.angle_right),
            ),
            ListTile(
              leading: const Icon(LineAwesomeIcons.user_cog),
              title: const Text('Editar perfil'),
              trailing: const Icon(LineAwesomeIcons.angle_right),
              onTap: () => context.pushNamed('user-edit'),
            ),
            const ListTile(
              leading: Icon(LineAwesomeIcons.alternate_sign_out),
              title: Text('Salir'),
            ),
          ],
        ),
      ),
    );
  }
}
