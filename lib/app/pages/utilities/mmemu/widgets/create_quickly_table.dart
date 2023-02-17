import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_cving/app/config/constant.dart';
import 'package:my_cving/app/pages/utilities/mmemu/providers/create_table_providers.dart';

class ButtonQuickCreateTable extends ConsumerStatefulWidget {
  const ButtonQuickCreateTable({super.key});

  @override
  ButtonQuickCreateTableState createState() => ButtonQuickCreateTableState();
}

class ButtonQuickCreateTableState
    extends ConsumerState<ButtonQuickCreateTable> {
  bool hasData = true;
  final countNumberController = TextEditingController();
  final List<String> generated = [];
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
        _Format(
          hasValueCallBack: (bool value) {
            hasData = value;
            setState(() {});
          },
        ),
        kHeight20,
        Row(
          children: [
            _InputCountNumber(
              hasData: hasData,
              countNumberController: countNumberController,
            ),
            kWidth20,
            if (int.tryParse(countNumberController.text) != null)
              FilledButton.tonal(
                onPressed: () {
                  final provider = ref.read(createTableProviders.notifier);
                  generated
                    ..clear()
                    ..addAll(provider
                        .generate(int.parse(countNumberController.text)));
                  setState(() {});
                },
                child: const Text('Generate'),
              ),
            kWidth20,
            Expanded(child: _TableGenerated(generated: generated)),
          ],
        ),
        kHeight20,
      ],
    );
  }
}

class _TableGenerated extends StatelessWidget {
  const _TableGenerated({
    required this.generated,
  });
  final List<String> generated;
  @override
  Widget build(BuildContext context) {
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
          const LinearProgressIndicator(
            value: .7,
          ),
          TextButton(
            onPressed: () {
              final a = CreateTableProgress();
              a.createTable(generated, '');
            },
            child: const Text('test'),
          ),
        ],
      ),
    );
  }
}

class _InputCountNumber extends StatelessWidget {
  const _InputCountNumber({
    required this.hasData,
    required this.countNumberController,
  });

  final bool hasData;
  final TextEditingController countNumberController;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: kDuration300ml,
      child: SizedBox(
        width: 120,
        child: hasData
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
            : null,
      ),
    );
  }
}

class _Format extends ConsumerWidget {
  const _Format({required this.hasValueCallBack});
  final ValueChanged<bool> hasValueCallBack;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createTableProvider = ref.watch(createTableProviders.notifier);
    final List<CreateTableElement> data = createTableProvider.data;
    return Row(
      children: [
        const Text('Format: '),
        kWidth20,
        AnimatedContainer(
          duration: kDuration300ml,
          height: data.any((element) => element.type == TableElementType.number)
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
                      data[index] = element.copyWith(
                        countNumberStyle: value.countNumberType,
                        countNumberType: value.countNumberMethod,
                      );
                    },
                  );
                case TableElementType.text:
                  data[index] = element.copyWith(text: 'A');
                  return _InputTextWidget(
                    valueChanged: (value) {
                      data[index] = element.copyWith(text: value.text);
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
        Builder(builder: (iContext) {
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
              data.add(CreateTableElement(
                result!,
              ));
              hasValueCallBack(true);
            },
            icon: const Icon(Icons.add),
          );
        }),
      ],
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
