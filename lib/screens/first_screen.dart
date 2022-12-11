import 'login_screen.dart';
import 'package:aster_hf/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 62),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                child: Text(
                  'Track your \nHealth variables',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 28.sp),
                  maxLines: 2,
                ),
              ),
               SizedBox(
                height: 60.h,
              ),
              SizedBox(
                height: 260.h,
                child: Image.asset('assets/images/logo1.png'),
              ),
              Material(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(LoginScreen.routename);
                  },
                  child:  Button(
                    text: 'Continue',
                    width: 240.w,
                    fontsize: 16.sp,
                    fontweight: FontWeight.w600,
                    height: 60.h,
                  ),
                ),
              ),
             SizedBox(
                height: 32.h,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Your Privacy matters to us. You can learn how we use the information when you use our services by reading our ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(134, 134, 134, 1),
                          fontSize: 15.sp,
                          height: 1.5.h),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                          fontSize: 15.sp,
                          height: 1.5.h),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
