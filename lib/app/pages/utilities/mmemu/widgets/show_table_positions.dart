import 'package:flutter/material.dart';
import 'package:my_cving/app/config/constant.dart';
import 'package:my_cving/app/pages/utilities/mmemu/elements/table_position.dart';
import 'package:my_cving/app/pages/utilities/mmemu/providers/create_table_providers.dart';
import 'package:provider/provider.dart';

class ShowTablePositions extends StatelessWidget {
  const ShowTablePositions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TableProviders>(
      builder: (context, tableProvider, child) {
        final positions = tableProvider.positions;
        return AnimatedContainer(
          duration: kDuration300ml,
          child: Wrap(
            children: positions.positions
                .asMap()
                .map((key, tablePosition) => MapEntry(
                    key,
                    SizedBox(
                      width: 200,
                      child: RadioListTile<String?>(
                        groupValue: tableProvider.selectedPosition?.name,
                        onChanged: (value) {
                          tableProvider.changeSelectedTablePosition(
                              TablePosition(value!));
                        },
                        value: tablePosition.name,
                        title: Text(tablePosition.name),
                      ),
                    )))
                .values
                .toList(),
          ),
        );
      },
    );
  }
}
