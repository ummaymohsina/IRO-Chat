import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iro/domain/signupdomain.dart';
import 'package:iro/models/authentication/signupmodel.dart';
import 'package:iro/provider/auth/signupprovider.dart';
import 'package:phone_number/phone_number.dart';

class CountryCodeController extends GetxController {
  // loading button
  static var isloading = false.obs;
  // country codes
  static String cuntrycode = '977';
  static String regincode = 'NP';
  void choosecountry(BuildContext context) {
    showCountryPicker(
        context: context,
        onSelect: (country) {
          cuntrycode = country.phoneCode;
          regincode = country.countryCode;
          update();
        });
  }

  void isphonevalid() async {
    isloading.value = true;
    update();
    try {
      var result =
          await PhoneNumberUtil().validate(SIgnupClicked.phone.text, regincode);
      if (result) {
        SIgnupClicked.messege.value = '';
        SignupModel.username = SIgnupClicked.username.text;
        SignupModel.password = SIgnupClicked.password.value.text;
        update();
        sendOtp(cuntrycode);
      } else {
        isloading.value = false;
        SIgnupClicked.messege.value = 'phone number invalid for the region';
        update();
      }
    } on Exception {
      isloading.value = false;
      SIgnupClicked.messege.value = 'phone number invalid for the region';
      update();
    }
  }
}
