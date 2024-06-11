// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:firebase_storage/firebase_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/authentication/application/provider/authenication_provider.dart'
    as _i23;
import '../../features/authentication/domain/facade/i_auth_facade.dart' as _i18;
import '../../features/authentication/infrastructure/i_auth_impl.dart' as _i19;
import '../../features/laboratory/application/provider/lab_provider.dart'
    as _i22;
import '../../features/laboratory/domain/facade/i_lab_facade.dart' as _i15;
import '../../features/laboratory/infrastructure/i_lab_impl.dart' as _i16;
import '../../features/location_picker/location_picker/application/location_provider.dart'
    as _i19;
import '../../features/location_picker/location_picker/domain/i_location_facde.dart'
    as _i15;
import '../../features/location_picker/location_picker/infrastructure/i_location_impl.dart'
    as _i16;
import '../../features/pharmacy/application/pharmacy_provider.dart' as _i14;
import '../../features/pharmacy/domain/i_pharmacy_facade.dart' as _i12;
import '../../features/pharmacy/infrastructure/i_pharmacy_impl.dart' as _i13;
import '../../features/profile/application/provider/user_address_provider.dart'
    as _i27;
import '../../features/profile/application/provider/user_profile_provider.dart'
    as _i25;
import '../../features/profile/domain/facade/i_user_profile_facade.dart'
    as _i20;
import '../../features/profile/infrastructure/i_user_profile_impl.dart' as _i21;
import '../services/image_picker.dart' as _i8;
import '../services/location_service.dart' as _i9;
import '../services/pdf_picker.dart' as _i10;
import '../services/sound_services.dart' as _i12;
import '../services/url_launcher.dart' as _i11;
import 'firebase_injectable_module.dart' as _i3;
import 'general_injectable_module.dart' as _i26;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final firebaseInjecatbleModule = _$FirebaseInjecatbleModule();
  final generalInjecatbleModule = _$GeneralInjecatbleModule();
  await gh.factoryAsync<_i3.FirebaseService>(
    () => firebaseInjecatbleModule.firebaseService,
    preResolve: true,
  );
  gh.lazySingleton<_i4.FirebaseAuth>(() => firebaseInjecatbleModule.auth);
  gh.lazySingleton<_i5.FirebaseStorage>(() => firebaseInjecatbleModule.storage);
  gh.lazySingleton<_i6.FirebaseFirestore>(() => firebaseInjecatbleModule.repo);
  gh.lazySingleton<_i7.ImageService>(
      () => generalInjecatbleModule.imageServices);
  gh.lazySingleton<_i8.LocationService>(
      () => generalInjecatbleModule.locationServices);
  gh.lazySingleton<_i9.PdfPickerService>(
      () => generalInjecatbleModule.pdfPickerService);
  gh.lazySingleton<_i10.UrlService>(() => generalInjecatbleModule.urlService);
  gh.lazySingleton<_i11.SoundServices>(
      () => generalInjecatbleModule.soundServices);
  gh.lazySingleton<_i12.IPharmacyFacade>(
      () => _i13.IPharmacyImpl(gh<_i6.FirebaseFirestore>()));
  gh.factory<_i14.PharmacyProvider>(
      () => _i14.PharmacyProvider(gh<_i12.IPharmacyFacade>()));
  gh.lazySingleton<_i15.ILocationFacade>(() => _i16.ILocationImpl(
        gh<_i8.LocationService>(),
        gh<_i6.FirebaseFirestore>(),
      ));
  gh.lazySingleton<_i17.ILabFacade>(() => _i18.ILabImpl(
        gh<_i6.FirebaseFirestore>(),
        gh<_i11.SoundServices>(),
      ));
  gh.factory<_i17.LocationProvider>(
      () => _i17.LocationProvider(gh<_i13.ILocationFacade>()));
  gh.lazySingleton<_i18.IAuthFacade>(() => _i19.IAuthImpl(
        gh<_i5.FirebaseAuth>(),
        gh<_i7.FirebaseFirestore>(),
      ));
  gh.lazySingleton<_i20.IUserProfileFacade>(() => _i21.IUserProfileImpl(
        gh<_i7.FirebaseFirestore>(),
        gh<_i8.ImageService>(),
      ));
  gh.factory<_i22.LabProvider>(() => _i22.LabProvider(gh<_i15.ILabFacade>()));
  gh.factory<_i23.AuthenticationProvider>(
      () => _i23.AuthenticationProvider(gh<_i18.IAuthFacade>()));
  gh.factory<_i24.UserAddressProvider>(
      () => _i24.UserAddressProvider(gh<_i20.IUserProfileFacade>()));
  gh.factory<_i25.UserProfileProvider>(
      () => _i25.UserProfileProvider(gh<_i20.IUserProfileFacade>()));
  return getIt;
}

class _$FirebaseInjecatbleModule extends _i3.FirebaseInjecatbleModule {}

class _$GeneralInjecatbleModule extends _i26.GeneralInjecatbleModule {}
