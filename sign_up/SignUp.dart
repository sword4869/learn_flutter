import 'package:flutter/material.dart';

class SignUpDemo extends StatefulWidget {
  const SignUpDemo({Key? key}) : super(key: key);

  @override
  State<SignUpDemo> createState() => _SignUpDemoState();
}

class _SignUpDemoState extends State<SignUpDemo> {
  // 需要表单的状态，比如校验表单
  GlobalKey _key = GlobalKey<FormState>();

  // 输入的账号和密码
  TextEditingController _user = TextEditingController();
  TextEditingController _pwd = TextEditingController();

  // 都输入完后，失去焦点，或者回到账号输入
  FocusScopeNode _focusScopeNode = FocusScopeNode();
  FocusNode _u = FocusNode(); // 提交的时候再初始化

  // 清理垃圾，key不需要清理。
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _user.dispose();
    _pwd.dispose();
    _focusScopeNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,  // 这是表单的状态
      child: Column(
        children: [
          // 不需要校验，就直接用TextField()
          TextFormField(
            controller: _user,
            focusNode: _u,
            decoration: InputDecoration(
              // 账号图标
              prefixIcon: Icon(Icons.account_box_rounded),
              // 上方小字
              // 直接就是String类型，不用Text()
              labelText: "User",
              // 提示文本
              hintText: "xxx@xxx",
            ),
            validator: (v){
              if(v == null || v.isEmpty){
                return "Please input your account";
              }
            },
            // 检测输入完，切换到输入密码
            textInputAction: TextInputAction.next,
          ),
          TextFormField(
            controller: _pwd,
            decoration: InputDecoration(
              // 密码图标
              prefixIcon: Icon(Icons.password),
              // 上方小字
              // 直接就是String类型，不用Text()
              labelText: "Password",
              // 提示文本
              hintText: "at least 6 characters",
            ),
            validator: (v){
              if(v == null || v.length <6){
                return "Please input your password";
              }
            },
            // 检测输入完，自动提交
            textInputAction: TextInputAction.send,
          ),
          ElevatedButton(
            // 校验FormState
            onPressed: (){
              // user 和 password 的 TextFormField的validator都通过就是 true
              if((_key.currentState as FormState).validate()){
                _focusScopeNode = FocusScope.of(context);
                // 效果一：失去焦点
                // _focusScopeNode.unfocus();

                // 效果二：回到账号输入
                _focusScopeNode.requestFocus(_u);

                // 获取账号和密码的值
                print("${_user.text},${_pwd.text}");

              }else{
                print("false");
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
