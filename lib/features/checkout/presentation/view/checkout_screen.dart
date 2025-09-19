import 'package:flower_app/core/Widgets/Custom_Elevated_Button.dart';
import 'package:flower_app/core/Widgets/custom_text_field.dart';
import 'package:flower_app/features/checkout/presentation/widgets/delivery_address_card.dart';
import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../profile/presentation/view/widgets/notification_toggle_widget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPayment = "Cash on delivery";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                    ),
                  ),
                  Text(
                    'Checkout',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        fontFamily: "Janna",
                        color: AppColors.black),
                  )
                ],
              ).setHorizontalPadding(context, 0.02),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery time',
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18,
                        fontFamily: "Janna",
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Schedule',
                    style: TextStyle(
                        color: AppColors.pink,
                        fontSize: 18,
                        fontFamily: "Janna",
                        fontWeight: FontWeight.w500),
                  )
                ],
              ).setHorizontalPadding(context, 0.05),
              const SizedBox(height: 16),
              const Row(
                spacing: 5,
                children: [
                  Icon(Icons.access_time),
                  Text(
                    'Instant,',
                    style: TextStyle(
                        fontFamily: "Janna",
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  Text(
                    "Arrive by 03 Sep 2024, 11:00 AM",
                    style: TextStyle(
                        color: Color(0xff51B063),
                        fontFamily: "Janna",
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ],
              ).setHorizontalPadding(context, 0.05),
              const SizedBox(height: 30.0),
              const Divider(
                thickness: 24,
                color: Color(0xffEAEAEA),
              ),
              const SizedBox(height: 25.0),
              Row(
                children: [
                  Text(
                    'Delivery address',
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18,
                        fontFamily: "Janna",
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ).setHorizontalPadding(context, 0.05),
              const SizedBox(height: 10.0),
              DeliveryAddressCard(
                title: 'Home',
              ).setHorizontalPadding(context, 0.05),
              const SizedBox(height: 10.0),
              DeliveryAddressCard(
                title: 'Office',
              ).setHorizontalPadding(context, 0.05),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.05,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.grey.withOpacity(0.4),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: AppColors.pink,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          'Add new',
                          style: TextStyle(
                              color: AppColors.pink,
                              fontFamily: "Janna",
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              const Divider(
                thickness: 24,
                color: Color(0xffEAEAEA),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Text(
                    'Payment method',
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18,
                        fontFamily: "Janna",
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ).setHorizontalPadding(context, 0.05),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPayment = "Cash on delivery";
                  });
                },
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.07,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Cash on delivery",
                          style: const TextStyle(
                            fontFamily: "Janna",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Radio<String>(
                        value: "Cash on delivery",
                        groupValue: selectedPayment,
                        activeColor: AppColors.pink,
                        onChanged: (value) {
                          setState(() {
                            selectedPayment = value!;
                          });
                        },
                      ),
                    ],
                  ).setHorizontalPadding(context, 0.025),
                ),
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPayment = "Credit card";
                  });
                },
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.07,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Credit card",
                          style: const TextStyle(
                            fontFamily: "Janna",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Radio<String>(
                        value: "Credit card",
                        groupValue: selectedPayment,
                        activeColor: AppColors.pink,
                        onChanged: (value) {
                          setState(() {
                            selectedPayment = value!;
                          });
                        },
                      ),
                    ],
                  ).setHorizontalPadding(context, 0.025),
                ),
              ),
              const SizedBox(height: 20.0),
              if (selectedPayment == "Credit card") ...[
                const Divider(
                  thickness: 24,
                  color: Color(0xffEAEAEA),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [

                    const SizedBox(width: 40.0),

                    Text(
                      'It is a gift',
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 18,
                          fontFamily: "Janna",
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ).setHorizontalPadding(context, 0.05),
                const SizedBox(height: 10.0),
                CustomTextFormField(hint: "Enter the name", label: "Name")
                    .setHorizontalPadding(context, 0.05),
                const SizedBox(height: 20.0),
                CustomTextFormField(
                  hint: "Enter the phone number",
                  label: "Phone number",
                ).setHorizontalPadding(context, 0.05),
              ],
              const SizedBox(height: 30.0),
              const Divider(
                thickness: 24,
                color: Color(0xffEAEAEA),
              ),
              const SizedBox(height: 30.0),
              Column(
                children: [
                  Row(
                    children: [
                      Text("Sub Total",
                          style: TextStyle(
                              fontFamily: "Janna",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: AppColors.grey.withOpacity(0.8))),
                      Spacer(),
                      Text("100\$",
                          style: TextStyle(
                              fontFamily: "Janna",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: AppColors.grey.withOpacity(0.8)))
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text("Delivery Fee",
                          style: TextStyle(
                              fontFamily: "Janna",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: AppColors.grey.withOpacity(0.8))),
                      Spacer(),
                      Text("10\$",
                          style: TextStyle(
                              fontFamily: "Janna",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: AppColors.grey.withOpacity(0.8)))
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Divider(thickness: 1,
                    color: AppColors.black,
                  ),
                  Row(
                    children: [
                      Text("Total",
                          style: TextStyle(
                              fontFamily: "Janna",
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: AppColors.black)),
                      Spacer(),
                      Text("110\$",
                          style: TextStyle(
                              fontFamily: "Janna",
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: AppColors.black))
                    ],
                  ),
                  const SizedBox(height: 40.0),

                  CustomElevatedButton(text: "Place order", onPressed: (){}),

                  const SizedBox(height: 50.0),


                ],
              ).setHorizontalPadding(context, 0.045)
            ],
          ),
        ),
      ),
    );
  }
}
