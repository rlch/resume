import 'package:flutter/material.dart';

import 'theme/themes/theme.dart';
import 'widgets/canvas.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Richard Mathieson',
      theme: NordTheme.light(),
      darkTheme: NordTheme.dark(),
      themeMode: ThemeMode.system,
      home: CanvasScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
