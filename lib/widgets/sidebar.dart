import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:katex_flutter/katex_flutter.dart';
import 'package:resume/extensions/color.dart';
import 'package:resume/models/simulation_parameters.dart';
import 'package:resume/theme/colors/colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SimulationSidebar extends StatefulWidget {
  const SimulationSidebar({
    required this.backgroundColor,
    required this.onParametersChanged,
  });

  final Color backgroundColor;
  final ValueChanged<SimulationParameters> onParametersChanged;

  @override
  State<SimulationSidebar> createState() => _SimulationSidebarState();
}

class _SimulationSidebarState extends State<SimulationSidebar> {
  @override
  Widget build(BuildContext context) {
    final parameters = SimulationParameters.of(context);
    bool first = false;

    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor.lighten(0.1),
        boxShadow: [
          BoxShadow(
            color: widget.backgroundColor.darken(0.4).withOpacity(0.15),
            blurRadius: 15,
            spreadRadius: 5,
          )
        ],
      ),
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(
              'assets/images/me.png',
            ),
            radius: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Richard Mathieson',
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => launchUrlString('https://github.com/rlch'),
                icon: Icon(AntDesign.github),
                color: NordColors.aurora.purple,
              ),
              IconButton(
                onPressed: () =>
                    launchUrlString('https://www.linkedin.com/in/rjmath/'),
                icon: Icon(AntDesign.linkedin_square),
                color: NordColors.frost.darker,
              ),
              IconButton(
                onPressed: () =>
                    launchUrlString('mailto:richard@tutero.com.au'),
                icon: Icon(AntDesign.mail),
                color: NordColors.aurora.red,
              ),
            ],
          ),
          Divider(height: 20),
          Flexible(
            child: ListView(
              children: [
                for (final rangedP in parameters.rangedParameters)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (first == (first = true)) Divider(height: 20),
                      Text(
                        rangedP.title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: KaTeX(
                          laTeXCode: Text(
                            rangedP.description,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                      Slider(
                        value: rangedP(),
                        min: rangedP.min,
                        max: rangedP.max,
                        label: rangedP().round().toString(),
                        divisions: 10,
                        onChanged: (v) {
                          rangedP.value = v;
                          widget.onParametersChanged(parameters);
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
