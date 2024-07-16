import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:healthy_cart_user/core/custom/button_widget/button_widget.dart';
import 'package:healthy_cart_user/core/custom/button_widget/view_all_button.dart';
import 'package:healthy_cart_user/core/services/easy_navigation.dart';
import 'package:healthy_cart_user/features/pharmacy/application/pharmacy_provider.dart';
import 'package:healthy_cart_user/features/pharmacy/presentation/pharmacy_categories.dart';
import 'package:healthy_cart_user/features/pharmacy/presentation/prescription_page.dart';
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
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 16, 8),
                child: FadeIn(
                  duration: const Duration(milliseconds: 500),
                  child: ButtonWidget(
                    buttonColor: BColors.buttonGreen,
                    onPressed: () {
                      pharmacyProvider.clearProductAndUserInCheckOutDetails();
                      EasyNavigation.push(
                        context: context,
                        page: const PrescriptionScreen(),
                        type: PageTransitionType.rightToLeft,
                      );
                    },
                    buttonHeight: 36,
                    buttonWidth: 168,
                    buttonWidget: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.maps_ugc_outlined,
                          color: BColors.textBlack,
                          size: 20,
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
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: (pharmacyProvider.pharmacyCategoryList.isNotEmpty)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Categories',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat'),
                        ),
                        (pharmacyProvider.pharmacyCategoryList.isNotEmpty &&
                                pharmacyProvider.pharmacyCategoryList.length >=
                                    4)
                            ? FadeIn(
                  duration: const Duration(milliseconds: 500),
                              child: ViewAllButton(
                                  onTap: () {
                                    EasyNavigation.push(
                                      context: context,
                                      type: PageTransitionType.leftToRight,
                                      page: const PharmacyCategoriesScreen(),
                                    );
                                  },
                                ),
                            )
                            : const SizedBox(),
                      ],
                    )
                  : const SizedBox(),
            ),
            (pharmacyProvider.pharmacyCategoryList.isNotEmpty)
                ? SizedBox(
                    height: 112,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      scrollDirection: Axis.horizontal,
                      itemCount: pharmacyProvider.pharmacyCategoryList.length,
                      itemBuilder: (context, index) {
                        return FadeInRight(
                          duration: const Duration(milliseconds: 500),
                          child: VerticalImageText(
                              rightPadding: 4,
                              leftPadding: 2,
                              onTap: () {
                                pharmacyProvider.setCategoryId(
                                    selectedCategoryId: pharmacyProvider
                                            .pharmacyCategoryList[index].id ??
                                        '',
                                    selectedCategoryName: pharmacyProvider
                                        .pharmacyCategoryList[index].category);
                                EasyNavigation.push(
                                    context: context,
                                    page:
                                        const PharmacyCategoryWiseProductScreen());
                              },
                              image: pharmacyProvider
                                  .pharmacyCategoryList[index].image,
                              title: pharmacyProvider
                                  .pharmacyCategoryList[index].category),
                        );
                      },
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      );
    });
  }
}
