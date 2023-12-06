import 'package:awesome_bottom_bar/chip_style.dart';
import 'package:awesome_bottom_bar/count_style.dart';
import 'package:awesome_bottom_bar/widgets/hexagon/hexagon.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:awesome_bottom_bar/widgets/inspired/transition_container.dart';
import 'package:flutter/material.dart';
import 'package:wena_partners/vendor/styles/colors.dart';
import 'package:wena_partners/vendor/styles/sizes.dart';
import 'package:wena_partners/vendor/styles/theme.dart';


class CustomTabItem<Widget> {
  final Widget icon;
  final String? title;
  final Widget? count;
  final String? key;

  const CustomTabItem({
    required this.icon,
    this.title,
    this.count,
    this.key,
  }) : assert(icon is ImageIcon || icon is Widget,
            'TabItem only support IconData and Widget');
}

class CustomBuildIcon extends StatelessWidget {
  final CustomTabItem item;
  final double iconSize;
  final Color iconColor;
  final CountStyle? countStyle;

  const CustomBuildIcon({
    Key? key,
    required this.item,
    required this.iconColor,
    this.iconSize = 22,
    this.countStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return item.icon;
  }
}

class CustomBottomBarInspiredOutside extends StatefulWidget {
  final List<CustomTabItem> items;

  final double? height;
  final Color backgroundColor;
  final double? elevation;
  final bool fixed;
  final int indexSelected;
  final Function(int index)? onTap;
  final Color color;
  final Color colorSelected;
  final double iconSize;
  final TextStyle? titleStyle;
  final CountStyle? countStyle;
  final ChipStyle? chipStyle;
  final ItemStyle? itemStyle;
  final List<BoxShadow>? boxShadow;
  final BorderRadius? borderRadius;
  final double? top;
  final bool animated;
  final bool isAnimated;
  final Duration? duration;
  final Curve? curve;
  final double? sizeInside;
  final double? padTop;
  final double? padbottom;
  final double? pad;
  final double? radius;
  final int? fixedIndex;
  const CustomBottomBarInspiredOutside({
    Key? key,
    required this.items,
    required this.backgroundColor,
    required this.color,
    required this.colorSelected,
    this.height = 40,
    this.elevation,
    this.fixed = false,
    this.indexSelected = 0,
    this.onTap,
    this.iconSize = 22,
    this.titleStyle,
    this.countStyle,
    this.chipStyle,
    this.itemStyle,
    this.borderRadius,
    this.boxShadow,
    this.top,
    this.animated = true,
    this.duration,
    this.curve,
    this.sizeInside = 48,
    this.isAnimated = true,
    this.padTop = 12,
    this.padbottom = 12,
    this.pad = 4,
    this.radius = 0,
    this.fixedIndex = 0,
  }) : super(key: key);

  @override
  _BottomBarInspiredOutsideState createState() =>
      _BottomBarInspiredOutsideState();
}

class _BottomBarInspiredOutsideState
    extends State<CustomBottomBarInspiredOutside> {
  @override
  Widget build(BuildContext context) {
    return Inspired(
      height: widget.height!,
      count: widget.items.length,
      background: widget.backgroundColor,
      fixed: widget.fixed,
      elevation: widget.elevation,
      animated: widget.animated,
      isAnimated: widget.animated,
      pad: widget.pad,
      padTop: widget.padTop,
      padbottom: widget.padbottom,
      radius: widget.radius,
      shadowColor: const Color(colorContent).withOpacity(0.5),
      fixedIndex: widget.fixedIndex,
      itemBuilder: (_, int index, bool active) => buildItem(
        context,
        item: widget.items[index],
        index: index,
        isSelected: index == widget.indexSelected,
      ),
      initialActive: widget.indexSelected,
      iconChip: (int index) => widget.items[index].icon,
      onTap: widget.onTap,
      chipStyle: widget.chipStyle ??
          const ChipStyle(notchSmoothness: NotchSmoothness.defaultEdge),
      curveSize: 70,
      top: widget.top ?? -28,
      containerSize: 56,
      itemStyle: widget.itemStyle,
    );
  }

  Widget buildItem(
    BuildContext context, {
    required CustomTabItem item,
    required int index,
    bool isSelected = false,
  }) {
    Color itemColor() {
      if (widget.fixed) {
        return isSelected ? widget.chipStyle!.background! : widget.color;
      }
      return isSelected ? widget.colorSelected : widget.color;
    }

    if (widget.fixed ? widget.fixedIndex == index : isSelected) {
      if (widget.animated) {
        return TransitionContainer.scale(
          data: index,
          duration: widget.duration ?? const Duration(milliseconds: 350),
          curve: widget.curve ?? Curves.easeInOut,
          child: buildContentItem(
              item, itemColor(), widget.iconSize, widget.sizeInside!),
        );
      }
      return buildContentItem(
          item, itemColor(), widget.iconSize, widget.sizeInside!);
    }
    return Container(
      padding: EdgeInsets.only(bottom: widget.padbottom!, top: widget.padTop!),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomBuildIcon(
            item: item,
            iconColor: itemColor(),
            iconSize: widget.iconSize,
            countStyle: widget.countStyle,
          ),
        ],
      ),
    );
  }

  Widget buildContentItem(
      CustomTabItem item, Color itemColor, double iconSize, double sizeInside) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.itemStyle == ItemStyle.circle)
          Container(
            width: sizeInside,
            height: sizeInside,
            decoration: BoxDecoration(
                color: widget.chipStyle?.background!, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: CustomBuildIcon(
              item: item,
              iconColor: widget.fixed ? widget.colorSelected : itemColor,
              iconSize: iconSize,
              countStyle: widget.countStyle,
            ),
          ),
        if (widget.itemStyle == ItemStyle.hexagon)
          HexagonWidget(
            width: sizeInside,
            height: sizeInside,
            cornerRadius: 8,
            color: widget.chipStyle?.background ?? Colors.blue,
            child: CustomBuildIcon(
              item: item,
              iconColor: widget.fixed ? widget.colorSelected : itemColor,
              iconSize: iconSize,
              countStyle: widget.countStyle,
            ),
          ),
        if (item.title is String && item.title != '') ...[
          SizedBox(
            height: dimen05,
          ),
          Text(
            item.title!,
            style: textSegoeUiColorSecondarySize16,
            textAlign: TextAlign.center,
          )
        ],
      ],
    );
  }
}
