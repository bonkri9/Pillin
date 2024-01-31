import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/component/inventory/inventory_screen.dart';
import 'package:input_quantity/input_quantity.dart';

var insertInvenInfo = [
  {
    'pillId': 2, //영양제 번호
    'startAt': 2024 - 01 - 29, //복용 시작일
    'takeYn': false, //바로 복용할건지 여부
    'remains': 50, //잔여량
    'totalCount': 60, //총 보유 갯수
    'takeWeekdays': ['MON', 'WED', 'FRI'], //복용 요일
    'takeCount': 1, //일일 복용 횟수 [회], 변경 불가능
    'takeOnceAmount': 2, //1회 섭취량 [정], 변경 불가능
  }
];

var pillDetailInfo = [
  {
    'pillName': '트리플 스트렝스 오메가3 피쉬오일 (오메가3 1040mg)', // 영양제 이름
    'manufacturer': '나우푸드', // 제조사
    'expirationAt': '2년', //유효복용기간
    'usageInstructions': '물과 함께 잘 드세요', //복약지도
    'primaryFunctionality': '기력 증진', //주요기능
    'precautions': '약이 상당히 크니 삼킬 때 조심하세요', //주의사항
    'storageInstructions': '상온 보관', //보관방법
    'standardSpecification': '붕해시험 : 적합', //기준규격
    'productForm': '고체형', // 제형
    'takecycle': '1', //1일
    'takeCount': '1', //1회
    'takeOnceAmount': '2', //2정
    'createdAt': '',
    'updatedAt': '2024-01-29', //제품 정보 수정날짜
    'nutrients': [
      {
        'nutrition': '오메가3',
        'amount': '40',
        'unit': 'mg',
        'includePercent': '3.33',
      } //사람마다 등록한 날이 다를텐데 userId없어도 되는지? createAt, updateAt 관련.
    ]
  },
];

const List<Widget> days = <Widget>[
  Text('월'),
  Text('화'),
  Text('수'),
  Text('목'),
  Text('금'),
  Text('토'),
  Text('일'),
];

final List<bool> _selectedDays = <bool>[false, true, false, true, false, true, false];

bool _takeYnChecked = false;

class InsertInventory extends StatefulWidget {
  const InsertInventory({super.key});

  @override
  State<InsertInventory> createState() => _InsertInventoryState();
}

class _InsertInventoryState extends State<InsertInventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BACKGROUND_COLOR,
        leading: IconButton(
          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 24,
          disabledColor: Colors.black,
        ),
      ),
      body: Container(
        color: BACKGROUND_COLOR,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _InsertInvenUpper(),
            SizedBox(
              height: 30,
            ),
            _InsertInvenContent(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: BACKGROUND_COLOR,
        child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.redAccent)),
          child: Text('등록', style: TextStyle(color: Colors.white),),
          onPressed: (){
            // Navigator.push(context,
            //    MaterialPageRoute(builder: (context)=>Inventory()) );
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context){
                  return Container(
                    width: 450,
                    height: 200,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.,
                          children: [
                            // const Text('modal bottomsheet'),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
                                // onPressed: () => Navigator.pop(context),
                                onPressed: () => Navigator.push(context,
                                   MaterialPageRoute(builder: (context)=>Inventory()) ),
                                child: const Text('등록완료!', style: TextStyle(color: Colors.white),)),
                          ],
                      ),
                  );
                });
          },
        ),
      ),

    );
  }
}

class _InsertInvenUpper extends StatefulWidget {
  const _InsertInvenUpper({super.key});

  @override
  State<_InsertInvenUpper> createState() => _InsertInvenUpperState();
}

class _InsertInvenUpperState extends State<_InsertInvenUpper> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '영양제 재고 등록',
          style: TextStyle(fontSize: 30),
        ),
        Row(
          children: [
            Text(
              '섭취 중',
              style: TextStyle(fontSize: 18),
            ),
            // Switch(
            //     value: _takeYnChecked,
            //     activeColor: Color(0xFFFF6666),
            //     onChanged: (bool? value) {
            //       setState(() {
            //         _takeYnChecked = value ?? false;
            //       });
            //     }),
            LiteRollingSwitch(
                width: 100,
                onTap: () {},
                onDoubleTap: () {},
                onSwipe: () {},
                value: _takeYnChecked,
                textOn: '복용중',
                textOff: '미복용',
                colorOn: Colors.greenAccent,
                colorOff: Colors.redAccent,
                iconOn: Icons.done,
                iconOff: Icons.do_not_disturb_on_outlined,
                textSize: 13,
                onChanged: (bool? value) {
                  setState(() {
                    _takeYnChecked = value ?? false;
                  });
                }),
          ],
        )
      ],
    );
  }
}

