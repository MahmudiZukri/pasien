part of 'widgets.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  CustomTextField(this.controller, this.labelText);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55,
        margin: EdgeInsets.only(bottom: 9, top: 5),
        child: TextField(
          style: TextStyle(fontSize: 15),
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: labelText,
          ),
        ));
  }
}
