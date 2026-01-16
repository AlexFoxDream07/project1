import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project1/screens/tables_screen/student_table.dart';
import 'package:project1/identification/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login>{
  final _formKey = GlobalKey<FormState>();
  final _secure = FlutterSecureStorage();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  void _login() async {
    if (_formKey.currentState!.validate()){
      String? saveEm = await _secure.read(key: 'email');
      String? savePass = await _secure.read(key: 'pass');
      if (saveEm == _emailController.text && savePass == _passController.text){
        await _secure.write(key: 'is_login', value: 'true');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StudentTableScreen()));
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Данного пользователя не существует')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вход в систему'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Введите почту'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null){
                    return 'Поле не должно быть пустым';
                  }
                  else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: _passController,
                decoration: InputDecoration(labelText: 'Введите пароль'),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (value) {
                  if (value == null){
                    return 'Поле не должно быть пустым';
                  }
                  else {
                    return null;
                  }
                },
              ),
              ElevatedButton(
                onPressed: _login,
                child: Text('Подтвердить')
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Register())
                  );
                },
                child: Text('Новый пользователь?')
              )
            ],
          ) 
        ), 
      ),
    );
  }
}