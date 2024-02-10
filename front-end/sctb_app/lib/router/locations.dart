import 'package:beamer/beamer.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sctb_app/screens/home_screen.dart';


//비머 홈 로케이션 클래스 생성(인스턴스)
class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state){
    return[BeamPage(child: HomeScreen(), key:ValueKey('home'))];
  }

  @override
  List get pathBlueprints => ['/'];
}
