import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:healthy_cart_user/core/custom/button_widget/button_widget.dart';
import 'package:healthy_cart_user/core/services/easy_navigation.dart';
import 'package:healthy_cart_user/features/pharmacy/application/pharmacy_provider.dart';
import 'package:healthy_cart_user/features/pharmacy/presentation/pharmacy_categories.dart';
import 'package:healthy_cart_user/features/pharmacy/presentation/product_category_wise.dart';
import 'package:healthy_cart_user/features/pharmacy/presentation/widgets/vertical_image_text_widget.dart';
import 'package:healthy_cart_user/utils/constants/colors/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class RowProductCategoryWidget extends StatelessWidget {
  const RowProductCategoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PharmacyProvider>(builder: (context, pharmacyProvider, _) {
      return SliverToBoxAdapter(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Category',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat'),
                  ),
                  ButtonWidget(
                    buttonColor: BColors.buttonGreen,
                    onPressed: () {},
                    buttonHeight: 36,
                    buttonWidth: 176,
                    buttonWidget: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.maps_ugc_outlined,
                          color: BColors.textBlack,
                          size: 24,
                        ),
                        Text(
                          'Prescription',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              color: BColors.textBlack),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            (pharmacyProvider.pharmacyCategoryList.isNotEmpty)? ///&& pharmacyProvider.pharmacyCategoryList.length>=4
            Padding(
              padding: const EdgeInsets.only(right: 24, bottom: 4),
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    EasyNavigation.push(
                        context: context,
                        type: PageTransitionType.leftToRight,
                        page:const PharmacyCategoriesScreen( ));
                  },
                  child:  Material(
                    color: BColors.white,
                    surfaceTintColor:BColors.white ,
                    elevation: 2,
                    borderRadius: BorderRadius.circular(8),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'View All',
                        style: TextStyle(
                            decorationColor: BColors.darkblue,
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: BColors.darkblue),
                      ),
                    ),
                  ),
                ),
              ),
            ): const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: SizedBox( 
                height: 120,
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  scrollDirection: Axis.horizontal,
                  itemCount: pharmacyProvider.pharmacyCategoryList.length,
                  itemBuilder: (context, index) {
                    return FadeInRight(
                      duration: const Duration(milliseconds: 500),
                      child: VerticalImageText(
                          onTap: () {
                        pharmacyProvider.setCategoryId(
                            selectedCategoryId:
                                pharmacyProvider.pharmacyCategoryList[index].id ??'',
                            selectedCategoryName: pharmacyProvider
                                .pharmacyCategoryList[index].category);
                        EasyNavigation.push(
                            context: context,
                            page: const PharmacyCategoryWiseProductScreen());
                      },
                          image:
                              pharmacyProvider.pharmacyCategoryList[index].image,
                          title: pharmacyProvider
                              .pharmacyCategoryList[index].category),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
