import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; //매터리얼앱 위젯이 있어야지 플러터의 디자인 라이브러리를 사용  할 수 있다.
import 'package:sctb_app/router/locations.dart';
import 'package:sctb_app/screens/home_screen.dart';
import 'package:sctb_app/screens/splash_screen.dart';

final _routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [HomeLocation()]
    )
);

//메인 함수 빌드
void main() {
  runApp(MyApp());
}

//마이앱 클래스 선언

class MyApp extends StatelessWidget {
  //상태변화가 없는 위젯
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //퓨쳐 함수로 로딩을 구현했었으나 현재는 로딩없앰.(비동기 실행)
    return FutureBuilder<Object>(
        future: Future.delayed(Duration(seconds: 2), () => 100),
        builder: (context, snapshot) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 1000), //페이드인아웃 효과
            child: _splashLodingWidget(snapshot), //스냅샷을 실행할 위젯 지정
          );
        }
    );
  }

//스플래쉬 로딩위젯 선언(인스턴스)

  StatelessWidget _splashLodingWidget(AsyncSnapshot<Object> snapshot) {
    if(snapshot.hasError) {print('에러 발생'); return Text('Error');} //에러발생시
    else if(snapshot.hasData) {return HomeScreen();} //정상일 경우
    else {return SplashScreen();} //나머지 경우
  }
}

//홈페이지 클래스 선언

class SctbApp extends StatelessWidget {
  const SctbApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      //비머에게 모든 페이지 이동 권한을 줄거임. 비머 플러그인: 페이지 이동을 위한 것
      routeInformationParser: BeamerParser(),
      routerDelegate: _routerDelegate,
    );
  }
}
