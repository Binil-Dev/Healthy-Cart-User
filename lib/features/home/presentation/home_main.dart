import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:healthy_cart_user/core/custom/app_bars/home_sliver_appbar.dart';
import 'package:healthy_cart_user/core/custom/loading_indicators/loading_indicater.dart';
import 'package:healthy_cart_user/core/custom/toast/toast.dart';
import 'package:healthy_cart_user/core/services/easy_navigation.dart';
import 'package:healthy_cart_user/features/home/application/provider/home_provider.dart';
import 'package:healthy_cart_user/features/home/presentation/widgets/ad_slider_home.dart';
import 'package:healthy_cart_user/features/home/presentation/widgets/hospital_horizontal_card.dart';
import 'package:healthy_cart_user/features/home/presentation/widgets/lab_list_card_home.dart';
import 'package:healthy_cart_user/features/home/presentation/widgets/pharmacy_horizontal_card.dart';
import 'package:healthy_cart_user/features/hospital/application/provider/hospital_provider.dart';
import 'package:healthy_cart_user/features/hospital/presentation/hospital_details.dart';
import 'package:healthy_cart_user/features/laboratory/application/provider/lab_provider.dart';
import 'package:healthy_cart_user/features/laboratory/presentation/lab_details_screen.dart';
import 'package:healthy_cart_user/features/pharmacy/application/pharmacy_provider.dart';
import 'package:healthy_cart_user/features/pharmacy/presentation/pharmacy_products.dart';
import 'package:healthy_cart_user/utils/constants/colors/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeMain extends StatefulWidget {
  const HomeMain(
      {super.key,
      required this.currentTab,
      required this.onNavigateToHospitalTab,
      required this.onNavigateToLaboratoryTab,
      required this.onNavigateToPharmacyTab});
  final int currentTab;
  final VoidCallback onNavigateToHospitalTab;
  final VoidCallback onNavigateToLaboratoryTab;
  final VoidCallback onNavigateToPharmacyTab;

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  void initState() {
    final homeProvider = context.read<HomeProvider>();
    final hospitalProvider = context.read<HospitalProvider>();
    final labProvider = context.read<LabProvider>();
    final pharmacyProvider = context.read<PharmacyProvider>();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        hospitalProvider.getAllHospitals();
        labProvider.getLabs();
        pharmacyProvider.getAllPharmacy();
        homeProvider.getBanner();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    return Consumer4<HomeProvider, HospitalProvider, LabProvider,
            PharmacyProvider>(
        builder: (context, homeProvider, hospitalProvier, labProvider,
            pharmacyProvider, _) {
      return Scaffold(
          body: CustomScrollView(
        slivers: [
          const HomeSliverAppbar(searchHint: 'Search'),
          const SliverGap(10),
          if (homeProvider.isLoading == true &&
              hospitalProvier.hospitalFetchLoading == true &&
              labProvider.labFetchLoading == true &&
              pharmacyProvider.fetchLoading == true &&
              labProvider.labList.isEmpty &&
              pharmacyProvider.pharmacyList.isEmpty &&
              homeProvider.homeBannerList.isEmpty &&
              hospitalProvier.hospitalList.isEmpty)
            const SliverFillRemaining(child: Center(child: LoadingIndicater()))
          else
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    FadeInRight(child: AdSliderHome(screenWidth: screenwidth)),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Hospitals',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.onNavigateToHospitalTab();
                          },
                          child: const Text(
                            'View all',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: BColors.buttonLightBlue,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                    const Gap(10),
                    SizedBox(
                      height: 230,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: hospitalProvier.hospitalList.length > 5
                            ? 5
                            : hospitalProvier.hospitalList.length,
                        separatorBuilder: (context, index) => const Gap(10),
                        itemBuilder: (context, index) => FadeInRight(
                            child: GestureDetector(
                          onTap: () {
                            hospitalProvier.hospitalList[index].ishospitalON ==
                                    false
                                ? CustomToast.errorToast(
                                    text: 'This Hospital is not available now!')
                                : EasyNavigation.push(
                                    context: context,
                                    type: PageTransitionType.rightToLeft,
                                    duration: 250,
                                    page: HospitalDetails(
                                      hospitalId: hospitalProvier
                                          .hospitalList[index].id!,
                                      index: index,
                                    ));
                          },
                          child: HospitalsHorizontalCard(
                            index: index,
                          ),
                        )),
                      ),
                    ),
                    const Gap(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Pharmacy',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.onNavigateToPharmacyTab();
                          },
                          child: const Text(
                            'View all',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: BColors.buttonLightBlue,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                    const Gap(8),
                    SizedBox(
                      height: 230,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: pharmacyProvider.pharmacyList.length > 5
                            ? 5
                            : pharmacyProvider.pharmacyList.length,
                        separatorBuilder: (context, index) => const Gap(10),
                        itemBuilder: (context, index) => FadeInRight(
                            child: GestureDetector(
                          onTap: () {
                            pharmacyProvider.pharmacyList[index].isPharmacyON ==
                                    false
                                ? CustomToast.errorToast(
                                    text: 'This Pharmacy is not available now!')
                                : pharmacyProvider.setPharmacyIdAndCategoryList(
                                    selectedpharmacyId: pharmacyProvider
                                            .pharmacyList[index].id ??
                                        '',
                                    categoryIdList: pharmacyProvider
                                            .pharmacyList[index]
                                            .selectedCategoryId ??
                                        [],
                                    pharmacy:
                                        pharmacyProvider.pharmacyList[index]);
                            EasyNavigation.push(
                                type: PageTransitionType.rightToLeft,
                                context: context,
                                page: const PharmacyProductScreen());
                          },
                          child: PharmacyHorizontalCard(
                            index: index,
                          ),
                        )),
                      ),
                    ),
                    const Gap(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Laboratory',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.onNavigateToLaboratoryTab();
                          },
                          child: const Text(
                            'View all',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: BColors.buttonLightBlue,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),

                    /* ---------------------------------- LABS ---------------------------------- */
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: labProvider.labList.length > 5
                            ? 5
                            : labProvider.labList.length,
                        separatorBuilder: (context, index) => const Gap(10),
                        itemBuilder: (context, index) => FadeInRight(
                              child: LabListCardHome(
                                index: index,
                                onTap: () {
                                  EasyNavigation.push(
                                      context: context,
                                      type: PageTransitionType.rightToLeft,
                                      duration: 250,
                                      page: LabDetailsScreen(
                                        labId: labProvider.labList[index].id!,
                                        index: index,
                                      ));
                                },
                              ),
                            )),
                  ],
                ),
              ),
            )
        ],
      ));
    });
  }
}
