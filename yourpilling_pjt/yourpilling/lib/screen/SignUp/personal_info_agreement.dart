import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:provider/provider.dart';

import '../../store/inventory_store.dart';

class PersonalAgreementDialog extends StatefulWidget {
  const PersonalAgreementDialog({super.key});

  @override
  State<PersonalAgreementDialog> createState() =>
      _PersonalAgreementDialogState();
}

class _PersonalAgreementDialogState extends State<PersonalAgreementDialog> {
  bool agreement = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('개인정보 수집 및 이용 동의'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              width: 300,
              child: RichText(
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                maxLines: 5,
                strutStyle: StrutStyle(fontSize: 16),
                text: TextSpan(
                  text:
                      'Pillin은 영양제 루틴 관리 서비스 Pillin의 회원가입, 고객상담 및 AS, 고지사항 전달 등을 위해 아래와 같이 개인 정보를 수집 및 이용합니다.',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "수집 목적",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                "수집 항목",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 130,
                  child: RichText(
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    strutStyle: StrutStyle(fontSize: 16),
                    text: TextSpan(
                      text: '회원 식별 및 회원제 서비스 제공',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  )),
              Container(
                  width: 120,
                  child: RichText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    strutStyle: StrutStyle(fontSize: 16),
                    text: TextSpan(
                      text: '아이디, 비밀번호, 이름, 닉네임',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  )),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  width: 100,
                  child: RichText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    strutStyle: StrutStyle(fontSize: 16),
                    text: TextSpan(
                      text: '서비스 변경사항 및 고지사항 전달',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  )),
              Text(
                "이메일",
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "수집 근거",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Container(
                  width: 150,
                  child: RichText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    strutStyle: StrutStyle(fontSize: 16),
                    text: TextSpan(
                      text: '개인정보 보호법 제15조 제1항',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              width: 300,
              child: RichText(
                textAlign: TextAlign.center,
                maxLines: 4,
                strutStyle: StrutStyle(fontSize: 16),
                text: TextSpan(
                  text:
                      '귀하는 Pillin의 서비스 이용에 필요한 최소한의 개인정보 수집 및 이용에 동의하지 않을 수 있으나, 동의를 거부할 경우 회원제 서비스 이용이 불가합니다.',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              )),
          SizedBox(
            height: 15,
          ),
          Container(
              width: 300,
              child: RichText(
                textAlign: TextAlign.center,
                maxLines: 4,
                strutStyle: StrutStyle(fontSize: 16),
                text: TextSpan(
                  text: '위 개인정보 수집 및 이용에 동의합니다.(필수)',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              )),
          Row(
            children: [
              Text("동의함"),
              SizedBox(
                width: 15,
              ),
              Checkbox(
                  value: agreement,
                  onChanged: (value) {
                    setState(() {
                      agreement = value ?? false;
                      print('동의여부 $agreement');
                    });
                  })
            ],
          )
        ],
      ),
      actions: <Widget>[
        MaterialButton(
          color: Colors.greenAccent,
          textColor: Colors.white,
          child: const Text('완료'),
          onPressed: () {
            Navigator.pop(context, agreement);
          },
        ),
        MaterialButton(
          color: Colors.redAccent,
          textColor: Colors.white,
          child: const Text('취소'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ],
    );
  }
}

Future<bool> showPersonalAgreementDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return PersonalAgreementDialog();
    },
  );
}
