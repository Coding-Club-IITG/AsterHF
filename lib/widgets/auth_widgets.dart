import 'package:flutter/material.dart';
import '../controllers/validation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        iconSize: 21,
        splashRadius: 22,
        onPressed: Navigator.of(context).pop,
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomTextformfield extends StatelessWidget {
  final TextEditingController controller;
  final bool isEmail;

  const CustomTextformfield(
      {super.key, required this.isEmail, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      validator: isEmail ? validateEmail : validateName,
      controller: controller,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.name,
      cursorColor: const Color.fromRGBO(140, 142, 151, 1),
      decoration: InputDecoration(
        hintText: isEmail ? 'Enter your email' : 'Enter your Name',
        hintStyle: TextStyle(
          color: const Color.fromRGBO(140, 142, 151, 1),
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Color.fromARGB(224, 224, 224, 224),
            width: 1,
          ),
        ),
      ),
    );
  }
}

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;

  const CustomPasswordField({super.key, required this.controller});

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  var _passwordvisble = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validatePassword,
      keyboardType: TextInputType.visiblePassword,
      controller: widget.controller,
      obscureText: !_passwordvisble,
      cursorColor: const Color.fromRGBO(140, 142, 151, 1),
      decoration: InputDecoration(
        suffixIcon: InkWell(
          splashColor: const Color.fromARGB(224, 224, 224, 224),
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          onTap: () {
            setState(() {
              _passwordvisble = !_passwordvisble;
            });
          },
          child: _passwordvisble
              ? const Icon(
                  Icons.visibility,
                  color: Colors.black54,
                )
              : const Icon(
                  Icons.visibility_off,
                  color: Colors.grey,
                ),
        ),
        hintText: 'Enter your password',
        hintStyle: TextStyle(
          color: const Color.fromRGBO(140, 142, 151, 1),
          fontWeight: FontWeight.w500,
          fontSize: 14.h,
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Color.fromARGB(224, 224, 224, 224),
            width: 1,
          ),
        ),
      ),
    );
  }
}
