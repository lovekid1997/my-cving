import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_cving/app/config/constant.dart';
import 'package:my_cving/app/pages/utilities/mmemu/providers/create_table_providers.dart';
import 'package:my_cving/app/pages/utilities/mmemu/providers/restaurant_providers.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:provider/provider.dart';

class ButtonQuickCreateTable extends StatefulWidget {
  const ButtonQuickCreateTable({super.key});

  @override
  State createState() => ButtonQuickCreateTableState();
}

class ButtonQuickCreateTableState extends State<ButtonQuickCreateTable> {
  final countNumberController = TextEditingController();
  @override
  void initState() {
    countNumberController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Format(),
        kHeight20,
        Row(
          children: [
            _InputCountNumber(
              countNumberController: countNumberController,
            ),
            kWidth20,
            if (int.tryParse(countNumberController.text) != null)
              FilledButton.tonal(
                onPressed: () {
                  TableProviders.of(context)
                      .generate(int.parse(countNumberController.text));
                },
                child: const Text('Generate'),
              ),
            kWidth20,
            const Expanded(child: _TableGenerated()),
          ],
        ),
        kHeight20,
      ],
    );
  }
}

class _TableGenerated extends StatelessWidget {
  const _TableGenerated();
  @override
  Widget build(BuildContext context) {
    return Consumer<TableProviders>(
      builder: (context, tableProvider, child) {
        final generated = tableProvider.generated;
        if (generated.isEmpty) {
          return const SizedBox();
        }
        return IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: generated.map((e) => Text(e)).toList(),
              ),
              kHeight12,
              LinearProgressIndicator(
                value: tableProvider.progress,
              ),
              kHeight12,
              if (tableProvider.isLoading)
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Đang tải ...'),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                )
              else
                ElevatedButton(
                  onPressed: () {
                    TableProviders.of(context).createTable(
                      generated: generated,
                      restaurantId: RestaurantProviders.of(context)
                              .selectedRestaurant
                              ?.id ??
                          '',
                    );
                  },
                  child: const Text('Create Table'),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _InputCountNumber extends StatelessWidget {
  const _InputCountNumber({
    required this.countNumberController,
  });

  final TextEditingController countNumberController;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: kDuration300ml,
      child: SizedBox(
        width: 120,
        child: Consumer<TableProviders>(
          builder: (context, ref, child) {
            final hasData = ref.createTableElements.isNotEmpty;
            return hasData
                ? TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Số lượng'),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: countNumberController,
                    validator: (value) {
                      final parsed = int.tryParse(value ?? '');
                      if ((parsed ?? 0) > 0) {
                        return null;
                      }
                      return 'Nhập gì kì vậy';
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  )
                : const SizedBox();
          },
        ),
      ),
    );
  }
}

class _Format extends StatelessWidget {
  const _Format();
  @override
  Widget build(BuildContext context) {
    return Consumer<TableProviders>(
      builder: (context, tableProviders, child) {
        final data = tableProviders.createTableElements;
        return Row(
          children: [
            const Text('Format: '),
            kWidth20,
            AnimatedContainer(
              duration: kDuration300ml,
              height:
                  data.any((element) => element.type == TableElementType.number)
                      ? 180
                      : 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  final element = data.elementAt(index);
                  switch (element.type) {
                    case TableElementType.number:
                      return _CountNumberWidget(
                        valueChanged: (value) {
                          tableProviders.changeDependencyElementTable(
                            element.copyWith(
                              countNumberStyle: value.countNumberType,
                              countNumberType: value.countNumberMethod,
                            ),
                            index,
                          );
                        },
                      );
                    case TableElementType.text:
                      return _InputTextWidget(
                        valueChanged: (value) {
                          tableProviders.changeDependencyElementTable(
                            element.copyWith(text: value.text),
                            index,
                          );
                        },
                      );
                  }
                },
                itemCount: data.length,
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.add),
                ),
              ),
            ),
            Builder(
              builder: (iContext) {
                final iconKey = GlobalKey();
                return TextButton.icon(
                  key: iconKey,
                  label: const Text('Thêm'),
                  onPressed: () async {
                    final renderObject =
                        iconKey.currentContext!.findRenderObject() as RenderBox;
                    final result = await showMenu<TableElementType>(
                      context: iContext,
                      position: RelativeRect.fromRect(
                        Rect.fromPoints(
                          renderObject.localToGlobal(Offset.zero),
                          renderObject.localToGlobal(
                              renderObject.size.bottomRight(Offset.zero)),
                        ),
                        const Rect.fromLTWH(
                          -24.0 / 2,
                          0.0,
                          double.infinity,
                          double.infinity,
                        ),
                      ),
                      items: [
                        const PopupMenuItem(
                          value: TableElementType.number,
                          child: Text('Đếm số'),
                        ),
                        const PopupMenuItem(
                          value: TableElementType.text,
                          child: Text('Nhập tay'),
                        ),
                      ],
                    );
                    if (result != null) {
                      tableProviders.addCreateTableElement(CreateTableElement(
                        result,
                        text: result == TableElementType.text ? 'A' : null,
                      ));
                    }
                  },
                  icon: const Icon(Icons.add),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _InputTextWidget extends StatelessWidget {
  const _InputTextWidget({
    required this.valueChanged,
  });
  final ValueChanged<CreateTableElement> valueChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          height: 56,
          child: TextFormField(
            initialValue: 'A',
            autovalidateMode: AutovalidateMode.always,
            validator: (value) {
              if ((value ?? '').isEmpty) {
                return 'Hic';
              }
              return null;
            },
            decoration: const InputDecoration(
              label: Text('Text'),
            ),
            onChanged: (value) => valueChanged(
              CreateTableElement(
                TableElementType.text,
                text: value,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CountNumberWidget extends StatefulWidget {
  const _CountNumberWidget({
    required this.valueChanged,
  });
  final ValueChanged<CreateTableElement> valueChanged;
  @override
  State<_CountNumberWidget> createState() => _CountNumberWidgetState();
}

class _CountNumberWidgetState extends State<_CountNumberWidget> {
  var currentCountNumberStyle = CountNumberType.startingFromZero;
  var currentCountNumberType = CountNumberMethod.begin1AndCount1;
  @override
  void initState() {
    callBack();
    super.initState();
  }

  void callBack() {
    widget.valueChanged(CreateTableElement(
      TableElementType.number,
      countNumberType: currentCountNumberStyle,
      countNumberMethod: currentCountNumberType,
    ));
  }

  @override
  Widget build(BuildContext context) {
    const width = 215.0;
    return Row(
      children: [
        SizedBox(
          width: width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: CountNumberType.values
                  .map((e) => RadioListTile(
                        value: e,
                        groupValue: currentCountNumberStyle,
                        onChanged: (e) {
                          setState(() {
                            currentCountNumberStyle = e!;
                          });
                          callBack();
                        },
                        title: Text(e.name),
                        dense: true,
                      ))
                  .toList(),
            ),
          ),
        ),
        SizedBox(
          width: width,
          child: SingleChildScrollView(
            child: Column(
              children: CountNumberMethod.values
                  .map((e) => RadioListTile(
                        value: e,
                        groupValue: currentCountNumberType,
                        onChanged: (e) {
                          setState(() {
                            currentCountNumberType = e!;
                          });
                          callBack();
                        },
                        title: Text(e.name),
                        dense: true,
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
