import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:proplay/controllers/group.controller.dart';
import 'package:proplay/models/groupuser.model.dart';
import 'package:proplay/models/progroup.model.dart';
import 'package:proplay/models/schedule.model.dart';
import 'package:proplay/services/groupuser.service.dart';
import 'package:proplay/services/progroup.service.dart';
import 'package:proplay/services/schedule.service.dart';
import 'package:provider/provider.dart';

class GroupView extends StatefulWidget {
  const GroupView({super.key, required this.id});

  final int id;

  @override
  State<GroupView> createState() => _GroupState();
}

class _GroupState extends State<GroupView> {
  Future<List>? _future;
  String title = '';
  final groupService = ProGroupService();
  final groupUsers = GroupUserService();
  final scheduleService = ScheduleService();
  List<Schedule> schedules = [];

  @override
  void initState() {
    super.initState();
    _future = Future.wait([
      groupService.retrieve(widget.id),
      groupUsers.list({'group': widget.id.toString()}),
      scheduleService.list({'progroup': widget.id.toString()}),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final GroupController groupController =
        Provider.of<GroupController>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(LineAwesomeIcons.edit_1),
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: _future,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final ProGroup group = snap.data![0];
              final List<GroupUser> groupUsers = snap.data![1];
              schedules = schedules.isEmpty ? snap.data![2] : schedules;
              final image = group.image != null
                  ? Image.network(group.image!)
                  : const FlutterLogo(
                      size: 100.0,
                    );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: size.width,
                  ),
                  image,
                  const SizedBox(
                    height: 8,
                  ),
                  Text(group.name),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        ChoiceChip(
                          label: const Text('Miembros'),
                          selected: groupController.viewIndex == 0,
                          onSelected: (v) => groupController.changeView(0),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        ChoiceChip(
                          label: const Text('Horarios'),
                          selected: groupController.viewIndex == 1,
                          onSelected: (v) => groupController.changeView(1),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        ChoiceChip(
                          label: const Text('Sesiones pasadas'),
                          selected: groupController.viewIndex == 2,
                          onSelected: (v) => groupController.changeView(2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (groupController.viewIndex == 0)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton.icon(
                          onPressed: () => groupController.share(group),
                          icon: const Icon(LineAwesomeIcons.user_plus),
                          label: const Text('Invitar'),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount: groupUsers.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                          ),
                          itemBuilder: (context, index) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (groupUsers[index].user.image != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    groupUsers[index].user.image!,
                                    width: (size.width / 3) - 16,
                                    height: (size.width / 3) - 32,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              const SizedBox(
                                height: 4,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  groupUsers[index].user.fullName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (groupController.viewIndex == 1)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () async {
                            final schedule = await context.pushNamed<Schedule>(
                              'schedule-add',
                              queryParameters: {
                                'group': [group.id.toString()]
                              },
                            );
                            if (schedule != null) {
                              schedules.add(schedule);
                            }
                          },
                          child: const Text('Crear un horario'),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: schedules.length,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(schedules[index].name),
                            subtitle: Text(schedules[index].timeString),
                            trailing: const Icon(LineAwesomeIcons.angle_right),
                            onTap: () => context.pushNamed(
                              'schedule',
                              pathParameters: {
                                'id': schedules[index].id.toString(),
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
