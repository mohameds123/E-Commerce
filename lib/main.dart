import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nwesapp/layout/shopapp_layout.dart';
import 'package:flutter_nwesapp/modules/shop_app/register/cubit/cubit.dart';
import 'package:flutter_nwesapp/network/local/cache_helper.dart';
import 'package:flutter_nwesapp/network/remote/dio_helper.dart';
import 'package:flutter_nwesapp/network/remote/dio_helper_news.dart';
import 'package:flutter_nwesapp/observe.dart';
import 'package:flutter_nwesapp/shared/components/components.dart';
void main()async
{

  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  DioHelperNews.init();
  await CacheHelper.init();
  bool onBoarding =CacheHelper.getData(key: 'onBoarding');
  if(user!=null)print(user!.uid);
   String? token = CacheHelper.getData(key: 'token');
  runApp(MyApp(
    onBoarding: onBoarding,
    token:token,
    user: user,
  ));
}
class MyApp extends StatelessWidget {
  bool?onBoarding;
  String?token;
  MyApp({
    required this.onBoarding,
    required this.token,
});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoriteData(),
        ),

        BlocProvider(create: (BuildContext context) => RegisterCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:ShopLayout(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
        ),
      ),
    );
  }
}