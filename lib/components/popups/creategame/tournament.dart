import 'package:ajedrez/pages/menus_pages/manage_tournaments.dart';
import 'package:flutter/material.dart';
import '../../communications/api.dart';
import '../../visual/screen_size.dart';
import '../../buttons/home/play.dart';
import '../../buttons/home/selection.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';

class Tournament {
  static final SelectionMenu<int> selectRound = SelectionMenu(
    ["2 rondas", "3 rondas", "4 rondas"],
    [2, 3, 4],
    "2 rondas",
  );
  static final SelectionMenu<int> selectTime = SelectionMenu(
    ["3 minutos", "5 minutos", "10 minutos"],
    [180, 300, 600],
    "5 minutos",
  );
  static final SelectionMenu<int> selectIncrement = SelectionMenu(
    ["3 segundos", "5 segundos", "10 segundos"],
    [3, 5, 10],
    "5 segundos",
  );
  final TextEditingController roomController = TextEditingController();
  String visualDate = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
  String backDate = "null";
  bool dateUpdate = false;

  Object popupTOURNAMENT(BuildContext context) {
    roomController.text = "";
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        contentPadding: EdgeInsets.all(defaultWidth * 0.05),
        content: SizedBox(
          width: defaultWidth * 0.85,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Crea un torneo ...",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: defaultWidth * 0.05),
              SelectionMenu.rowOption(
                  context, "Rondas:", selectRound.selectionMenu(context)),
              SizedBox(height: defaultWidth * 0.05),
              SelectionMenu.rowOption(
                  context, "Duración:", selectTime.selectionMenu(context)),
              SizedBox(height: defaultWidth * 0.05),
              SelectionMenu.rowOption(context, "Incremento:",
                  selectIncrement.selectionMenu(context)),
              SizedBox(height: defaultWidth * 0.05),
              SelectionMenu.rowOption(context, "Fecha:", selectDate(context)),
              SizedBox(height: defaultWidth * 0.05),
              playButton(context, "Crear", () async {
                int error = await apiCreateTournament(
                    backDate,
                    selectRound.selectedCorrectValue,
                    selectTime.selectedCorrectValue,
                    selectIncrement.selectedCorrectValue);
                if (context.mounted) {
                  if (error == 0) {
                    popupResultCreate(context, "Torneo creado exitosamente");
                  } else if (error == 400) {
                    popupResultCreate(context,
                        "La hora de inicio debe ser al menos 15 minutos después de la actual");
                  } else if (error == 409) {
                    popupResultCreate(context,
                        "No se puede crear un torneo mientras hay otro activo");
                  } else {
                    popupResultCreate(context,
                        "Ha surgido un error a la hora de crear torneo");
                  }
                }
              }),
              SizedBox(height: defaultWidth * 0.075),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Theme.of(context).colorScheme.primary,
                      thickness: 1.25,
                      indent: defaultWidth * 0.05,
                      endIndent: defaultWidth * 0.05,
                    ),
                  ),
                  Text(
                    " o ",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Theme.of(context).colorScheme.primary,
                      thickness: 1.25,
                      indent: defaultWidth * 0.05,
                      endIndent: defaultWidth * 0.05,
                    ),
                  ),
                ],
              ),
              SizedBox(height: defaultWidth * 0.05),
              Text(
                "... compite en otros existentes",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: defaultWidth * 0.05),
              playButton(
                context,
                "Gestionar torneos",
                () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ManageTournamentPage(),
                    ),
                  ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  dateTimePickerWidget(BuildContext context) {
    return DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMMM yyyy HH:mm',
      initialDateTime: DateTime.now(),
      minDateTime: DateTime.now(),
      maxDateTime: DateTime(3000),
      onMonthChangeStartWithFirstDate: true,
      onConfirm: (dateTime, List<int> index) {
        DateTime selectdate = dateTime;
        visualDate = DateFormat('dd-MM-yyyy HH:mm').format(selectdate);
        backDate =
            "${DateFormat('yyyy').format(selectdate)}-${DateFormat('MM').format(selectdate)}-${DateFormat('dd').format(selectdate)}T${DateFormat('HH').format(selectdate)}:${DateFormat('mm').format(selectdate)}:00.000Z";
      },
      onClose: () => dateUpdate = true,
    );
  }

  Widget selectDate(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return GestureDetector(
        onTap: () {
          dateTimePickerWidget(context);
          waitCode().then((value) {
            setState(() {});
            dateUpdate = false;
          });
        },
        child: Container(
          width: defaultWidth * 0.4,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1.25,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Center(
            child: Text(
              visualDate,
              style: TextStyle(
                fontSize: 19,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<void> waitCode() async {
    while (!dateUpdate) {
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  Object popupResultCreate(BuildContext context, String text) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          contentPadding: EdgeInsets.all(defaultWidth * 0.05),
          content: SizedBox(
            width: defaultWidth * 0.85,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 19,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: defaultWidth * 0.05),
              playButton(context, "Ok", () => Navigator.pop(context)),
            ]),
          ),
        ),
      ),
    );
  }
}
