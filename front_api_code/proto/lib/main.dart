import 'package:flutter/material.dart';
import 'package:proto/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '스마트 의류 거래소',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Home(),
    );
  }
}

















// import 'package:beamer/beamer.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:proto/screens/auth_screen.dart';
// import 'package:proto/screens/home_screen.dart';
// //import 'package:proto/screens/home_screen.dart';
// import 'package:proto/screens/start/start_page.dart';
// import 'package:proto/screens/splash_screen.dart';
// import 'package:proto/router/locations.dart';
// import 'package:proto/states/user_provider.dart';
// import 'package:provider/provider.dart';
//
// //비머 전역선언
// final _routerDelegate = BeamerDelegate(
//
// //비머가드
//   guards: [BeamGuard( //인증되지않은 사용자의 접근방지(불법적인 접근 등)
//       pathBlueprints: ['/'],
//       check: (context, location) {
//         return context.watch<UserProvider>().userState;
//         },
//     showPage: BeamPage(child: AuthScreen())
//   )],
//
//     locationBuilder: BeamerLocationBuilder(
//       beamLocations: [HomeLocation(),InsertLocation(),PostLocation()]
//   )
// );
//
// //메인함수 빌드
// void main(){
//   runApp(MyApp());
// }
//
// //마이앱 클래스 선언(정적 위젯)
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     //퓨처함수로 로딩 구현
//     return FutureBuilder<Object>(
//         future: Future.delayed(Duration(seconds: 3), () => 100),
//         builder: (context, snapShot){
//           return AnimatedSwitcher(
//               duration: Duration(milliseconds: 900),
//               child: _splashLodingWidget(snapShot),
//           );
//         }
//     );
//   }
//   StatelessWidget _splashLodingWidget(AsyncSnapshot<Object> snapshot) {
//     if(snapshot.hasError) {print('에러가 발생하였습니다.'); return Text('Error');} //에러 발생
//     else if(snapshot.hasData) {return Proto();}//정상
//     else{return SplashScreen();}//그 이외
//   }
// }
//
// class Proto extends StatelessWidget {
//   const Proto({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<UserProvider>(
//         create: (BuildContext context){
//           return UserProvider();
//         },
//     child: MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       routeInformationParser: BeamerParser(),
//       routerDelegate: _routerDelegate,
//     )
//     );
//   }
// }
