import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../const/colors.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text("개인정보 처리방침"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              //개인 정보 정책
              Container(
                width: 400,
                child: Center(
                  child: Text(
                    "개인 정보 정책",
                    style: TextStyle(
                      fontSize: TITLE_FONT_SIZE + 5,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                    '   이주혁님은 Pillin 앱을 무료 앱으로 구축했습니다. 이 서비스는 Pillin이 무료로 제공하며 있는 그대로 사용하도록 되어 있습니다.'),
              ),
              Container(
                child: Text(
                    "   이 페이지는 누군가가 우리 서비스를 사용하기로 결정한 경우 개인 정보 수집, 사용 및 공개에 대한  우리 정책을 방문자에게 알리는 데 사용됩니다."),
              ),
              Container(
                child: Text(
                    "   귀하가 우리 서비스를 사용하기로 선택한 경우, 귀하는 이 정책과 관련된 정보 수집 및 사용에 동의하는 것입니다. 우리가 수집한 개인정보는 서비스 제공 및 개선을 위해 사용됩니다. 우리는 본 개인정보 보호정책에 설명된 경우를 제외하고 누구와도 귀하의 정보를 사용하거나 공유하지 않습니다."),
              ),
              Container(
                child: Text(
                    "   본 개인정보 보호정책에 사용된 용어는 본 개인정보 보호정책에서 달리 정의되지 않는 한 Pillin에서 액세스할 수 있는 이용 약관과 동일한 의미를 갖습니다."),
              ),
              SizedBox(
                height: 10,
              ),
              //정보 수집 및 사용
              Container(
                width: 400,
                child: Center(
                  child: Text(
                    "정보 수집 및 사용",
                    style: TextStyle(
                      fontSize: TITLE_FONT_SIZE + 5,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                    "   더 나은 경험을 위해 당사 서비스를 사용하는 동안 우리는 귀하에게 특정 개인 식별 정보를 제공하도록 요구할 수 있습니다. 요청은 귀하의 장치에 보관되며 저희가 어떤 방식으로든 수집하지 않습니다."),
              ),
              Container(
                child:
                    Text("   앱은 귀하를 식별하는 데 사용되는 정보를 수집할 수 있는 제3자 서비스를 사용합니다."),
              ),
              Container(
                child: Text("앱에서 사용하는 제3자 서비스 제공업체의 개인정보 보호정책 링크"),
              ),
              Container(
                child:
                    //url 달기
                    Container(
                  child: TextButton(
                    child: Text("구글 플레이 서비스 링크"),
                    onPressed: () async {
                      final url =
                          Uri.parse('https://www.google.com/policies/privacy/');
                      if (await canLaunchUrl(url)) {
                        launchUrl(url, mode: LaunchMode.externalApplication);
                      }
                    },
                  ),
                ),
              ),
              //로그 데이터
              SizedBox(
                height: 10,
              ),
              //정보 수집 및 사용
              Container(
                width: 400,
                child: Center(
                  child: Text(
                    "로그 데이터",
                    style: TextStyle(
                      fontSize: TITLE_FONT_SIZE + 5,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                    "   우리는 귀하가 우리 서비스를 이용할 때마다 앱에 오류가 발생하는 경우 Log라는 귀하의 휴대폰에서 (제3자 제품을 통해) 데이터 및 정보를 수집한다는 점을 알려드리고 싶습니다. 데이터. 이 로그 데이터에는 귀하의 장치 인터넷 프로토콜(\"IP\") 주소, 장치 이름, 운영 체제 버전, 우리 서비스 이용 시 앱 구성, 서비스 사용 시간 및 날짜와 같은 정보가 포함될 수 있습니다. 및 기타 통계."),
              ),
              SizedBox(
                height: 10,
              ),
              //쿠키
              Container(
                width: 400,
                child: Center(
                  child: Text(
                    "쿠키",
                    style: TextStyle(
                      fontSize: TITLE_FONT_SIZE + 5,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                    "   쿠키는 일반적으로 익명의 고유 식별자로 사용되는 소량의 데이터가 포함된 파일입니다. 이러한 정보는 귀하가 방문하는 웹사이트에서 귀하의 브라우저로 전송되며 장치의 내부 메모리에 저장됩니다."),
              ),
              Container(
                child: Text(
                    "   본 서비스는 이러한 \"쿠키\"를 명시적으로 사용하지 않습니다. 그러나 앱은 정보를 수집하고 서비스를 개선하기 위해 \"쿠키\"를 사용하는 타사 코드 및 라이브러리를 사용할 수 있습니다. 귀하는 이러한 쿠키를 수락하거나 거부할 수 있으며 쿠키가 귀하의 장치로 전송되는 시기를 알 수 있습니다. 귀하가 쿠키를 거부하기로 선택한 경우\, 본 서비스의 일부를 사용하지 못할 수도 있습니다."),
              ),
              SizedBox(
                height: 10,
              ),
              //서비스 제공자
              Container(
                width: 400,
                child: Center(
                  child: Text(
                    "서비스 제공자",
                    style: TextStyle(
                      fontSize: TITLE_FONT_SIZE + 5,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                    "   우리는 다음과 같은 이유로 제3자 회사 및 개인을 고용할 수 있습니다.\n 1) 서비스를 용이하게 하기 위해 \n 2) 당사를 대신하여 서비스를 제공하기 위해 \n 3) 서비스 관련 서비스를 수행하기 위해 또는 \n 4) 당사 서비스가 어떻게 사용되는지 분석하는 데 도움을 주기 위해"),
              ),
              Container(
                child: Text(
                    "   우리는 이 서비스 사용자에게 이러한 제3자가 사용자의 개인정보에 접근할 수 있음을 알리고 싶습니다. 그 이유는 우리를 대신하여 그들에게 할당된 임무를 수행하기 위해서입니다. 그러나 해당 정보를 다른 목적으로 공개하거나 사용해서는 안 됩니다."),
              ),
              SizedBox(
                height: 10,
              ),
              //보안
              Container(
                width: 400,
                child: Center(
                  child: Text(
                    "보안",
                    style: TextStyle(
                      fontSize: TITLE_FONT_SIZE + 5,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                    "   우리는 귀하의 개인정보 제공에 대한 귀하의 신뢰를 소중히 여기며, 이를 보호하기 위해 상업적으로 허용되는 수단을 사용하기 위해 노력하고 있습니다. 그러나 인터넷을 통한 전송 방법이나 전자 저장 방법은 100% 안전하고 신뢰할 수 없으며 우리는 절대적인 보안을 보장할 수 없습니다."),
              ),
              SizedBox(
                height: 10,
              ),
              //다른 사이트에 대한 링크
              Container(
                width: 400,
                child: Center(
                  child: Text(
                    "다른 사이트에 대한 링크",
                    style: TextStyle(
                      fontSize: TITLE_FONT_SIZE + 5,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                    "   본 서비스에는 다른 사이트에 대한 링크가 포함될 수 있습니다. 타사 링크를 클릭하면 해당 사이트로 이동됩니다. 이러한 외부 사이트는 우리가 운영하지 않습니다. 따라서 우리는 귀하가 이러한 웹사이트의 개인정보 보호정책을 검토할 것을 강력히 권고합니다. 우리는 제3자 사이트나 서비스의 콘텐츠, 개인 정보 보호 정책 또는 관행에 대해 통제권이 없으며 책임을 지지 않습니다."),
              ),
              SizedBox(
                height: 10,
              ),
              //아동의 개인정보 보호
              Container(
                width: 400,
                child: Center(
                  child: Text(
                    "아동의 개인정보 보호",
                    style: TextStyle(
                      fontSize: TITLE_FONT_SIZE + 5,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                    "   우리는 13세 미만의 어린이로부터 고의로 개인 식별 정보를 수집하지 않습니다. 13세 미만의 아동이 우리에게 개인정보를 제공한 사실을 우리가 발견한 경우, 우리는 이를 즉시 서버에서 삭제합니다. 귀하가 부모 또는 보호자이고 귀하의 자녀가 당사에 개인정보를 제공한 사실을 알고 있는 경우, 우리가 필요한 조치를 취할 수 있도록 우리에게 연락해 주십시오."),
              ),
              SizedBox(
                height: 10,
              ),
              //본 개인정보 보호정책의 변경
              Container(
                width: 400,
                child: Center(
                  child: Text(
                    "본 개인정보 보호정책의 변경",
                    style: TextStyle(
                      fontSize: TITLE_FONT_SIZE + 5,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                    "   우리는 수시로 개인정보 보호정책을 업데이트할 수 있습니다. 따라서 이 페이지를 정기적으로 검토하여 변경 사항이 있는지 확인하는 것이 좋습니다. 우리는 이 페이지에 새로운 개인정보 보호정책을 게시하여 변경 사항을 알려드립니다."),
              ),
              Container(
                child: Text("   본 방침은 2024년 2월 2일부터 시행됩니다."),
              ),
              SizedBox(
                height: 10,
              ),
              //문의하기
              Container(
                width: 400,
                child: Center(
                  child: Text(
                    "문의하기",
                    style: TextStyle(
                      fontSize: TITLE_FONT_SIZE + 5,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                    "   우리 개인정보 보호정책에 대해 질문이나 제안 사항이 있는 경우 주저하지 말고 wngur4300@gmail.com으로 문의하십시오."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
