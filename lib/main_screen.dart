import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController controller = TextEditingController();
  bool isEditMode = false; // 자기소개 수정 모드 상태

  @override
  void initState() {
    super.initState();
    //위젯이 처음 실행되엇을때 이곳을 호출한다
    getMemoData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.accessibility,
          color: Colors.black,
          size: 30,
        ),
        title: const Text(
          "自己紹介",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              height: 200,
              child: Image.asset(
                'assets/kim_picture.jpg',
              ),
            ),
            Row(
              /// 이름

              children: [
                Container(
                    margin:
                        const EdgeInsets.only(bottom: 5, left: 20, right: 20),
                    width: 100,
                    child: const Text(
                      '名前',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text('KIM JAEYOUNG(キム ジェヨン)'),
              ],
            ),
            Row(
              /// 나이

              children: [
                Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    width: 100,
                    child: const Text(
                      '年齢',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text('23 (1999.12.06)'),
              ],
            ),
            Row(
              /// 취미

              children: [
                Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    width: 100,
                    child: const Text(
                      '趣味',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text('プログラミング・筋トレ・料理'),
              ],
            ),
            Row(
              /// 꿈

              children: [
                Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    width: 100,
                    child: const Text(
                      '夢',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text('アプリケーションエンジニア'),
              ],
            ),
            Row(
              /// 학력

              children: [
                Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    width: 100,
                    child: const Text(
                      '学歴',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text('立教大学・福祉学科（24卒）'),
              ],
            ),
            Row(
              /// 프로그래밍 언어

              children: [
                Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    width: 100,
                    child: const Text(
                      'プログラミング',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text('Java・Kotlin(Android) / Dart(Flutter)'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 20),
                  child: const Row(
                    children: [
                      Text(
                        'Memo',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.only(right: 20, top: 20),
                    child: Icon(Icons.save,
                        size: 25,
                        color: isEditMode == true
                            ? Colors.blueAccent
                            : Colors.black),
                  ),
                  onTap: () async {
                    if (isEditMode == false) {
                      setState(() {
                        //위젯 업데이트
                        isEditMode = true;
                      });
                    } else {
                      if (controller.text.isEmpty) {
                        //snackbar로 메시지 안내
                        var snackBar = const SnackBar(
                          content: Text('メモを作成してください。'),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                      //저장 로직 구현 shared preferences
                      var sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.setString('memo', controller.text);

                      setState(() {
                        isEditMode = false;
                      });
                    }
                  },
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextField(
                enabled: isEditMode, //기본 true 텍스트필드 활성화/비활성화
                maxLines: 4,
                controller: controller,
                decoration: InputDecoration(
                    hintText: 'メモを作成する。',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Color(0xffd9d9d9)))),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getMemoData() async {
    //기존에 저장된 자기소개 데이터가 있다면 로드해오기!
    var sharedPreferences = await SharedPreferences.getInstance();
    String memoMsg = sharedPreferences.getString('memo') ?? "";
    controller.text = memoMsg;
  }
}
