import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_dialog.dart';
import 'package:sixvalley_vendor_app/view/screens/settings/widget/language_dialog.dart';
import 'package:sixvalley_vendor_app/view/screens/transaction/transaction_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<SplashProvider>(context, listen: false).setFromSetting(true);

    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('more', context),),
      body: SafeArea( 
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          children: [

            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            Padding(
              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  child: Row( mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 15,
                                          height: 15,
                                          child: Image.asset(Images.dark)),
                                    SizedBox(width: 33,),
                                    Text(getTranslated('dark_theme', context), style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                                    // Expanded(child: SizedBox()),
                                    SizedBox(width: 10,),
                                    FlutterSwitch(
                                      width: 50.0,
                                      height: 25.0,
                                      toggleSize: 30.0,
                                      value: Provider.of<ThemeProvider>(context).darkTheme,
                                      borderRadius: 10.0,
                                      activeColor: Theme.of(context).primaryColor,
                                      padding: 1.0,
                                      activeIcon: Image.asset(Images.dark_mode, width: 30,height: 30, fit: BoxFit.scaleDown),
                                      inactiveIcon: Image.asset(Images.light_mode, width: 30,height: 30,fit: BoxFit.scaleDown,),
                                      onToggle:(bool isActive) =>Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                                    ),
                                  ],
                                  ),
                                ),

                              ),
            ),
            TitleButton(
              icon: Icons.language,
              title: getTranslated('choose_language', context),
              onTap: () => showAnimatedDialog(context, LanguageDialog(isCurrency: false)),
            ),
            TitleButton(
              icon: Icons.monetization_on,
              title: '${getTranslated('currency', context)} (${Provider.of<SplashProvider>(context).myCurrency.name})',
              onTap: () => showAnimatedDialog(context, LanguageDialog(isCurrency: true)),
            ),
          ],
        ),
      ),
    );
  }

}
class TitleButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  TitleButton({@required this.icon, @required this.title, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: ColorResources.getPrimary(context)),
      title: Text(title, style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
      onTap: onTap,
    );
  }
}

