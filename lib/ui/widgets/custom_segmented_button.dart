import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/cupertino.dart';

class CustomSegmentedButton extends StatefulWidget {
  const CustomSegmentedButton({super.key});

  @override
  State<CustomSegmentedButton> createState() => _CustomSegmentedButtonState();
}

class _CustomSegmentedButtonState extends State<CustomSegmentedButton> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CupertinoSegmentedControl(
        borderColor: ColorPalette.black,
        pressedColor: ColorPalette.gray,
        selectedColor: ColorPalette.black,
        unselectedColor: ColorPalette.white,
        padding: const EdgeInsets.all(0),
        groupValue: index,
        children: <int, Widget>{
          0: SizedBox(
            height: 35,
            child: Center(
              child: Text(
                'Utenti',
                style: index == 0
                    ? PresetTextStyle.white15w500
                    : PresetTextStyle.black15w400,
              ),
            ),
          ),
          1: SizedBox(
            height: 35,
            child: Center(
              child: Text(
                'Squadre',
                style: index == 1
                    ? PresetTextStyle.white15w500
                    : PresetTextStyle.black15w400,
              ),
            ),
          ),
        },
        onValueChanged: (int val) => setState(() => index = val),
      ),
    );
  }
}
