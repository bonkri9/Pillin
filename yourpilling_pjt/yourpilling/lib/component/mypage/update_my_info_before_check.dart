import 'package:flutter/material.dart';
import 'package:yourpilling/component/angle_container.dart';
import 'package:yourpilling/component/mypage/update_my_info.dart';

class UpdateInfoBeforeCheck extends StatefulWidget {
  const UpdateInfoBeforeCheck({super.key});

  @override
  State<UpdateInfoBeforeCheck> createState() => _UpdateInfoBeforeCheckState();
}

class _UpdateInfoBeforeCheckState extends State<UpdateInfoBeforeCheck> {
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SizedBox(
                width: 8,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                  )),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  width: 350,
                  child: Column(
                    children: [
                      Text('비밀번호를 입력해주세요.'),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: "비밀번호",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.pink.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.password),
                        ),
                        obscureText: true,
                        onSubmitted: (String value){
                          if(value == 'password1234'){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=>UpdateMyInfo()),
                            );
                          }else{
                            showDialog(
                                context: context,
                                builder: (context)=>AlertDialog(
                                  title: Text('틀린 비밀번호입니다.'),
                                  actions: [
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text('확인'))
                                  ],
                                ));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
