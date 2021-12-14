import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/order_provider.dart';
import 'package:sixvalley_vendor_app/provider/product_provider.dart';
import 'package:sixvalley_vendor_app/provider/profile_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_bottom_sheet.dart';
import 'package:sixvalley_vendor_app/view/screens/bank_info/bank_info_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/dashboard/dashboard_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/menu/widget/sign_out_confirmation_dialog.dart';
import 'package:sixvalley_vendor_app/view/screens/more/html_view_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/profile/profile_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/restaurant/shop_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/settings/business_setting.dart';
import 'package:sixvalley_vendor_app/view/screens/settings/setting_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/transaction/transaction_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/wallet/wallet_screen.dart';

class ProfileScreenView extends StatefulWidget {
  @override
  _ProfileScreenViewState createState() => _ProfileScreenViewState();
}

class _ProfileScreenViewState extends State<ProfileScreenView> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).sellerProductList;
    Provider.of<ProfileProvider>(context, listen: false).userInfoModel;
  }

  @override
  Widget build(BuildContext context) {
    String sellerId = Provider.of<ProfileProvider>(context, listen: false)
        .userInfoModel
        .id
        .toString();
    int offset = 1;
    Provider.of<ProductProvider>(context, listen: false)
        .initSellerProductList(sellerId, offset.toString(), context);
    return Scaffold(
      body: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                Images.toolbar_background,
                fit: BoxFit.fill,
                height: 500,
                color: Provider.of<ThemeProvider>(context).darkTheme
                    ? Colors.black
                    : null,
              ),
              Container(
                padding: EdgeInsets.only(top: 35, left: 15),
                child: Row(children: [
                  CupertinoNavigationBarBackButton(
                    // onPressed: () => Navigator.of(context).pop(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardScreen()),
                      );
                    },
                    color: ColorResources.getBottomSheetColor(context),
                  ),
                  SizedBox(width: 10),
                  Text(getTranslated('my_profile', context),
                      style: robotoTitleRegular.copyWith(
                          fontSize: 20, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ]),
              ),
              Container(
                padding: EdgeInsets.only(top: 55),
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorResources.getIconBg(context),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  Dimensions.PADDING_SIZE_DEFAULT),
                              topRight: Radius.circular(
                                  Dimensions.PADDING_SIZE_DEFAULT),
                            )),
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          20,
                                      height: 93,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              Provider.of<ProductProvider>(
                                                      context,
                                                      listen: false)
                                                  .sellerProductList
                                                  .length
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_EXTRA_LARGE_TWENTY,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontFamily: 'Roboto')),
                                          SizedBox(height: 5),
                                          Text(
                                            getTranslated(
                                                'total_products', context),
                                            style: TextStyle(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_DEFAULT,
                                                fontWeight: FontWeight.w300,
                                                color: Color(0xFFB5B5B5),
                                                fontFamily: 'Roboto'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          20,
                                      height: 93,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            Provider.of<OrderProvider>(context,
                                                    listen: false)
                                                .orderList
                                                .length
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_LARGE_TWENTY,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontFamily: 'Roboto'),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            getTranslated(
                                                'total_order', context),
                                            style: TextStyle(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_DEFAULT,
                                                fontWeight: FontWeight.w300,
                                                color: Color(0xFFB5B5B5),
                                                fontFamily: 'Roboto'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 80,
                              margin: EdgeInsets.only(right: 10.0, left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomBottomSheet(
                                      image: Icons.shop,
                                      title: getTranslated('my_shop', context),
                                      widget: ShopScreen()),
                                  CustomBottomSheet(
                                      image: Icons.monetization_on,
                                      title: getTranslated('wallet', context),
                                      widget: WalletScreen()),
                                  CustomBottomSheet(
                                      image: Icons.credit_card,
                                      title:
                                          getTranslated('bank_info', context),
                                      widget: BankInfoScreen()),
                                ],
                              ),
                            ),
                            Container(
                              height: 80,
                              margin: EdgeInsets.only(right: 10.0, left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomBottomSheet(
                                      image: Icons.account_box,
                                      title: getTranslated('about_us', context),
                                      widget: HtmlViewScreen(
                                        title:
                                            getTranslated('about_us', context),
                                        url: Provider.of<SplashProvider>(
                                                context,
                                                listen: false)
                                            .configModel
                                            .aboutUs,
                                      )),
                                  CustomBottomSheet(
                                      image: Icons.privacy_tip,
                                      title: getTranslated(
                                          'privacy_policy', context),
                                      widget: HtmlViewScreen(
                                        title: getTranslated(
                                            'privacy_policy', context),
                                        url: Provider.of<SplashProvider>(
                                                context,
                                                listen: false)
                                            .configModel
                                            .privacyPolicy,
                                      )),
                                  CustomBottomSheet(
                                      image: Icons.confirmation_num,
                                      title: getTranslated(
                                          'terms_and_condition', context),
                                      widget: HtmlViewScreen(
                                        title: getTranslated(
                                            'terms_and_condition', context),
                                        url: Provider.of<SplashProvider>(
                                                context,
                                                listen: false)
                                            .configModel
                                            .termsConditions,
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              height: 80,
                              margin: EdgeInsets.only(right: 10.0, left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomBottomSheet(
                                      image: Icons.list_alt,
                                      title: getTranslated(
                                          'transactions', context),
                                      widget: TransactionScreen()),
                                  CustomBottomSheet(
                                      image: Icons.airport_shuttle_sharp,
                                      title: getTranslated(
                                          'shipping_methods', context),
                                      widget: BusinessScreen()),
                                  CustomBottomSheet(
                                      image: Icons.settings,
                                      title: getTranslated('more', context),
                                      widget: SettingsScreen()),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 30.0),
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Column(
                                  children: [
                                    // ignore: deprecated_member_use
                                    FlatButton(
                                        color:
                                            ColorResources.getBottomSheetColor(
                                                context),
                                        padding: EdgeInsets.all(4.0),
                                        onPressed: () {
                                          showCupertinoModalPopup(
                                              context: context,
                                              builder: (_) =>
                                                  SignOutConfirmationDialog());
                                        },
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            getTranslated('logout', context),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 70,
                left: MediaQuery.of(context).size.width / 2 - 60,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        border: Border.all(color: Colors.white, width: 3),
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CachedNetworkImage(
                              errorWidget: (ctx, url, err) =>
                                  Image.asset(Images.placeholder_image),
                              placeholder: (ctx, url) =>
                                  Image.asset(Images.placeholder_image),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              imageUrl:
                                  '${Provider.of<SplashProvider>(context, listen: false).baseUrls.sellerImageUrl}/${profile.userInfoModel.image}',
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: CircleAvatar(
                                backgroundColor: ColorResources.LIGHT_SKY_BLUE,
                                radius: 14,
                                child: IconButton(
                                  // onPressed: _choose,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                                    );
                                  },
                                  padding: EdgeInsets.all(0),
                                  icon: Icon(Icons.edit,
                                      color: ColorResources.WHITE, size: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Text(
                    //   '${profile.userInfoModel.fName} ${profile.userInfoModel.lName}',
                    //   style: titilliumSemiBold.copyWith(
                    //       color: ColorResources.getTextColor(context),
                    //       fontSize: 20.0),
                    // )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
