import 'package:flower_app/core/Widgets/Custom_Elevated_Button.dart';
import 'package:flutter/material.dart';
import '../../../../core/contants/app_images.dart';
import '../../../../core/routes/route_names.dart';

class ThanksScreen extends StatelessWidget {
  const ThanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.successImage,height: 200,),
            const SizedBox(height: 50),
            const Text("Your order placed\n successfully!",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            const SizedBox(height: 30),
            CustomElevatedButton(
                text: "Track order",
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.dashboard,
                        (route) => false,
                  );
                  Navigator.pushNamed(context, AppRoutes.trackOrder);
                })
          ],
        ),
      ),
    );
  }
}
