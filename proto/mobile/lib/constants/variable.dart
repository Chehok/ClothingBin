// const serverUrl = 'http://221.146.167.89:8080/app';
import 'package:web_socket_channel/io.dart';

const address = '210.123.255.110';
// const address = '15.165.100.112';

const serverUrl = 'http://$address:8080/app';
final chatUrl = IOWebSocketChannel.connect('ws://$address:8080/ws/chat');
// const serverUrl = 'http://15.165.100.112:8080/app';

const clothingBinId = 1;
var userId = ""; // 서버에서 로그인 / 비로그인 시 userId를 넘겨줌.
var locker = [false, true, true, true, true, true, true, true, true, true];
var lockNum = 0; // index + 1
var certifyMember = 'N';