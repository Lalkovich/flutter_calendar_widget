import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/core/recources/app_strings.dart';
import 'package:flutter_calendar_widget/presentation/calendar_screen/widgets/calendar_widget.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const WidgetbookMain());
}

class WidgetbookMain extends StatelessWidget {
  const WidgetbookMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [],
      directories: [
        WidgetbookFolder(
          name: AppStrings.widgetFolderName,
          children: [
            WidgetbookComponent(
                name: AppStrings.calendarComponentName,
                useCases: [
                  WidgetbookUseCase(
                      name: AppStrings.calendarUseCase,
                      builder: (context) => const CalendarWidget()),
                ]),
          ],
        )
      ],
    );
  }
}
