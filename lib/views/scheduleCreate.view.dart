import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:proplay/providers/scheduleCreate.provider.dart';
import 'package:provider/provider.dart';

class ScheduleCreateView extends StatelessWidget {
  ScheduleCreateView({
    super.key,
  });
  final _formKey = GlobalKey<FormState>();
  final timeFormatter = MaskTextInputFormatter(
    mask: '##:##',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
    type: MaskAutoCompletionType.eager,
  );

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScheduleCreateProvider>(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crea un horario'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator:
                      ValidationBuilder(localeName: 'es').required().build(),
                  decoration: const InputDecoration(
                    label: Text('Nombre'),
                  ),
                  onSaved: (v) => provider.name = v,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Dirección'),
                  ),
                  onSaved: (v) => provider.address = v,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: ValidationBuilder(localeName: 'es').build(),
                  decoration: const InputDecoration(
                    label: Text('Precio total'),
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (v) => provider.amount = v,
                ),
                const SizedBox(
                  height: 8,
                ),
                DropdownButtonFormField(
                  value: provider.day,
                  hint: const Text('Día de la semana'),
                  items: const [
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Lunes'),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('Martes'),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text('Miércoles'),
                    ),
                    DropdownMenuItem(
                      value: 4,
                      child: Text('Jueves'),
                    ),
                    DropdownMenuItem(
                      value: 5,
                      child: Text('Viernes'),
                    ),
                    DropdownMenuItem(
                      value: 6,
                      child: Text('Sábado'),
                    ),
                    DropdownMenuItem(
                      value: 7,
                      child: Text('Domingo'),
                    ),
                  ],
                  onChanged: (v) {
                    provider.day = v;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: provider.timeController,
                  validator:
                      ValidationBuilder(localeName: 'es').required().build(),
                  decoration: const InputDecoration(
                    label: Text('Hora'),
                  ),
                  inputFormatters: [
                    timeFormatter,
                  ],
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    provider.time = time;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator:
                      ValidationBuilder(localeName: 'es').required().build(),
                  decoration: const InputDecoration(
                    label: Text('Número de jugadores'),
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (v) => provider.numberOfPlayers = v,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                DropdownButtonFormField(
                  value: provider.openDay,
                  hint: const Text('Día de apertura'),
                  items: const [
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Lunes'),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('Martes'),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text('Miércoles'),
                    ),
                    DropdownMenuItem(
                      value: 4,
                      child: Text('Jueves'),
                    ),
                    DropdownMenuItem(
                      value: 5,
                      child: Text('Viernes'),
                    ),
                    DropdownMenuItem(
                      value: 6,
                      child: Text('Sábado'),
                    ),
                    DropdownMenuItem(
                      value: 7,
                      child: Text('Domingo'),
                    ),
                  ],
                  onChanged: (v) {
                    provider.openDay = v;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: provider.openTimeController,
                  validator:
                      ValidationBuilder(localeName: 'es').required().build(),
                  decoration: const InputDecoration(
                    label: Text('Hora de apertura'),
                  ),
                  inputFormatters: [
                    timeFormatter,
                  ],
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    provider.openTime = time;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          final schedule = await provider.create();
                          if (context.mounted) {
                            context.pop(schedule);
                          }
                        }
                      },
                      color: theme.colorScheme.primary,
                      textColor: theme.colorScheme.onPrimary,
                      child: const Text('Crear'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
