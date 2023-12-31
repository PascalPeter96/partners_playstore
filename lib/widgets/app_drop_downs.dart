
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wena_partners/app_style/app_theme.dart';
import 'package:wena_partners/vendor/models/general/wena_models.dart';
import 'package:wena_partners/widgets/custom_elevated_image.dart';
import 'package:wena_partners/widgets/custom_icon_holder.dart';

import 'package:dropdown_textfield/dropdown_textfield.dart';




class CustomDropdownFilter extends StatelessWidget {
  const CustomDropdownFilter({
    super.key,
    required this.menuItems,
    this.onChanged,
    required this.bgColor,
    required this.icon,
    this.size,
    this.radius = 10,
  });

  final List<String> menuItems;
  final Function(String?)? onChanged;
  final Color bgColor;
  final IconData icon;
  final double? size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: CustomIconHolder(
          width: 35,
          height: 35,
          radius: radius,
          size: size,
          bgColor: bgColor,
          graphic: icon,
        ),
        items: menuItems
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ))
            .toList(),
        onChanged: onChanged,
        dropdownStyleData: DropdownStyleData(
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          offset: const Offset(-60, -6),
        ),
      ),
    );
  }
}

class CustomDropdownAction extends StatelessWidget {
  const CustomDropdownAction({
    super.key,
    required this.menuItems,
    this.onChanged,
    required this.bgColor,
    required this.image,
    this.isNetwork = false,
  });

  final List<String> menuItems;
  final Function(String?)? onChanged;
  final Color bgColor;
  final image;
  final bool isNetwork;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: CustomElevatedImage(
          image,
          width: 40,
          height: 40,
          isNetwork: isNetwork,
          radius: 10,
        ),
        items: menuItems
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ))
            .toList(),
        onChanged: onChanged,
        dropdownStyleData: DropdownStyleData(
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          offset: const Offset(-60, -6),
        ),
      ),
    );
  }
}

class SearchableDropDown<T> extends StatelessWidget {
  const SearchableDropDown(
      {super.key,
        required this.hintText,
        required this.menuItems,
        this.onChanged,
        this.defaultValue,
        required this.controller});

  final String hintText;
  final List<T> menuItems;
  final T? defaultValue;
  final Function(dynamic)? onChanged;
  final SingleValueDropDownController controller;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return Container(
      height: 10.h,
      margin: const EdgeInsets.only(bottom: 10),
      child: DropDownTextField(
        controller: controller,
        enableSearch: true,
        dropdownColor: Colors.white,
        textFieldDecoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.borderColor2,
          hintText: 'Select $hintText',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        searchDecoration: InputDecoration(hintText: "Search $hintText"),
        validator: (value) {
          if (value == null) {
            return "Required field";
          } else {
            return null;
          }
        },
        dropDownItemCount: 6,
        autovalidateMode: AutovalidateMode.always,
        dropDownList: menuItems
            .map(
                (item) => DropDownValueModel(value: item, name: item.toString()))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}



class SearchableProductVariantsDropDown<T extends WenaStoreProductVariants> extends StatelessWidget {
  const SearchableProductVariantsDropDown(
      {super.key,
        required this.hintText,
        required this.menuItems,
        this.onChanged,
        this.defaultValue,
        required this.controller});

  final String hintText;
  final List<T> menuItems;
  final T? defaultValue;
  final Function(dynamic)? onChanged;
  final SingleValueDropDownController controller;
  // final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return Container(
      height: 10.h,
      // margin: const EdgeInsets.only(bottom: 10),
      child: DropDownTextField(

        controller: controller,
        enableSearch: true,
        dropdownColor: Colors.white,
        textFieldDecoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.borderColor2,
          hintText: 'Select $hintText',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.sp),
            borderSide: BorderSide.none,
          ),
        ),
        searchDecoration: InputDecoration(hintText: "Search $hintText"),
        validator: (value) {
          if (value == null) {
            return "Required field";
          } else {
            return null;
          }
        },
        dropDownItemCount: 6,
        autovalidateMode: AutovalidateMode.always,
        dropDownList: menuItems
            .map(
                (item) => DropDownValueModel(value: item, name: item.getName()))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}


