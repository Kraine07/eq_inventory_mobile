







import 'package:flutter/material.dart';
import '../theme.dart';

class AppDropdownInput<T> extends StatelessWidget {
  final String labelText;
  final Widget? prefixIcon;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final T? selectedItem; // nullable

  const AppDropdownInput({
    super.key,
    required this.labelText,
    this.prefixIcon,
    required this.items,
    required this.onChanged,
    required this.selectedItemBuilder,
    required this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      validator: (value) {
        if (value == null) {
          return 'Please select a ${labelText}';
        }
        return null;
      },
      dropdownColor:  AppColors.appBlue,
      initialValue: items.isEmpty? null : selectedItem,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.borderColor,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.appWhite,
            width: 3.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.accentColor,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.accentColor,
            width: 3.0,
          ),
        ),
      ),
      items: items,
      onChanged: onChanged,
      selectedItemBuilder: selectedItemBuilder,
    );
  }
}











// import 'package:flutter/material.dart';
//
// import '../theme.dart';
//
// class AppDropdownInput<T> extends StatelessWidget {
//   final String labelText;
//   final Widget? prefixIcon;
//   final List<DropdownMenuItem<T>> items;
//   final T? type;
//   final void Function(T?)? onChanged;
//   final List<Widget> Function(BuildContext)? selectedItemBuilder;
//   final T selectedItem;
//
//   const AppDropdownInput({
//     super.key,
//     required this.labelText,
//     this.prefixIcon,
//     required this.items,
//     required this.type,
//     this.onChanged,
//     required this.selectedItemBuilder,
//     required this.selectedItem,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<T>(
//       value: selectedItem,
//       isExpanded: true,
//       decoration: InputDecoration(
//         labelText: labelText,
//         prefixIcon: prefixIcon,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(
//             color: AppColors.borderColor,
//             width: 1.0,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(
//             color: AppColors.appWhite,
//             width: 3.0,
//           ),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(
//             color: AppColors.accentColor,
//             width: 1.0,
//           ),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(
//             color: AppColors.accentColor,
//             width: 3.0,
//           ),
//         ),
//       ),
//       items: items,
//       initialValue: selectedItem,
//       onChanged: onChanged,
//       selectedItemBuilder: selectedItemBuilder,
//     );
//   }
// }
//
