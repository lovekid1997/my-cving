import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_cving/app/config/constant.dart';

enum CountNumberType {
  begin0AndCountEven,
  begin1AndCountEven,
  begin0AndCountOdd,
  begin1AndCountOdd,
}

enum CountNumberStyle {
  startingFromZero,
  notStartingFromZero,
}

enum TableElementType {
  number,
  text,
}

class _Data {
  final CountNumberStyle? countNumberStyle;
  final CountNumberType? countNumberType;
  final String? text;
  final TableElementType type;

  _Data(
    this.type, {
    this.countNumberStyle,
    this.countNumberType,
    this.text,
  });

  _Data copyWith({
    CountNumberStyle? countNumberStyle,
    CountNumberType? countNumberType,
    String? text,
  }) {
    return _Data(
      type,
      countNumberStyle: countNumberStyle,
      countNumberType: countNumberType,
      text: text,
    );
  }
}

class ButtonQuickCreateTable extends StatefulWidget {
  const ButtonQuickCreateTable({super.key});

  @override
  State<ButtonQuickCreateTable> createState() => _ButtonQuickCreateTableState();
}

class _ButtonQuickCreateTableState extends State<ButtonQuickCreateTable> {
  bool hasData = false;
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
        _Format(
          hasValueCallBack: (bool value) {
            hasData = value;
            setState(() {});
          },
        ),
        kHeight20,
        _InputCountNumber(
          hasData: hasData,
          countNumberController: countNumberController,
        ),
        kHeight20,
        if (int.tryParse(countNumberController.text) != null)
          FilledButton.tonal(
            onPressed: () {},
            child: const Text('Generate'),
          ),
      ],
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

class _Format extends StatefulWidget {
  const _Format({required this.hasValueCallBack});
  final ValueChanged<bool> hasValueCallBack;
  @override
  State<_Format> createState() => _FormatState();
}

class _FormatState extends State<_Format> {
  final List<Widget> widgetsData = [];
  final List<_Data> data = [];
  @override
  Widget build(BuildContext context) {
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
                        countNumberStyle: value.countNumberStyle,
                        countNumberType: value.countNumberType,
                      );
                    },
                  );
                case TableElementType.text:
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
              data.add(_Data(
                result!,
              ));
              widget.hasValueCallBack(true);
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
  final ValueChanged<_Data> valueChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(
          width: 100,
          height: 56,
          child: TextField(
            decoration: InputDecoration(
              label: Text('Text'),
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
  final ValueChanged<_Data> valueChanged;
  @override
  State<_CountNumberWidget> createState() => _CountNumberWidgetState();
}

class _CountNumberWidgetState extends State<_CountNumberWidget> {
  var currentCountNumberStyle = CountNumberStyle.startingFromZero;
  var currentCountNumberType = CountNumberType.begin1AndCountEven;
  @override
  void initState() {
    callBack();
    super.initState();
  }

  void callBack() {
    widget.valueChanged(_Data(
      TableElementType.number,
      countNumberStyle: currentCountNumberStyle,
      countNumberType: currentCountNumberType,
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
              children: CountNumberStyle.values
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
              children: CountNumberType.values
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
