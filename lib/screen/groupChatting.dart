import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_alone_recipe/models/message.dart';
import 'package:home_alone_recipe/provider/userProvider.dart';
import 'package:home_alone_recipe/widget/chatBubble.dart';
import 'package:provider/provider.dart';

class MessageListScreen extends StatefulWidget {
  final String chatId;

  const MessageListScreen(this.chatId, {Key? key}) : super(key: key);

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  TextEditingController controller = TextEditingController();
  late UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '채팅방',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        elevation: 3.0,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<List<MessageModel>>(
        stream: streamMessages(), //중계하고 싶은 Stream을 넣는다.
        builder: (context, asyncSnapshot) {
          if (!asyncSnapshot.hasData) {
            //데이터가 없을 경우 로딩위젯을 표시한다.
            return const Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.hasError) {
            return const Center(
              child: Text('오류가 발생했습니다.'),
            );
          } else {
            List<MessageModel> messages =
                asyncSnapshot.data!; //비동기 데이터가 존재할 경우 리스트뷰 표시
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: ListView.builder(
                        // 상위 위젯의 크기를 기준으로 잡는게 아닌 자식위젯의 크기를 기준으로 잡음
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: ChatBubbles(
                                messages[index].content,
                                messages[index].uid.toString() ==
                                    userProvider.uid,
                                messages[index].nickName,
                                messages[index].sendDate),
                          );
                        })),
                getInputWidget()
              ],
            );
          }
        },
      ),
    );
  }

  Stream<List<MessageModel>> streamMessages() {
    String route = '/chatrooms/' + widget.chatId + '/messages';
    try {
      //찾고자 하는 컬렉션의 스냅샷(Stream)을 가져온다.
      final Stream<QuerySnapshot> snapshots = FirebaseFirestore.instance
          .collection(route)
          .orderBy('sendDate', descending: true)
          .snapshots();

      //스냅샷(Stream)내부의 자료들을 List<MessageModel> 로 변환하기 위해 map을 사용하도록 한다.
      //참고로 List.map()도 List 안의 element들을 원하는 형태로 변환하여 새로운 List로 반환한다
      return snapshots.map((querySnapshot) {
        List<MessageModel> messages =
            []; //querySnapshot을 message로 옮기기 위해 List<MessageModel> 선언
        querySnapshot.docs.forEach((element) {
          //해당 컬렉션에 존재하는 모든 docs를 순회하며 messages 에 데이터를 추가한다.
          messages.add(MessageModel.fromMap(
              id: element.id, map: element.data() as Map<String, dynamic>));
        });
        return messages; //QuerySnapshot에서 List<MessageModel> 로 변경이 됐으니 반환
      }); //Stream<QuerySnapshot> 에서 Stream<List<MessageModel>>로 변경되어 반환됨

    } catch (ex) {
      //오류 발생 처리
      log('error)', error: ex.toString(), stackTrace: StackTrace.current);
      return Stream.error(ex.toString());
    }
  }

  //전송버튼
  Widget getInputWidget() {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(color: Colors.black12, offset: Offset(0, -2), blurRadius: 3)
      ], color: Theme.of(context).bottomAppBarColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  isDense: true,
                  labelStyle: const TextStyle(fontSize: 15),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      color: Colors.black26,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            RawMaterialButton(
              onPressed: _onPressedSendButton,
              //전송버튼을 누를때 동작시킬 메소드
              constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              elevation: 2,
              fillColor: Theme.of(context).colorScheme.primary,
              shape: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.send),
              ),
            )
          ],
        ),
      ),
    );
  }

  //전송버튼을 눌렀을 때 동작
  void _onPressedSendButton() {
    String route = '/chatrooms/' + widget.chatId + '/messages';
    try {
      //서버로 보낼 데이터를 모델클래스에 담아둔다.
      MessageModel messageModel = MessageModel(
          content: controller.text,
          uid: userProvider.uid,
          nickName: userProvider.nickname,
          sendDate: Timestamp.now());

      //Firestore 인스턴스 가져오기
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      //원하는 collection 주소에 새로운 document를 Map의 형태로 추가하는 모습.
      firestore.collection(route).add(messageModel.toMap());
      controller.clear();
    } catch (ex) {
      log('error)', error: ex.toString(), stackTrace: StackTrace.current);
    }
  }
}