class CustomGenericSearchableDropDown<T extends WenaModel> extends StatelessWidget {
  const CustomGenericSearchableDropDown(
      {super.key,
        required this.hintText,
        required this.menuItems,
        this.onChanged,
        this.defaultValue,
        required this.controller});

  final String hintText;
  final List<T> menuItems;
  final T? defaultValue;
  final Function(dynamic)? onChanged;
  final SingleValueDropDownController controller;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return Container(
      height: 10.h,
      margin: const EdgeInsets.only(bottom: 10),
      child: DropDownTextField(
        controller: controller,
        enableSearch: true,
        dropdownColor: Colors.white,
        textFieldDecoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.borderColor2,
          hintText: 'Select $hintText',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.sp),
            borderSide: BorderSide.none,
          ),
        ),
        searchDecoration: InputDecoration(hintText: "Search $hintText"),
        validator: (value) {
          if (value == null) {
            return "Required field";
          } else {
            return null;
          }
        },
        dropDownItemCount: 6,
        autovalidateMode: AutovalidateMode.always,
        dropDownList: menuItems
            .map(
                (item) => DropDownValueModel(value: item, name: item.getName()))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}


class ProductVariantsApiDropdown<T extends WenaStoreProductVariants> extends StatelessWidget {
  const ProductVariantsApiDropdown(
      {super.key,
        required this.hintText,
        required this.menuItems,
        this.onChanged,
        this.height,
        this.defaultValue,
        this.validator,

      });

  final String hintText;
  final List<T> menuItems;
  final T? defaultValue;
  final Function(T?)? onChanged;
  final double? height;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return SizedBox(
      height: height ?? 8.5.h,
      child: DropdownButtonFormField2<T>(
        value: defaultValue,
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding:  EdgeInsets.symmetric(vertical: 2.h),
          filled: true,
          fillColor: AppTheme.borderColor2,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.sp),
          ),
        ),
        hint: Text(
          hintText,
          style:
          const TextStyle(color: AppTheme.inActiveColor, fontSize: 15),
        ),
        items: menuItems
            .map((item) => DropdownMenuItem<T>(
          value: item,
          child: Text(
            item.getName(),
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ))
            .toList(),
        validator: (value) {
          if (value == null) {
            return 'Please select a $hintText';
          }
          return null;
        },
        onChanged: onChanged,
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.only(right: 8),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black45,
          ),
          iconSize: 24,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}


class CustomApiGenericDropdown<T extends WenaModel> extends StatelessWidget {
  const CustomApiGenericDropdown(
      {super.key,
        required this.hintText,
        required this.menuItems,
        this.onChanged,
        this.height,
        this.defaultValue,
        this.validator,

      });

  final String hintText;
  final List<T> menuItems;
  final T? defaultValue;
  final Function(T?)? onChanged;
  final double? height;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return SizedBox(
      height: height ?? 8.5.h,
      child: DropdownButtonFormField2<T>(
        value: defaultValue,
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding:  EdgeInsets.symmetric(vertical: 2.h),
          filled: true,
          fillColor: AppTheme.borderColor2,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.sp),
          ),
        ),
        hint: Text(
          hintText,
          style:
          const TextStyle(color: AppTheme.inActiveColor, fontSize: 15),
        ),
        items: menuItems
            .map((item) => DropdownMenuItem<T>(
          value: item,
          child: Text(
            item.getName(),
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ))
            .toList(),
        validator: (value) {
          if (value == null) {
            return 'Please select a $hintText';
          }
          return null;
        },
        onChanged: onChanged,
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.only(right: 8),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black45,
          ),
          iconSize: 24,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}



