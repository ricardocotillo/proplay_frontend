import 'package:flutter/material.dart';
import 'package:proplay/models/schedule.model.dart';
import 'package:proplay/models/session.model.dart';
import 'package:proplay/models/sessionuser.model.dart';
import 'package:proplay/models/user.model.dart';
import 'package:proplay/services/auth.service.dart';
import 'package:proplay/services/schedule.service.dart';
import 'package:proplay/services/session.service.dart';
import 'package:proplay/services/sessionuser.service.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({
    super.key,
    required this.id,
  });
  final int id;

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  final authService = AuthService();
  final scheduleService = ScheduleService();
  final sessionService = SessionService();
  final sessionUserService = SessionUserService();
  Future<List>? _future;
  Schedule? s;
  Session? session;
  List<SessionUser> sessionUsers = [];
  User? me;

  Future<List> populate() async {
    var res = await Future.wait([
      scheduleService.retrieve(widget.id),
      sessionService.list({'schedule': widget.id.toString()})
    ]);
    final sche = res.first as Schedule;
    final sess = res.last as List<Session>;
    Session? nextSess;
    var su = <SessionUser>[];
    if (sess.isNotEmpty && sess.last.date.compareTo(sche.nextDate) < 0) {
      nextSess = sess.last;
      su = await sessionUserService.list({'session': nextSess.id.toString()});
    }
    final user = await authService.me();
    return [sche, nextSess, user, su];
  }

  @override
  void initState() {
    super.initState();
    _future = populate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(s?.name ?? ''),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snap) {
          if (ConnectionState.done == snap.connectionState) {
            s = snap.data?.first;
            session = snap.data?[1];
            me = snap.data?[2];
            sessionUsers = snap.data?.last;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(children: [
                        const TextSpan(text: 'Dirección: '),
                        TextSpan(text: s?.address ?? ''),
                      ]),
                    ),
                    const SizedBox(height: 8.0),
                    Text.rich(
                      TextSpan(children: [
                        const TextSpan(text: 'Día: '),
                        TextSpan(text: s?.dayString ?? ''),
                      ]),
                    ),
                    const SizedBox(height: 8.0),
                    Text.rich(
                      TextSpan(children: [
                        const TextSpan(text: 'Hora: '),
                        TextSpan(text: s?.timeString ?? ''),
                      ]),
                    ),
                    const SizedBox(height: 24.0),
                    if (sessionUsers.isEmpty)
                      const Text(
                        'Lista vacía',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    if (sessionUsers.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: sessionUsers.length,
                        itemBuilder: (context, index) => ListTile(
                          leading: Text((index + 1).toString()),
                          title: Text(sessionUsers[index].user?.fullName ?? ''),
                        ),
                      ),
                    const SizedBox(height: 8.0),
                    if (sessionUsers.indexWhere((su) => su.user?.id == me?.id) <
                        0)
                      TextButton(
                        onPressed: () async {
                          final sessions = await sessionService
                              .list({'schedule': s?.id.toString()});
                          Session session = sessions.isNotEmpty
                              ? sessions.last
                              : await sessionService.create(Session(
                                  id: 0,
                                  schedule: s!.id,
                                  amount: s?.amount,
                                  address: s!.address,
                                  date: s!.nextDate));
                          final u = await authService.me();
                          var sessionUser = SessionUser(
                            id: 0,
                            session: session.id,
                            userId: u.id,
                            order: 0,
                          );
                          sessionUser =
                              await sessionUserService.create(sessionUser);
                          setState(() {
                            sessionUsers.add(sessionUser);
                          });
                        },
                        child: const Text('Agregar'),
                      ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
