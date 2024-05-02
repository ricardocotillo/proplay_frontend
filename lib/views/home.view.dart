import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:proplay/components/drawer.component.dart';
import 'package:proplay/components/tilePlaceholder.component.dart';
import 'package:proplay/models/progroup.model.dart';
import 'package:proplay/providers/auth.provider.dart';
import 'package:proplay/services/progroup.service.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.id});
  final int id;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<List<ProGroup>>? _future;
  final proGroupService = ProGroupService();
  var groups = <ProGroup>[];
  @override
  void initState() {
    super.initState();
    _future = getFuture();
  }

  Future<List<ProGroup>> getFuture() {
    return proGroupService.list(filters: {'users': widget.id.toString()});
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(authProvider.me?.fullName ?? ''),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final group = await context.pushNamed<ProGroup>('group-create');
              if (group != null) {
                setState(() {
                  groups.insert(0, group);
                });
              }
            },
            icon: const Icon(LineAwesomeIcons.plus_square_1),
          )
        ],
      ),
      drawer: const DrawerComponent(),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, i) => const TilePlaceholder(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            groups = snapshot.data ?? <ProGroup>[];
            if (groups.isNotEmpty) {
              return ListView.separated(
                itemCount: groups.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 4.0,
                ),
                itemBuilder: (context, index) => ListTile(
                  leading: ClipOval(
                    child: groups[index].image != null
                        ? Image.network(groups[index].image!)
                        : Container(
                            width: 50,
                            height: 50,
                            color: Colors.grey.shade500,
                          ),
                  ),
                  title: Text(groups[index].name),
                  subtitle: Text(
                      '${groups[index].usersCount.toString()} miembro${groups[index].usersCount > 1 ? 's' : ''}'),
                  trailing: const Icon(LineAwesomeIcons.angle_right),
                  onTap: () {
                    context.pushNamed(
                      'group',
                      pathParameters: {
                        'id': groups[index].id.toString(),
                      },
                    );
                  },
                ),
              );
            }
          }
          return const Center(
            child: Text('No data'),
          );
        },
      ),
    );
  }
}
