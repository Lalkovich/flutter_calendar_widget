import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/presentation/calendar_screen/widgets/calendar_widget.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const HotReload());
}

class HotReload extends StatelessWidget {
  const HotReload({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [],
      directories: [
        WidgetbookFolder(
          name: 'Widgets',
          children: [
            WidgetbookComponent(name: 'Calendar', useCases: [
              WidgetbookUseCase(
                  name: 'CalendarUseCase',
                  builder: (context) => const CalendarWidget()),
            ]),
          ],
        )
      ],
    );
  }
}
