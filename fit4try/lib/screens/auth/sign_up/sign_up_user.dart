import 'dart:async';

import 'package:flutter/material.dart';

class SignUpUser extends StatefulWidget {
  const SignUpUser({Key? key}) : super(key: key);

  @override
  State<SignUpUser> createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final List<TextEditingController> _controllers =
      List.generate(5, (_) => TextEditingController());
  bool _isPasswordVisible = false;
  bool _isNextButtonEnabled = false;

  // StreamController to notify changes
  late StreamController<bool> _buttonStateController;

  // Map to store colors for each step
  Map<int, Color> _stepColors = {
    0: Colors.red.shade200,
    1: Colors.orange.shade300,
    2: Colors.yellow.shade400,
    3: Colors.green.shade500,
    4: Colors.blue.shade600,
  };

  @override
  void initState() {
    super.initState();

    // Initialize StreamController
    _buttonStateController = StreamController<bool>.broadcast();

    // Listen to changes in text fields
    for (var controller in _controllers) {
      controller.addListener(_updateNextButtonState);
    }
  }

  @override
  void dispose() {
    _buttonStateController.close(); // Close the stream controller
    for (var controller in _controllers) {
      controller.removeListener(_updateNextButtonState);
      controller.dispose();
    }
    super.dispose();
  }

  void _updateNextButtonState() {
    bool isFilled = _areAllFieldsFilled();
    _buttonStateController.add(isFilled); // Notify stream of state change
    setState(() {
      _isNextButtonEnabled = isFilled;
    });
  }

  void _nextPage() {
    if (_currentStep < 4) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _previousPage() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  bool _areAllFieldsFilled() {
    return _controllers.every((controller) => controller.text.isNotEmpty);
  }

  Widget _buildStepContent(int step) {
    switch (step) {
      case 0:
        return UserInfoStep(
          controllers: _controllers,
          isPasswordVisible: _isPasswordVisible,
          togglePasswordVisibility: _togglePasswordVisibility,
        );
      case 1:
        return PlaceholderStep(
          color: _stepColors[1]!,
          text: 'Step 2', // Replace with actual step content
        );
      case 2:
        return PlaceholderStep(
          color: _stepColors[2]!,
          text: 'Step 3', // Replace with actual step content
        );
      case 3:
        return PlaceholderStep(
          color: _stepColors[3]!,
          text: 'Step 4', // Replace with actual step content
        );
      case 4:
        return PlaceholderStep(
          color: _stepColors[4]!,
          text: 'Step 5', // Replace with actual step content
        );
      default:
        return Container();
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Widget _buildProgressBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          width: 40.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: index <= _currentStep ? _stepColors[index] : Colors.grey,
            borderRadius: BorderRadius.circular(4.0),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 75),
          _buildProgressBar(),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildStepContent(index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentStep > 0)
                  ElevatedButton(
                    onPressed: _previousPage,
                    child: Text('Geri'),
                  ),
                StreamBuilder<bool>(
                  stream: _buttonStateController.stream,
                  initialData: _isNextButtonEnabled,
                  builder: (context, snapshot) {
                    return ElevatedButton(
                      onPressed: snapshot.data ?? false ? _nextPage : null,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.grey;
                          }
                          return Colors.blue;
                        }),
                      ),
                      child: Text('İleri'),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class UserInfoStep extends StatelessWidget {
  final List<TextEditingController> controllers;
  final bool isPasswordVisible;
  final VoidCallback togglePasswordVisibility;

  UserInfoStep({
    required this.controllers,
    required this.isPasswordVisible,
    required this.togglePasswordVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kullanıcı Bilgileri 👤',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controllers[0],
              decoration: InputDecoration(
                labelText: 'İsim Soyisim',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controllers[1],
              decoration: InputDecoration(
                labelText: 'Kullanıcı Adı',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controllers[2],
              decoration: InputDecoration(
                labelText: 'E-mail Adresi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controllers[3],
              decoration: InputDecoration(
                labelText: 'Şifre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: togglePasswordVisibility,
                ),
              ),
              obscureText: !isPasswordVisible,
            ),
            SizedBox(height: 16),
            TextField(
              controller: controllers[4],
              decoration: InputDecoration(
                labelText: 'Şifre Tekrar',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: togglePasswordVisibility,
                ),
              ),
              obscureText: !isPasswordVisible,
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceholderStep extends StatelessWidget {
  final Color color;
  final String text;

  const PlaceholderStep({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
