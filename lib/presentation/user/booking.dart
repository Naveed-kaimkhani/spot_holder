import 'package:flutter/material.dart';
import 'package:spot_holder/presentation/widget/app_bar.dart';
import 'package:spot_holder/presentation/widget/custom_app_bar.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spot_holder/style/custom_text_style.dart';
import 'package:spot_holder/utils/routes/routes_name.dart';
import 'package:spot_holder/utils/utils.dart';

import 'package:provider/provider.dart';
import '../../Data/FirebaseUserRepository.dart';
import '../../Domain/models/parking_model.dart';
import '../../Domain/models/reserved_parking_model.dart';
import '../../Domain/models/user_model.dart';
import '../../Domain/transaction.dart';
import '../../provider/user_provider.dart';
import '../../style/styling.dart';
import '../../utils/custom_loader.dart';
import '../widget/decor.dart';

class Booking extends StatefulWidget {
  final ParkingModel parking;
  Booking({super.key, required this.parking});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  int currentIndex = 0;
  int selectedValue = 1;
  List<String>? listOfPrice;
  UserModel? user;
  String splitStringFromColon(String text, int part) {
    List<String> parts = text.split(':');
    if (parts.length > 1) {
      return parts[part].trim();
    }
    return '';
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  String getNumericValue(String input) {
    // Remove non-digit characters from the input
    String numericValue = input.replaceAll(RegExp(r'[^0-9]'), '');
    return numericValue;
  }

  _bookParking() async {
    final myContext = context; // Capture the BuildContext

    LoaderOverlay.show(context);
    ReservedParkingModel parkingModel = ReservedParkingModel(
      userUid: utils.currentUserUid,
      parkingDocumentId: widget.parking.documentId,
      userName: user!.name,
      locationLat: widget.parking.locationLat,
      locationLong: widget.parking.locationLong,
      parkingId: widget.parking.parkingId,
      owneruid: widget.parking.ownerUid,
      userContact: widget.parking.ownerPhone,
      price: (int.parse(getNumericValue(
              splitStringFromColon(listOfPrice![currentIndex], 1))) *
          selectedValue),
      bookedSlots: selectedValue,
      parkingAddress: widget.parking.parkingAddress,
      reservedDate: "${selectedDate.toLocal()}".split(' ')[0],
      reservedTime: selectedTime.format(context),
      // durationDate: ,
      durationTime: splitStringFromColon(listOfPrice![currentIndex], 0),
      ownerDeviceToken: widget.parking.ownerDeviceToken,
    );

    TransactionModel model = TransactionModel(
      senderUid: utils.currentUserUid,
      receiverUid: widget.parking.ownerUid,
      senderName: user!.name,
      receiverName: widget.parking.ownerName,
      transactionDate: utils.getCurrentDate(),
      transactionTime: utils.getCurrentTime(),
      payment: (int.parse(getNumericValue(
              splitStringFromColon(listOfPrice![currentIndex], 1))) *
          selectedValue),
    );
    final initialBalance = user!.balance;
    final userUpdatedbalance = initialBalance! -
        (int.parse(getNumericValue(
                splitStringFromColon(listOfPrice![currentIndex], 1))) *
            selectedValue);

    await FirebaseUserRepository.bookParkingModelToFirestore(
        parkingModel, context);

    await FirebaseUserRepository.updateSlots(widget.parking.documentId!,
        widget.parking.availableSlots!, selectedValue, myContext);

    await FirebaseUserRepository.updateBalance(utils.currentUserUid,
        userUpdatedbalance, model.payment!, widget.parking.ownerUid!, context);
    await FirebaseUserRepository.saveTransaction(model, context);
    await Provider.of<UserProvider>(context, listen: false)
        .getUserFromServer(context);
    // Navigator.pushNamed(context, RoutesName.userNavigation);
    LoaderOverlay.hide();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    
    user = Provider.of<UserProvider>(context, listen: false).user;
    var price = widget.parking.price;
    var multipliedByTwo = price! * 2;
    var multipliedByThree = price * 3;

    listOfPrice = [
      '1hr - 2hrs:${widget.parking.price} PKR',
      '3hr - 4hrs:$multipliedByTwo PKR',
      '4hr - 6hrs:$multipliedByThree PKR',
    ];

    user = Provider.of<UserProvider>(context, listen: false).user;
    String distance = utils.getDistancebtwSourceNDestination(user!.lat!,
        user!.long!, widget.parking.locationLat!, widget.parking.locationLong!);
    return SafeArea(
      child: Scaffold(
        appBar: custom_appbar(
          title: "check out",
          profile: user!.profileImage!,
        ),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Styling.primaryColor,
              child: Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: Container(
                  decoration: auth_screens_decor(),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            "Parking Area",
                            style: CustomTextStyle.font_18_primary,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            utils.trimAddressToHalf(
                                widget.parking.parkingAddress!),
                            style: CustomTextStyle.font_12_grey,
                          ),
                          SizedBox(
                            height: 11.h,
                          ),
                          Row(
                            children: [
                              const CarIcon(
                                icon: Icons.car_repair,
                                text: "Car sports",
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              DropdownButton<int>(
                                value: selectedValue,
                                onChanged: (int? newValue) {
                                  setState(() {
                                    selectedValue = newValue!;
                                  });
                                },
                                items: List<DropdownMenuItem<int>>.generate(5,
                                    (index) {
                                  return DropdownMenuItem<int>(
                                    value: index + 1,
                                    child: Text('${index + 1}'),
                                  );
                                }),
                              ),
                              SizedBox(
                                width: 27.w,
                              ),
                              CarIcon(
                                icon: Icons.location_on_outlined,
                                text: distance,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            "You can change the duration of booking by selecting any one of the options below",
                            style: CustomTextStyle.font_12_grey,
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Text(
                            "Date",
                            style: CustomTextStyle.font_12_primary,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: DateTimeWidget(
                                  icon: Icons.calendar_month_outlined,
                                  text:
                                      "${selectedDate.toLocal()}".split(' ')[0],
                                  widht: 180.w,
                                ),
                                onTap: () => _selectDate(context),
                              ),
                              InkWell(
                                child: DateTimeWidget(
                                  icon: Icons.timer,
                                  text: selectedTime.format(context),
                                  widht: 120.w,
                                ),
                                onTap: () => _selectTime(context),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 60.h,
                          ),
                          Text(
                            "Plans",
                            style: CustomTextStyle.font_12_primary,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          SizedBox(
                            height: 50.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: listOfPrice!.length,
                                itemBuilder: (context, index) {
                                  bool isSelected = index ==
                                      currentIndex; // Change to your desired color

                                  return InkWell(
                                    child: PlansWidget(
                                      price: splitStringFromColon(
                                          listOfPrice![index], 1),
                                      time: splitStringFromColon(
                                          listOfPrice![index], 0),
                                      color: isSelected
                                          ? Styling.primaryColor
                                          : Colors.grey,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        currentIndex = index;
                                      });
                                    },
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            height: 100.h,
                            width: MediaQuery.of(context).size.width,
                            // margin: EdgeInsets.all(12.w),
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                                color: Styling.backgroundColor,
                                borderRadius: BorderRadius.circular(16.r)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.location_on_outlined),
                                Text(
                                  "${widget.parking.availableSlots} slot Available",
                                  style: CustomTextStyle.font_12_primary,
                                ),
                                Container(
                                  height: 55.h,
                                  width: 170.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(210, 230, 134,
                                            8), // Start color (primaryColor)
                                        Color.fromARGB(255, 220, 172,
                                            58), // End color (you can change this to any other color you want)
                                      ],
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                    ),
                                  ),
                                  child: InkWell(
                                    child: Center(
                                      child: Text.rich(TextSpan(
                                          text: " Reserve for  ",
                                          style: CustomTextStyle.font_14,
                                          children: <InlineSpan>[
                                            TextSpan(
                                              text:
                                                  "${(int.parse(getNumericValue(splitStringFromColon(listOfPrice![currentIndex], 1))) * selectedValue)} PKR",

                                              // text:
                                              //     "${int.parse(getNumericValue(splitStringFromColon(listOfPrice[currentIndex], 1) * selectedValue))}",
                                              style: CustomTextStyle.font_18,
                                            ),
                                            TextSpan(
                                              text:
                                                  "\n                       ${splitStringFromColon(listOfPrice![currentIndex], 0)}",
                                              style: CustomTextStyle.font_14,
                                            )
                                          ])),
                                    ),
                                    onTap: () async {
                                      await _bookParking();
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlansWidget extends StatelessWidget {
  final String time;
  final String price;
  final Color color;
  const PlansWidget({
    required this.price,
    required this.time,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 50.h,
      margin: EdgeInsets.only(right: 14.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: color, // Border color (grey color in this case)
          width: 1.0, // Border width (you can adjust this as needed)
        ),
        borderRadius: BorderRadius.circular(
            25.0), // Circular radius of 25.0 (adjust as needed)
      ),
      child: Center(
        child: Text.rich(TextSpan(
            text: "${time} ",
            style: CustomTextStyle.font_12_grey,
            children: <InlineSpan>[
              TextSpan(
                text: price,
                style: CustomTextStyle.font_16_grey,
              )
            ])),
      ),
    );
  }
}

class DateTimeWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final double widht;

  const DateTimeWidget({
    required this.icon,
    required this.text,
    required this.widht,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: widht,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // Border color (grey color in this case)
          width: 1.0, // Border width (you can adjust this as needed)
        ),
        borderRadius: BorderRadius.circular(
            25.0), // Circular radius of 25.0 (adjust as needed)
      ),
      // Add your child widget (e.g., TextFormField or TextField) here
      child: Row(
        children: [
          Icon(
            icon,
            color: Styling.primaryColor,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            text,
            style: CustomTextStyle.font_14_primary,
          )
        ],
      ),
    );
  }
}

class CarIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  const CarIcon({
    required this.icon,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 25.h,
          width: 25.w,
          decoration: BoxDecoration(
            color: Styling.primaryColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Icon(
              icon,
              size: 20.w,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 9.w,
        ),
        Text(
          text,
          style: CustomTextStyle.font_12_grey,
        )
      ],
    );
  }
}
