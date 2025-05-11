import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class MyInputField extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextEditingController textEditingController;
  final bool isPasswordField;
  final bool? isEmailField;
  final bool? isPhoneField;
  final bool? isDateField;

  const MyInputField(
      {Key? key,
      required this.placeholder,
      required this.textEditingController,
      required this.label,
      required this.isPasswordField,
      this.isEmailField,
      this.isPhoneField,
      this.isDateField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
            boxShadow: [
              BoxShadow(blurRadius: 16, color: Colors.black.withOpacity(.2)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              if (isPhoneField == true)
                InternationalPhoneNumberInput(
                  selectorConfig: SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  ),
                  onInputChanged: (PhoneNumber number) {},
                  selectorTextStyle: TextStyle(color: Colors.black),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.disabled,
                  initialValue: PhoneNumber(isoCode: 'MZ'),
                  textFieldController: textEditingController,
                  inputDecoration: InputDecoration(
                    hintText: placeholder,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              if (isEmailField == true)
                TextField(
                  obscureText: isPasswordField,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: placeholder,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9@.]+')),
                  ],
                  onChanged: (value) {},
                ),
              if (isPhoneField != true && isEmailField != true)
                TextField(
                  obscureText: isPasswordField,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: placeholder,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  keyboardType: TextInputType.text,
                  inputFormatters: [],
                  onChanged: (value) {},
                ),
              if (isDateField == true)
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: IgnorePointer(
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: placeholder,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null)
      textEditingController.text = DateFormat('yyyy-MM-dd').format(picked);
  }
}