class _InsertInvenContent extends StatefulWidget {
  const _InsertInvenContent({super.key});

  @override
  State<_InsertInvenContent> createState() => _InsertInvenContentState();
}

class _InsertInvenContentState extends State<_InsertInvenContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              fit: BoxFit.cover,
              'assets/image/비타민B.jpg',
              width: 250,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('제품명 : ',style: TextStyle(fontSize: 20)),
                      Flexible(
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            strutStyle: StrutStyle(fontSize: 10),
                            text: TextSpan(
                              text: '${pillDetailInfo[0]['pillName']}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                    child: Row(
                      children: [
                        Text('총 알약 수 : '),
                        // Text('${insertInvenInfo[0]['totalCount']}'),
                        // Text('정'),
                        SizedBox(
                          width: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InputQty(
                              maxVal: 500,
                              initVal: 1,
                              steps: 1,
                              minVal: 0,
                              validator: (value){
                                if(value == null) return "입력이 필요합니다.";
                                if(value < 0){
                                  return "";
                                }else if(value>500){
                                  return "입력값 초과";
                                }
                                return null;
                              },
                              // qtyFormProps: QtyFormProps(enableTyping: false),
                              decoration: QtyDecorationProps(
                                isBordered: false,
                                // borderShape: BorderShapeBtn.circle,
                                minusBtn: Icon(
                                  Icons.remove_circle_outline_rounded
                                ),
                                plusBtn: Icon(
                                  Icons.add_circle_outline_rounded
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                ),
                Container(
                    height: 50,
                    child: Row(
                      children: [
                        Text('잔여 알약 수 : '),
                        // Text('${insertInvenInfo[0]['remains']}'),
                        // Text('정'),
                        SizedBox(
                          width: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InputQty(
                              maxVal: 500,
                              initVal: 1,
                              steps: 1,
                              minVal: 0,
                              validator: (value){
                                if(value == null) return "입력이 필요합니다.";
                                if(value < 0){
                                  return "";
                                }else if(value>500){
                                  return "입력값 초과";
                                }
                                return null;
                              },
                              // qtyFormProps: QtyFormProps(enableTyping: false),
                              decoration: QtyDecorationProps(
                                isBordered: false,
                                // borderShape: BorderShapeBtn.circle,
                                minusBtn: Icon(
                                    Icons.remove_circle_outline_rounded
                                ),
                                plusBtn: Icon(
                                    Icons.add_circle_outline_rounded
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                ),
                // Container(
                //     child: Row(
                //       children: [
                //         Text('섭취 루틴 : '),
                //         Text('${insertInvenInfo[0]['takeWeekdays']}'),
                //       ],
                //     )
                // ),
                // ToggleButtons(
                //   onPressed: (int index) {
                //     // All buttons are selectable.
                //     setState(() {
                //       _selectedDays[index] = !_selectedDays[index];
                //     });
                //   },
                //   borderRadius: const BorderRadius.all(Radius.circular(8)),
                //   selectedBorderColor: Colors.green[700],
                //   selectedColor: Colors.white,
                //   fillColor: Colors.green[200],
                //   color: Colors.green[400],
                //   constraints: const BoxConstraints(
                //     minHeight: 40.0,
                //     minWidth: 40.0,
                //   ),
                //   isSelected: _selectedDays,
                //   children: days,
                // ),
                Container(
                    child: Row(
                      children: [
                        Text('일일 복용 횟수 : '),
                        Text('${insertInvenInfo[0]['takeCount']}'),
                        Text('회(변경 불가능)'),
                      ],
                    )
                ),
                Container(
                    child: Row(
                      children: [
                        Text('1회 복용량 : '),
                        Text('${insertInvenInfo[0]['takeOnceAmount']}'),
                        Text('정(변경 불가능)'),
                      ],
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
