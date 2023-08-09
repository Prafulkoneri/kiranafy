import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/controller/s_shop_configuration_controller.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:provider/provider.dart';

class ShopDeliveryAreaDialogView extends StatefulWidget {
  final bool? initial1ShopConfigration;
  const ShopDeliveryAreaDialogView({Key? key, this.initial1ShopConfigration})
      : super(key: key);

  @override
  _ShopDeliveryAreaDialogViewState createState() =>
      _ShopDeliveryAreaDialogViewState();
}

class _ShopDeliveryAreaDialogViewState
    extends State<ShopDeliveryAreaDialogView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<SShopConfigurationController>()
          .initState(context, widget.initial1ShopConfigration);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<SShopConfigurationController>();
    final read = context.watch<SShopConfigurationController>();
    return Dialog(
      backgroundColor: Color(0xffFFFFFF),
      // shape: ,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),

      // scrollable: true,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: ScreenUtil().screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      right: 18.0.w,
                      left: 18.0.w,
                      top: 27.h,
                    ),
                    child: SizedBox(
                      width: 351.w,
                      height: 36.h,
                      child: TextField(
                        // autofocus: true,
                        controller: watch.searchController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: splashnone),
                                borderRadius: BorderRadius.circular(8.w)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: splashnone),
                                borderRadius: BorderRadius.circular(8.w)),
                            hintText: 'Search ',
                            hintStyle: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Grey,
                                    // letterSpacing: .5,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400)),

                            // Add a clear button to the search bar

                            // Add a search icon or button to the search bar
                            prefixIcon: IconButton(
                              icon: SvgPicture.asset(
                                'assets/images/search.svg',
                                width: 15.w,
                                height: 15.h,
                              ),
                              onPressed: () {},
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                read.onClearAreaSearch();
                              },
                              icon: Container(
                                height: 20.w,
                                width: 20.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.5)),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/images/Cross.svg',
                                    width: 3.w,
                                    height: 6.h,
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: watch.areaList?.length ?? 0,
                    //  watch.shopDeliveryAreaData?.length ?? 0,
                    itemBuilder: (context, index) {
                      final element = watch.areaList?[index];
                      return Container(
                        padding: EdgeInsets.only(left: 18, top: 20),
                        child: Row(
                          children: [
                            PrimaryCheckBox(
                              onChanged: (value) {
                                read.onSelectedDeliveryArea(index, element?.id);
                              },
                              value: watch.selectedDeliveryAreaList[index],
                            ),
                            Flexible(
                              child: Text(
                                "${element?.areaName}",
                                style: TextStyle(
                                    color: Black1,
                                    // letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    // child:
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 18.0, bottom: 20, right: 19.w),
                    child: PrimaryButton(
                        fontSize: 16.sp,
                        height: 34.w,
                        width: 274.w,
                        text: "Submit",
                        fontWeight: FontWeight.w700,
                        color: Color(0xff39C19D),
                        onTap: () {
                          read.getShopConfiguration(
                              context, widget.initial1ShopConfigration);
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
