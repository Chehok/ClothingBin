//앱의 로딩화면인 스플래쉬 화면 만들었음. 우리는 이 화면을 메인화면애 붙여야함.

//매터라얼 라이브러리를 임포트
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

//스플래쉬 스크린 클래스 선언, 해당 클래스는 메인함수에 사용할 수 있는 인스턴스라고 생각하면 된다.

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);


//위젯 컨테이너에 스플래쉬 스크린의 디자인을 설정할거임.
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      child: Center( //가운데 배치
        child: Column( //컬럼 위젯을 자식으로 넣어서 세로축으로 정렬되게 한다.
          mainAxisAlignment: MainAxisAlignment.center,//이미지 화면 정중앙으로 위치시킴
          children: <Widget>[
            ExtendedImage.asset('assets/images/donation.png'),
            //CircularProgressIndicator(color: Colors.blue,) 프로그레스 로딩 바 (안써서 주석처리)
          ],
        ),
      ),
    );
  }
}

