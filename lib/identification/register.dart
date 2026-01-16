import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project1/identification/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmController = TextEditingController();
  final _secure = FlutterSecureStorage();

  void _register() async  {
    if (_formKey.currentState!.validate()){
      if (_emailController.text == await _secure.read(key: 'email')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Эта почта уже зарегистрированна')));
      } 
      else {
        if (_emailController.text == _passController.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Пароль и почта не должны совподать')));
        }
        else {
          if (_passController.text == _confirmController.text) {
            await _secure.write(key: 'email', value: _emailController.text);
            await _secure.write(key: 'pass', value: _passController.text);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Регистрация прошла успешно')));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()));
          }
          else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('')));
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Регистрация", style: TextStyle(fontSize: 24)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 25,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Введите почту'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  final emailReg = RegExp(
                    r"^[a-zA-Z0-9._\%-+]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z]+)$",
                  );
                  if (value == null){
                    return 'Поле не должно быть пустым';
                  } else if (!emailReg.hasMatch(value)){
                    return 'Не корректный ввод данных';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: _passController,
                decoration: InputDecoration(labelText: 'Введите пароль'),
                obscureText: true,
                validator: (value) {
                  final passReg = RegExp(
                    r"^(?=.*[A-Z])(?=.*\d).{6,}$",
                  );
                  if (value == null){
                    return 'Поле не должно быть пустым';
                  } else if (!passReg.hasMatch(value)){
                    return 'Пароль должен сождержать цифры, заглавные буквы, состоять из 6 или более символов';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: _confirmController,
                decoration: InputDecoration(labelText: 'Повторно введите пароль'),
                obscureText: true,
                validator: (value) {
                  if (value == null){
                    return 'Поле не должно быть пустым';
                  } else {
                    return null;
                  }
                },
              ),
              ElevatedButton(
                onPressed: _register, 
                child: Text('Зарегистрироваться')
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login())
                  );
                },
                child: Text('Уже зарегистрирован аккаунт?')
              )
            ],
          )
        ),
      ),
    );
  }
}