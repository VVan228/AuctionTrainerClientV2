// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auction_trainer_client_v2/pages/auction/api/AuctionPresenter.dart'
    as _i3;
import 'package:auction_trainer_client_v2/pages/auction/impl/AuctionPresenterImpl.dart'
    as _i4;
import 'package:auction_trainer_client_v2/pages/create_room/api/CreateRoomPresenter.dart'
    as _i7;
import 'package:auction_trainer_client_v2/pages/create_room/impl/CreateRoomPresenterImpl.dart'
    as _i8;
import 'package:auction_trainer_client_v2/pages/login/api/LoginPresenter.dart'
    as _i9;
import 'package:auction_trainer_client_v2/pages/login/impl/LoginPresenterImpl.dart'
    as _i10;
import 'package:auction_trainer_client_v2/pages/main/api/MainPresenter.dart'
    as _i11;
import 'package:auction_trainer_client_v2/pages/main/impl/MainPresenterImpl.dart'
    as _i12;
import 'package:auction_trainer_client_v2/pages/select_template/api/SelectTemplatePresenter.dart'
    as _i15;
import 'package:auction_trainer_client_v2/pages/select_template/impl/SelectTemplatePresenterImpl.dart'
    as _i16;
import 'package:auction_trainer_client_v2/pages/waiting/api/WaitingPresenter.dart'
    as _i21;
import 'package:auction_trainer_client_v2/pages/waiting/impl/WaitingPresenterImpl.dart'
    as _i22;
import 'package:auction_trainer_client_v2/security/api/AuthService.dart' as _i5;
import 'package:auction_trainer_client_v2/security/api/MessagingService.dart'
    as _i13;
import 'package:auction_trainer_client_v2/security/api/ServerDataProvider.dart'
    as _i17;
import 'package:auction_trainer_client_v2/security/api/TokenService.dart'
    as _i19;
import 'package:auction_trainer_client_v2/security/impl/AuthServiceImpl.dart'
    as _i6;
import 'package:auction_trainer_client_v2/security/impl/MessagingServiceImpl.dart'
    as _i14;
import 'package:auction_trainer_client_v2/security/impl/RetrofitProvider.dart'
    as _i18;
import 'package:auction_trainer_client_v2/security/impl/TokenServiceImpl.dart'
    as _i20;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AuctionPresenter>(() => _i4.AuctionPresenterImpl());
    gh.lazySingleton<_i5.AuthService>(() => _i6.AuthServiceImpl());
    gh.lazySingleton<_i7.CreateRoomPresenter>(
        () => _i8.CreateRoomPresenterImpl());
    gh.lazySingleton<_i9.LoginPresenter>(() => _i10.LoginPresenterImpl());
    gh.lazySingleton<_i11.MainPresenter>(() => _i12.MainPresenterImpl());
    gh.lazySingleton<_i13.MessagingService>(
        () => _i14.MessagingServiceImpl()..init());
    gh.lazySingleton<_i15.SelectTemplatePresenter>(
        () => _i16.SelectTemplatePresenterImpl());
    gh.lazySingleton<_i17.ServerDataProvider>(
        () => _i18.RetrofitDataProvider());
    gh.singleton<_i19.TokenService>(_i20.TokenServiceImpl()..init());
    gh.lazySingleton<_i21.WaitingPresenter>(() => _i22.WaitingPresenterImpl());
    return this;
  }
}