class CustomGenericDropdown<T> extends StatelessWidget {
  const CustomGenericDropdown(
      {super.key,
        required this.hintText,
        required this.menuItems,
        this.onChanged,
        this.defaultValue});

  final String hintText;
  final List<T> menuItems;
  final T? defaultValue;
  final Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return Column(
      children: [
        Container(
          height: 10.h,
          child: DropdownButtonFormField2<T>(
            isExpanded: true,
            decoration: InputDecoration(
              contentPadding:  EdgeInsets.symmetric(vertical: 2.h),
              filled: true,
              fillColor: AppTheme.borderColor2,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            hint: Text(
              hintText,
              style:
              const TextStyle(color: AppTheme.inActiveColor, fontSize: 15),
            ),
            items: menuItems
                .map((item) => DropdownMenuItem<T>(
              value: item,
              child: Text(
                item.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Please select a $hintText';
              }
              return null;
            },
            onChanged: onChanged,
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.only(right: 8),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 24,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}


class SearchableTenantDropDown<T> extends StatelessWidget {
  const SearchableTenantDropDown(
      {super.key,
        required this.hintText,
        required this.menuItems,
        this.onChanged,
        this.defaultValue,
        required this.controller});

  final String hintText;
  final List<T> menuItems;
  final T? defaultValue;
  final Function(dynamic)? onChanged;
  final SingleValueDropDownController controller;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return Container(
      height: 10.h,
      margin: const EdgeInsets.only(bottom: 10),
      child: DropDownTextField(
        controller: controller,
        enableSearch: true,
        dropdownColor: Colors.white,
        textFieldDecoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.borderColor2,
          hintText: 'Select $hintText',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        searchDecoration: InputDecoration(hintText: "Search $hintText"),
        validator: (value) {
          if (value == null) {
            return "Required field";
          } else {
            return null;
          }
        },
        dropDownItemCount: 6,
        autovalidateMode: AutovalidateMode.always,
        dropDownList: menuItems
            .map(
                (item) => DropDownValueModel(value: item, name: item.toString()))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}



//
// class SearchableTenantDropDown<T extends SmartTenantModel> extends StatelessWidget {
//   const SearchableTenantDropDown(
//       {super.key,
//         required this.hintText,
//         required this.menuItems,
//         this.onChanged,
//         this.defaultValue,
//         required this.controller});
//
//   final String hintText;
//   final List<T> menuItems;
//   final T? defaultValue;
//   final Function(dynamic)? onChanged;
//   final SingleValueDropDownController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildBody();
//   }
//
//   _buildBody() {
//     return Container(
//       height: 50,
//       margin: const EdgeInsets.only(bottom: 10),
//       child: DropDownTextField(
//         controller: controller,
//         enableSearch: true,
//         dropdownColor: Colors.white,
//         textFieldDecoration: InputDecoration(
//           filled: true,
//           fillColor: AppTheme.textBoxColor,
//           hintText: 'Select $hintText',
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),
//         ),
//         searchDecoration: InputDecoration(hintText: "Search $hintText"),
//         validator: (value) {
//           if (value == null) {
//             return "Required field";
//           } else {
//             return null;
//           }
//         },
//         dropDownItemCount: 6,
//         autovalidateMode: AutovalidateMode.always,
//         dropDownList: menuItems
//             .map(
//                 (item) => DropDownValueModel(value: item, name: item.getName()))
//             .toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }
// }
//
//
// class CustomGenericDropdown<T> extends StatelessWidget {
//   const CustomGenericDropdown(
//       {super.key,
//         required this.hintText,
//         required this.menuItems,
//         this.onChanged,
//         this.defaultValue});
//
//   final String hintText;
//   final List<T> menuItems;
//   final T? defaultValue;
//   final Function(T?)? onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildBody();
//   }
//
//   _buildBody() {
//     return Column(
//       children: [
//         SizedBox(
//           height: 6.5.h,
//           child: DropdownButtonFormField2<T>(
//             isExpanded: true,
//             decoration: InputDecoration(
//               contentPadding:  EdgeInsets.symmetric(vertical: 0.5.h),
//               filled: true,
//               fillColor: AppTheme.textBoxColor,
//               border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             hint: Text(
//               hintText,
//               style:
//               const TextStyle(color: AppTheme.inActiveColor, fontSize: 15),
//             ),
//             items: menuItems
//                 .map((item) => DropdownMenuItem<T>(
//               value: item,
//               child: Text(
//                 item.toString(),
//                 style: const TextStyle(
//                   fontSize: 14,
//                 ),
//               ),
//             ))
//                 .toList(),
//             validator: (value) {
//               if (value == null) {
//                 return 'Please select a $hintText';
//               }
//               return null;
//             },
//             onChanged: onChanged,
//             buttonStyleData: const ButtonStyleData(
//               padding: EdgeInsets.only(right: 8),
//             ),
//             iconStyleData: const IconStyleData(
//               icon: Icon(
//                 Icons.arrow_drop_down,
//                 color: Colors.black45,
//               ),
//               iconSize: 24,
//             ),
//             dropdownStyleData: DropdownStyleData(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }
//
//
// class CustomApiGenericDropdown<T extends SmartModel> extends StatelessWidget {
//   const CustomApiGenericDropdown(
//       {super.key,
//         required this.hintText,
//         required this.menuItems,
//         this.onChanged,
//         this.height,
//         this.defaultValue,
//         this.validator,
//
//       });
//
//   final String hintText;
//   final List<T> menuItems;
//   final T? defaultValue;
//   final Function(T?)? onChanged;
//   final double? height;
//   final String? Function(T?)? validator;
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildBody();
//   }
//
//   _buildBody() {
//     return Column(
//       children: [
//         SizedBox(
//           height: height ?? 8.5.h,
//           child: DropdownButtonFormField2<T>(
//             value: defaultValue,
//             isExpanded: true,
//             decoration: InputDecoration(
//               contentPadding:  EdgeInsets.symmetric(vertical: 0.5.h),
//               filled: true,
//               fillColor: AppTheme.textBoxColor,
//               border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             hint: Text(
//               hintText,
//               style:
//               const TextStyle(color: AppTheme.inActiveColor, fontSize: 15),
//             ),
//             items: menuItems
//                 .map((item) => DropdownMenuItem<T>(
//               value: item,
//               child: Text(
//                 item.getName(),
//                 style: const TextStyle(
//                   fontSize: 14,
//                 ),
//               ),
//             ))
//                 .toList(),
//             validator: (value) {
//               if (value == null) {
//                 return 'Please select a $hintText';
//               }
//               return null;
//             },
//             onChanged: onChanged,
//             buttonStyleData: const ButtonStyleData(
//               padding: EdgeInsets.only(right: 8),
//             ),
//             iconStyleData: const IconStyleData(
//               icon: Icon(
//                 Icons.arrow_drop_down,
//                 color: Colors.black45,
//               ),
//               iconSize: 24,
//             ),
//             dropdownStyleData: DropdownStyleData(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//             ),
//           ),
//         ),
//         // const SizedBox(height: 10),
//       ],
//     );
//   }
// }
//
//
// class CustomPeriodApiGenericDropdown<T extends SmartPeriodModel> extends StatelessWidget {
//   const CustomPeriodApiGenericDropdown(
//       {super.key,
//         required this.hintText,
//         required this.menuItems,
//         this.onChanged,
//         this.height,
//         this.defaultValue,
//         this.validator,
//
//       });
//
//   final String hintText;
//   final List<T> menuItems;
//   final T? defaultValue;
//   final Function(T?)? onChanged;
//   final double? height;
//   final String? Function(T?)? validator;
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildBody();
//   }
//
//   _buildBody() {
//     return Column(
//       children: [
//         SizedBox(
//           height: height ?? 8.5.h,
//           child: DropdownButtonFormField2<T>(
//             value: defaultValue,
//             isExpanded: true,
//             decoration: InputDecoration(
//               contentPadding:  EdgeInsets.symmetric(vertical: 0.5.h),
//               filled: true,
//               fillColor: AppTheme.textBoxColor,
//               border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             hint: Text(
//               hintText,
//               style:
//               const TextStyle(color: AppTheme.inActiveColor, fontSize: 15),
//             ),
//             items: menuItems
//                 .map((item) => DropdownMenuItem<T>(
//               value: item,
//               child: Text(
//                 item.getName(),
//                 style: const TextStyle(
//                   fontSize: 14,
//                 ),
//               ),
//             ))
//                 .toList(),
//             validator: (value) {
//               if (value == null) {
//                 return 'Please select a $hintText';
//               }
//               return null;
//             },
//             onChanged: onChanged,
//             buttonStyleData: const ButtonStyleData(
//               padding: EdgeInsets.only(right: 8),
//             ),
//             iconStyleData: const IconStyleData(
//               icon: Icon(
//                 Icons.arrow_drop_down,
//                 color: Colors.black45,
//               ),
//               iconSize: 24,
//             ),
//             dropdownStyleData: DropdownStyleData(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//             ),
//           ),
//         ),
//         // const SizedBox(height: 10),
//       ],
//     );
//   }
// }
//
// class CustomUpdateApiGenericDropdown<T extends SmartModel> extends StatelessWidget {
//   const CustomUpdateApiGenericDropdown(
//       {super.key,
//         required this.hintText,
//         required this.menuItems,
//         this.onChanged,
//         this.height,
//         this.defaultValue,
//         this.validator,
//
//       });
//
//   final String hintText;
//   final List<T> menuItems;
//   final T? defaultValue;
//   final Function(T?)? onChanged;
//   final double? height;
//   final String? Function(T?)? validator;
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildBody();
//   }
//
//   _buildBody() {
//     return Column(
//       children: [
//         SizedBox(
//           height: height ?? 8.5.h,
//           child: DropdownButtonFormField2<T>(
//             value: defaultValue,
//             isExpanded: true,
//             decoration: InputDecoration(
//               contentPadding:  EdgeInsets.symmetric(vertical: 0.5.h),
//               filled: true,
//               fillColor: AppTheme.textBoxColor,
//               border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             hint: Text(
//               hintText,
//               style:
//               const TextStyle(color: AppTheme.inActiveColor, fontSize: 15),
//             ),
//             items: menuItems
//                 .map((item) => DropdownMenuItem<T>(
//               value: item,
//               child: Text(
//                 item.getName(),
//                 style: const TextStyle(
//                   fontSize: 14,
//                 ),
//               ),
//             ))
//                 .toList(),
//
//             // validator: (value) {
//             //   if (value == null) {
//             //     return 'Please select a $hintText';
//             //   }
//             //   return null;
//             // },
//
//             onChanged: onChanged,
//             buttonStyleData: const ButtonStyleData(
//               padding: EdgeInsets.only(right: 8),
//             ),
//             iconStyleData: const IconStyleData(
//               icon: Icon(
//                 Icons.arrow_drop_down,
//                 color: Colors.black45,
//               ),
//               iconSize: 24,
//             ),
//             dropdownStyleData: DropdownStyleData(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//             ),
//           ),
//         ),
//         // const SizedBox(height: 10),
//       ],
//     );
//   }
// }
//
//
// class CustomApiGenericTenantModelDropdown<T extends SmartTenantModel> extends StatelessWidget {
//   const CustomApiGenericTenantModelDropdown(
//       {super.key,
//         required this.hintText,
//         required this.menuItems,
//         this.onChanged,
//         this.height,
//         this.defaultValue,
//         this.validator,
//
//       });
//
//   final String hintText;
//   final List<T> menuItems;
//   final T? defaultValue;
//   final Function(T?)? onChanged;
//   final double? height;
//   final String? Function(T?)? validator;
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildBody();
//   }
//
//   _buildBody() {
//     return Column(
//       children: [
//         SizedBox(
//           height: height ?? 8.5.h,
//           child: DropdownButtonFormField2<T>(
//             isExpanded: true,
//             decoration: InputDecoration(
//               contentPadding:  EdgeInsets.symmetric(vertical: 0.5.h),
//               filled: true,
//               fillColor: AppTheme.textBoxColor,
//               border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             hint: Text(
//               hintText,
//               style:
//               const TextStyle(color: AppTheme.inActiveColor, fontSize: 15),
//             ),
//             items: menuItems
//                 .map((item) => DropdownMenuItem<T>(
//               value: item,
//               child: Text(
//                 item.getName(),
//                 style: const TextStyle(
//                   fontSize: 14,
//                 ),
//               ),
//             ))
//                 .toList(),
//             validator: (value) {
//               if (value == null) {
//                 return 'Please select a $hintText';
//               }
//               return null;
//             },
//             onChanged: onChanged,
//             buttonStyleData: const ButtonStyleData(
//               padding: EdgeInsets.only(right: 8),
//             ),
//             iconStyleData: const IconStyleData(
//               icon: Icon(
//                 Icons.arrow_drop_down,
//                 color: Colors.black45,
//               ),
//               iconSize: 24,
//             ),
//             dropdownStyleData: DropdownStyleData(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//             ),
//           ),
//         ),
//         // const SizedBox(height: 10),
//       ],
//     );
//   }
// }
//
// class CustomApiTenantTypeDropdown<T extends SmartTenantTypeModel> extends StatelessWidget {
//   const CustomApiTenantTypeDropdown(
//       {super.key,
//         required this.hintText,
//         required this.menuItems,
//         this.onChanged,
//         this.defaultValue});
//
//   final String hintText;
//   final List<T> menuItems;
//   final T? defaultValue;
//   final Function(T?)? onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildBody();
//   }
//
//   _buildBody() {
//     return Column(
//       children: [
//         SizedBox(
//           height: 8.5.h,
//           child: DropdownButtonFormField2<T>(
//             isExpanded: true,
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(vertical: 16),
//               filled: true,
//               fillColor: AppTheme.textBoxColor,
//               border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             hint: Text(
//               hintText,
//               style:
//               const TextStyle(color: AppTheme.inActiveColor, fontSize: 15),
//             ),
//             items: menuItems
//                 .map((item) => DropdownMenuItem<T>(
//               value: item,
//               child: Text(
//                 item.getName(),
//                 style: const TextStyle(
//                   fontSize: 14,
//                 ),
//               ),
//             ))
//                 .toList(),
//             validator: (value) {
//               if (value == null) {
//                 return 'Please select a $hintText';
//               }
//               return null;
//             },
//             onChanged: onChanged,
//             buttonStyleData: const ButtonStyleData(
//               padding: EdgeInsets.only(right: 8),
//             ),
//             iconStyleData: const IconStyleData(
//               icon: Icon(
//                 Icons.arrow_drop_down,
//                 color: Colors.black45,
//               ),
//               iconSize: 24,
//             ),
//             dropdownStyleData: DropdownStyleData(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }
//
//
// class CustomApiUnitDropdown<T extends SmartUnitModel> extends StatelessWidget {
//   const CustomApiUnitDropdown(
//       {super.key,
//         required this.hintText,
//         required this.menuItems,
//         this.onChanged,
//         this.defaultValue});
//
//   final String hintText;
//   final List<T> menuItems;
//   final T? defaultValue;
//   final Function(T?)? onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildBody();
//   }
//
//   _buildBody() {
//     return Column(
//       children: [
//         SizedBox(
//           height: 6.5.h,
//           child: DropdownButtonFormField2<T>(
//             isExpanded: true,
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(vertical: 16),
//               filled: true,
//               fillColor: AppTheme.textBoxColor,
//               border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             hint: Text(
//               hintText,
//               style:
//               const TextStyle(color: AppTheme.inActiveColor, fontSize: 15),
//             ),
//             items: menuItems
//                 .map((item) => DropdownMenuItem<T>(
//               value: item,
//               child: Text(
//                 item.getUnitNumber().toString(),
//                 style: const TextStyle(
//                   fontSize: 14,
//                 ),
//               ),
//             ))
//                 .toList(),
//             validator: (value) {
//               if (value == null) {
//                 return 'Please select a $hintText';
//               }
//               return null;
//             },
//             onChanged: onChanged,
//             buttonStyleData: const ButtonStyleData(
//               padding: EdgeInsets.only(right: 8),
//             ),
//             iconStyleData: const IconStyleData(
//               icon: Icon(
//                 Icons.arrow_drop_down,
//                 color: Colors.black45,
//               ),
//               iconSize: 24,
//             ),
//             dropdownStyleData: DropdownStyleData(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }
//
//
// class CustomApiCurrencyDropdown<T extends SmartCurrencyModel> extends StatelessWidget {
//   const CustomApiCurrencyDropdown(
//       {super.key,
//         required this.hintText,
//         required this.menuItems,
//         this.onChanged,
//         this.defaultValue});
//
//   final String hintText;
//   final List<T> menuItems;
//   final T? defaultValue;
//   final Function(T?)? onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildBody();
//   }
//
//   _buildBody() {
//     return Column(
//       children: [
//         SizedBox(
//           height: 6.5.h,
//           child: DropdownButtonFormField2<T>(
//             isExpanded: true,
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(vertical: 16),
//               filled: true,
//               fillColor: AppTheme.textBoxColor,
//               border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             hint: Text(
//               hintText,
//               style:
//               const TextStyle(color: AppTheme.inActiveColor, fontSize: 15),
//             ),
//             items: menuItems
//                 .map((item) => DropdownMenuItem<T>(
//               value: item,
//               child: Text(
//                 item.getCurrency(),
//                 style: const TextStyle(
//                   fontSize: 14,
//                 ),
//               ),
//             ))
//                 .toList(),
//             validator: (value) {
//               if (value == null) {
//                 return 'Please select a $hintText';
//               }
//               return null;
//             },
//             onChanged: onChanged,
//             buttonStyleData: const ButtonStyleData(
//               padding: EdgeInsets.only(right: 8),
//             ),
//             iconStyleData: const IconStyleData(
//               icon: Icon(
//                 Icons.arrow_drop_down,
//                 color: Colors.black45,
//               ),
//               iconSize: 24,
//             ),
//             dropdownStyleData: DropdownStyleData(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }
//
//
// class CustomApiNationalityDropdown<T extends SmartNationalityModel> extends StatelessWidget {
//   const CustomApiNationalityDropdown(
//       {super.key,
//         required this.hintText,
//         required this.menuItems,
//         this.onChanged,
//         this.defaultValue});
//
//   final String hintText;
//   final List<T> menuItems;
//   final T? defaultValue;
//   final Function(T?)? onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildBody();
//   }
//
//   _buildBody() {
//     return Column(
//       children: [
//         SizedBox(
//           height: 8.5.h,
//           child: DropdownButtonFormField2<T>(
//             isExpanded: true,
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(vertical: 16),
//               filled: true,
//               fillColor: AppTheme.textBoxColor,
//               border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             hint: Text(
//               hintText,
//               style:
//               const TextStyle(color: AppTheme.inActiveColor, fontSize: 15),
//             ),
//             items: menuItems
//                 .map((item) => DropdownMenuItem<T>(
//               value: item,
//               child: Text(
//                 item.getCountry(),
//                 style: const TextStyle(
//                   fontSize: 14,
//                 ),
//               ),
//             ))
//                 .toList(),
//             validator: (value) {
//               if (value == null) {
//                 return 'Please select a $hintText';
//               }
//               return null;
//             },
//             onChanged: onChanged,
//             buttonStyleData: const ButtonStyleData(
//               padding: EdgeInsets.only(right: 8),
//             ),
//             iconStyleData: const IconStyleData(
//               icon: Icon(
//                 Icons.arrow_drop_down,
//                 color: Colors.black45,
//               ),
//               iconSize: 24,
//             ),
//             dropdownStyleData: DropdownStyleData(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }
//
// class CustomUpdateApiNationalityDropdown<T extends SmartNationalityModel> extends StatelessWidget {
//   const CustomUpdateApiNationalityDropdown(
//       {super.key,
//         required this.hintText,
//         required this.menuItems,
//         this.onChanged,
//         this.defaultValue});
//
//   final String hintText;
//   final List<T> menuItems;
//   final T? defaultValue;
//   final Function(T?)? onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildBody();
//   }
//
//   _buildBody() {
//     return Column(
//       children: [
//         SizedBox(
//           height: 8.5.h,
//           child: DropdownButtonFormField2<T>(
//             isExpanded: true,
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(vertical: 16),
//               filled: true,
//               fillColor: AppTheme.textBoxColor,
//               border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             hint: Text(
//               hintText,
//               style:
//               const TextStyle(color: AppTheme.inActiveColor, fontSize: 15),
//             ),
//             items: menuItems
//                 .map((item) => DropdownMenuItem<T>(
//               value: item,
//               child: Text(
//                 item.getCountry(),
//                 style: const TextStyle(
//                   fontSize: 14,
//                 ),
//               ),
//             ))
//                 .toList(),
//
//             // validator: (value) {
//             //   if (value == null) {
//             //     return 'Please select a $hintText';
//             //   }
//             //   return null;
//             // },
//
//             onChanged: onChanged,
//             buttonStyleData: const ButtonStyleData(
//               padding: EdgeInsets.only(right: 8),
//             ),
//             iconStyleData: const IconStyleData(
//               icon: Icon(
//                 Icons.arrow_drop_down,
//                 color: Colors.black45,
//               ),
//               iconSize: 24,
//             ),
//             dropdownStyleData: DropdownStyleData(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }
//
//
// class GenderDropdown extends StatelessWidget {
//   const GenderDropdown({
//     super.key,
//     this.onChanged,
//   });
//
//   final Function(int?)? onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildBody();
//   }
//
//   _buildBody() {
//     return Column(
//       children: [
//         SizedBox(
//           height: 50,
//           child: DropdownButtonFormField2<int>(
//             isExpanded: true,
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(vertical: 16),
//               filled: true,
//               fillColor: AppTheme.textBoxColor,
//               border: OutlineInputBorder(
//                 borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             hint: const Text(
//               'Select gender',
//               style: TextStyle(color: AppTheme.inActiveColor, fontSize: 15),
//             ),
//             items: const [
//               DropdownMenuItem<int>(
//                 value: 1,
//                 child: Text(
//                   'Male',
//                   style: TextStyle(
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//               DropdownMenuItem<int>(
//                 value: 0,
//                 child: Text(
//                   'Female',
//                   style: TextStyle(
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ],
//             validator: (value) {
//               if (value == null) {
//                 return 'Please select a gender';
//               }
//               return null;
//             },
//             onChanged: onChanged,
//             buttonStyleData: const ButtonStyleData(
//               padding: EdgeInsets.only(right: 8),
//             ),
//             iconStyleData: const IconStyleData(
//               icon: Icon(
//                 Icons.arrow_drop_down,
//                 color: Colors.black45,
//               ),
//               iconSize: 24,
//             ),
//             dropdownStyleData: DropdownStyleData(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }
