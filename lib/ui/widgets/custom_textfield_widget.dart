part of 'widgets.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool inputNumber;
  final bool obscureText;

  CustomTextField(this.controller, this.labelText,
      {this.inputNumber = false, this.obscureText = false});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55,
        margin: EdgeInsets.only(bottom: 9, top: 5),
        child: TextField(
          keyboardType: inputNumber ? TextInputType.number : null,
          obscureText: obscureText,
          style: TextStyle(fontSize: 15),
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: labelText,
          ),
        ));
  }
}
