import 'package:aster_hf/screens/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routename = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _passwordvisble = false;
  bool? _isChecked = false;

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final appbar = AppBar(
        centerTitle: true,
        title: Text(
          'Login',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
        ),
      );
          final availableHeight = mediaquery.size.height -
        appbar.preferredSize.height -
        mediaquery.padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar,
      body:  SizedBox(
        height: availableHeight,
        child: SingleChildScrollView(
          child: Column(
                children: [
                   SizedBox(
                    height: availableHeight*0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: availableHeight*0.1,
                        width: availableHeight*0.1,
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ],
                  ),
                  Text(
                    'Wellbe',
                    style: GoogleFonts.poppins(
                      color: const Color.fromRGBO(105, 92, 212, 1),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: availableHeight*0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       SizedBox(
                        width: mediaquery.size.width*0.040,
                      ),
                      Text(
                        'Email Address',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                   SizedBox(
                    height: availableHeight*0.01,
                  ),
                  SizedBox(
                    width: mediaquery.size.width*0.95,
                    
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: const Color.fromRGBO(140, 142, 151, 1),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          hintText: 'Enter your email',
                          hintStyle: GoogleFonts.poppins(
                            color: const Color.fromRGBO(140, 142, 151, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey, width: 1)),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(224, 224, 224, 224),
                                  width: 1))),
                    ),
                  ),
                   SizedBox(
                    height: availableHeight*0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: mediaquery.size.width*0.040,
                      ),
                      Text(
                        'Password',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                 SizedBox(
                    height: availableHeight*0.01,
                  ),
                  SizedBox(
                    width: mediaquery.size.width*0.95,
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !_passwordvisble,
                      cursorColor: const Color.fromRGBO(140, 142, 151, 1),
                      textAlign: TextAlign.start,
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
                          hintStyle: GoogleFonts.poppins(
                            color: const Color.fromRGBO(140, 142, 151, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey, width: 1)),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(224, 224, 224, 224),
                                  width: 1))),
                    ),
                  ),
                   SizedBox(
                    height: availableHeight*0.01,
                  ),
                  Row(
                    children: [
                      
                      Checkbox(
                          value: _isChecked,
                          shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          activeColor: Colors.transparent,
                          checkColor: const Color.fromARGB(223, 138, 137, 137),
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value;
                            });
                          }),
                      Text(
                        'Remember Me',
                        style: GoogleFonts.poppins(
                          color: const Color.fromRGBO(140, 142, 151, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: EdgeInsets.only(right: mediaquery.size.width*0.040),
                        child: Text(
                          'Forgot Password',
                          style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(243, 70, 70, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      
                    ],
                  ),
               SizedBox(
                    height: availableHeight*0.02,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(105, 92, 212, 1),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    height: 48,
                    width: mediaquery.size.width*0.95,
                    child: Center(
                      child: Text(
                        'Login',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                   SizedBox(
                    height: availableHeight*0.02,
                  ),
                  Text(
                    'or continue with',
                    style: GoogleFonts.poppins(
                      color: const Color.fromRGBO(140, 142, 151, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                   SizedBox(
                    height: availableHeight*0.01,
                  ),
                 Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: mediaquery.size.width * 0.04,
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(right: mediaquery.size.width * 0.03),
                            child: OutlinedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))))),
                              onPressed: () {},
                              child: SizedBox(
                                height: availableHeight * 0.07,
                                width: mediaquery.size.width * 0.32,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/apple.png'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Apple',
                                      style: GoogleFonts.poppins(
                                        color: const Color.fromRGBO(140, 142, 151, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                              margin:
                                  EdgeInsets.only(left: mediaquery.size.width * 0.03),
                              child: OutlinedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))))),
                                onPressed: () {},
                                child: SizedBox(
                                  height: availableHeight * 0.07,
                                  width: mediaquery.size.width * 0.32,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/google.png'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Google',
                                        style: GoogleFonts.poppins(
                                          color:
                                              const Color.fromRGBO(140, 142, 151, 1),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          SizedBox(
                            width: mediaquery.size.width * 0.04,
                          ),
                        ],
                      ),
               
                  SizedBox(
                    height: availableHeight*0.16,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don\'t have an account? ',
                          style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(140, 142, 151, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                            text: 'Sign Up',
                            style: GoogleFonts.poppins(
                              color: const Color.fromRGBO(105, 92, 212, 1),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(context)
                                  .pushNamed(SignupScreen.routename)),
                      ],
                    ),
                  ),
                  SizedBox(height: availableHeight*0.08,)
                ],
              
            
          ),
        ),
      ),
    );
  }
}
