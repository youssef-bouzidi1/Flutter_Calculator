import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Mode Calculator',
      theme: ThemeData(
        useMaterial3: true, // Opt-in for Material 3
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: const TextStyle(fontSize: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelStyle: const TextStyle(fontSize: 16),
        ),
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: const TextStyle(fontSize: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelStyle: const TextStyle(fontSize: 16),
        ),
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
      themeMode: ThemeMode.system, // Use system theme by default
      home: const HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Mode Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildModeCard(
              context: context,
              title: 'Basic Calculator',
              icon: Icons.calculate,
              color: Colors.blue,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BasicCalculatorPage()),
              ),
            ),
            _buildModeCard(
              context: context,
              title: 'Scientific Calculator',
              icon: Icons.science,
              color: Colors.green,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScientificCalculatorPage()),
              ),
            ),
            _buildModeCard(
              context: context,
              title: 'Unit Converter',
              icon: Icons.swap_horiz,
              color: Colors.orange,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UnitConverterPage()),
              ),
            ),
            _buildModeCard(
              context: context,
              title: 'Currency Converter',
              icon: Icons.currency_exchange,
              color: Colors.purple,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CurrencyConverterPage()),
              ),
            ),
            _buildModeCard(
              context: context,
              title: 'Equation Solver',
              icon: Icons.functions,
              color: Colors.teal,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EquationSolverPage()),
              ),
            ),
            _buildModeCard(
              context: context,
              title: 'Matrix Solver',
              icon: Icons.grid_on,
              color: Colors.redAccent,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MatrixSolverPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Basic Calculator Page
class BasicCalculatorPage extends StatefulWidget {
  const BasicCalculatorPage({super.key});

  @override
  State<BasicCalculatorPage> createState() => _BasicCalculatorPageState();
}

class _BasicCalculatorPageState extends State<BasicCalculatorPage> {
  String _input = '';
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Calculator'),
      ),
      body: Column(
        children: [
          // Display
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.bottomRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(_input, style: Theme.of(context).textTheme.headlineSmall),
                Text(_result, style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          // Keypad
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              padding: const EdgeInsets.all(8),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                _buildCalculatorButton('C', backgroundColor: Colors.redAccent),
                _buildCalculatorButton('(', backgroundColor: Theme.of(context).colorScheme.surfaceVariant),
                _buildCalculatorButton(')', backgroundColor: Theme.of(context).colorScheme.surfaceVariant),
                _buildCalculatorButton('÷', backgroundColor: Theme.of(context).colorScheme.secondary),
                _buildCalculatorButton('7'),
                _buildCalculatorButton('8'),
                _buildCalculatorButton('9'),
                _buildCalculatorButton('×', backgroundColor: Theme.of(context).colorScheme.secondary),
                _buildCalculatorButton('4'),
                _buildCalculatorButton('5'),
                _buildCalculatorButton('6'),
                _buildCalculatorButton('-', backgroundColor: Theme.of(context).colorScheme.secondary),
                _buildCalculatorButton('1'),
                _buildCalculatorButton('2'),
                _buildCalculatorButton('3'),
                _buildCalculatorButton('+', backgroundColor: Theme.of(context).colorScheme.secondary),
                _buildCalculatorButton('0'),
                _buildCalculatorButton('.'),
                _buildCalculatorButton('=', backgroundColor: Theme.of(context).colorScheme.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatorButton(String text, {Color? backgroundColor}) {
    return ElevatedButton(
      onPressed: () => _handleButtonPress(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: _useWhiteForeground(backgroundColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 24)),
    );
  }

  Color? _useWhiteForeground(Color? backgroundColor) {
    if (backgroundColor == null) return null;
    return ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.light ? Colors.white : null;
  }

  void _handleButtonPress(String text) {
    if (text == 'C') {
      setState(() {
        _input = '';
        _result = '';
      });
      return;
    }

    if (text == '=') {
      _calculate();
      return;
    }
    setState(() {
      _input += text;
    });
  }

  void _calculate() {
    try {
      String expression = _input.replaceAll('×', '*').replaceAll('÷', '/');
      final parser = ExpressionParser();
      final result = parser.eval(expression);

      setState(() {
        _result = result.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }
}

// Scientific Calculator Page
class ScientificCalculatorPage extends StatefulWidget {
  const ScientificCalculatorPage({super.key});

  @override
  State<ScientificCalculatorPage> createState() => _ScientificCalculatorPageState();
}

class _ScientificCalculatorPageState extends State<ScientificCalculatorPage> {
  String _input = '';
  String _result = '';
  bool _isRadians = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scientific Calculator'),
        actions: [
          TextButton(
            onPressed: () => setState(() => _isRadians = !_isRadians),
            child: Text(_isRadians ? 'RAD' : 'DEG', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
          ),
        ],
      ),
      body: Column(
        children: [
          // Display
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.bottomRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(_input, style: Theme.of(context).textTheme.headlineSmall),
                Text(_result, style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          // Scientific Functions
          Expanded(
            child: GridView.count(
              crossAxisCount: 5,
              padding: const EdgeInsets.all(8),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                _buildCalculatorButton('C', backgroundColor: Colors.redAccent),
                _buildCalculatorButton('(', backgroundColor: Theme.of(context).colorScheme.surfaceVariant),
                _buildCalculatorButton(')', backgroundColor: Theme.of(context).colorScheme.surfaceVariant),
                _buildCalculatorButton('%', backgroundColor: Theme.of(context).colorScheme.secondary),
                _buildCalculatorButton('AC', backgroundColor: Theme.of(context).colorScheme.error), // Example of using error color

                _buildCalculatorButton('sin'),
                _buildCalculatorButton('cos'),
                _buildCalculatorButton('tan'),
                _buildCalculatorButton('√'),
                _buildCalculatorButton('^'),

                _buildCalculatorButton('log'),
                _buildCalculatorButton('ln'),
                _buildCalculatorButton('π'),
                _buildCalculatorButton('e'),
                _buildCalculatorButton('!'),

                _buildCalculatorButton('7'),
                _buildCalculatorButton('8'),
                _buildCalculatorButton('9'),
                _buildCalculatorButton('÷', backgroundColor: Theme.of(context).colorScheme.secondary),
                _buildCalculatorButton('×', backgroundColor: Theme.of(context).colorScheme.secondary),

                _buildCalculatorButton('4'),
                _buildCalculatorButton('5'),
                _buildCalculatorButton('6'),
                _buildCalculatorButton('-', backgroundColor: Theme.of(context).colorScheme.secondary),
                _buildCalculatorButton('+', backgroundColor: Theme.of(context).colorScheme.secondary),

                _buildCalculatorButton('1'),
                _buildCalculatorButton('2'),
                _buildCalculatorButton('3'),
                _buildCalculatorButton('.', backgroundColor: Theme.of(context).colorScheme.surfaceVariant),
                _buildCalculatorButton('=', backgroundColor: Theme.of(context).colorScheme.primary),

                _buildCalculatorButton('0'),
                const SizedBox.shrink(), // Placeholder for empty space
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatorButton(String text, {Color? backgroundColor}) {
    return ElevatedButton(
      onPressed: () => _handleButtonPress(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: _useWhiteForeground(backgroundColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 24)),
    );
  }

  Color? _useWhiteForeground(Color? backgroundColor) {
    if (backgroundColor == null) return null;
    return ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.light ? Colors.white : null;
  }

  void _handleButtonPress(String text) {
    if (text == 'C' || text == 'AC') {
      setState(() {
        _input = '';
        _result = '';
      });
      return;
    }

    if (text == '=') {
      _calculate();
      return;
    }
    setState(() {
      _input += text;
    });
  }

  void _calculate() {
    try {
      String expression = _input.replaceAll('×', '*').replaceAll('÷', '/').replaceAll('√', 'sqrt').replaceAll('π', 'pi').replaceAll('^', '**');
      final parser = ExpressionParser();
      final result = parser.eval(expression);

      setState(() {
        _result = result.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }
}

// Unit Converter Page
class UnitConverterPage extends StatefulWidget {
  const UnitConverterPage({super.key});

  @override
  State<UnitConverterPage> createState() => _UnitConverterPageState();
}

class _UnitConverterPageState extends State<UnitConverterPage> {
  String _selectedCategory = 'Length';
  String _fromUnit = 'Meters';
  String _toUnit = 'Feet';
  final _inputController = TextEditingController();
  String _result = '';

  final Map<String, List<String>> _units = {
    'Length': ['Meters', 'Feet', 'Inches', 'Kilometers'],
    'Weight': ['Kilograms', 'Pounds', 'Ounces', 'Grams'],
    'Temperature': ['Celsius', 'Fahrenheit', 'Kelvin'],
    'Area': ['Square Meters', 'Square Feet', 'Square Kilometers', 'Hectares', 'Acres'],
    'Volume': ['Cubic Meters', 'Cubic Feet', 'Liters', 'Gallons (US)', 'Milliliters'],
    'Speed': ['Meters per second', 'Kilometers per hour', 'Miles per hour', 'Knots'],
    'Data': ['Bytes', 'Kilobytes', 'Megabytes', 'Gigabytes', 'Terabytes'],
    'Energy': ['Joules', 'Kilojoules', 'Calories', 'Kilocalories'],
    'Pressure': ['Pascals', 'Kilopascals', 'Atmospheres', 'Bar', 'PSI'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(labelText: 'Category'),
              items: _units.keys.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                  _fromUnit = _units[_selectedCategory]![0];
                  _toUnit = _units[_selectedCategory]![1];
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Enter Value'),
                  ),
                ),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: _fromUnit,
                  items: _units[_selectedCategory]!.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _fromUnit = newValue!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(_result, style: Theme.of(context).textTheme.headlineSmall),
                ),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: _toUnit,
                  items: _units[_selectedCategory]!.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _toUnit = newValue!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
          ],
        ),
      ),
    );
  }

  void _convert() {
    final input = double.tryParse(_inputController.text);
    if (input == null) {
      setState(() {
        _result = 'Invalid input';
      });
      return;
    }

    double result;
    switch (_selectedCategory) {
      case 'Length':
        result = _convertLength(input, _fromUnit, _toUnit);
        break;
      case 'Weight':
        result = _convertWeight(input, _fromUnit, _toUnit);
        break;
      case 'Temperature':
        result = _convertTemperature(input, _fromUnit, _toUnit);
        break;
      case 'Area':
        result = _convertArea(input, _fromUnit, _toUnit);
        break;
      case 'Volume':
        result = _convertVolume(input, _fromUnit, _toUnit);
        break;
      case 'Speed':
        result = _convertSpeed(input, _fromUnit, _toUnit);
        break;
      case 'Data':
        result = _convertData(input, _fromUnit, _toUnit);
        break;
      case 'Energy':
        result = _convertEnergy(input, _fromUnit, _toUnit);
        break;
      case 'Pressure':
        result = _convertPressure(input, _fromUnit, _toUnit);
        break;
      default:
        result = 0.0;
    }

    setState(() {
      _result = result.toString();
    });
  }

  double _convertLength(double value, String fromUnit, String toUnit) {
    switch (fromUnit) {
      case 'Meters':
        if (toUnit == 'Feet') return value * 3.28084;
        if (toUnit == 'Inches') return value * 39.3701;
        if (toUnit == 'Kilometers') return value / 1000;
        return value;
      case 'Feet':
        if (toUnit == 'Meters') return value / 3.28084;
        if (toUnit == 'Inches') return value * 12;
        if (toUnit == 'Kilometers') return value / 3280.84;
        return value;
      case 'Inches':
        if (toUnit == 'Meters') return value / 39.3701;
        if (toUnit == 'Feet') return value / 12;
        if (toUnit == 'Kilometers') return value / 39370.1;
        return value;
      case 'Kilometers':
        if (toUnit == 'Meters') return value * 1000;
        if (toUnit == 'Feet') return value * 3280.84;
        if (toUnit == 'Inches') return value * 39370.1;
        return value;
      default:
        return value;
    }
  }

  double _convertWeight(double value, String fromUnit, String toUnit) {
    switch (fromUnit) {
      case 'Kilograms':
        if (toUnit == 'Pounds') return value * 2.20462;
        if (toUnit == 'Ounces') return value * 35.274;
        if (toUnit == 'Grams') return value * 1000;
        return value;
      case 'Pounds':
        if (toUnit == 'Kilograms') return value / 2.20462;
        if (toUnit == 'Ounces') return value * 16;
        if (toUnit == 'Grams') return value * 453.592;
        return value;
      case 'Ounces':
        if (toUnit == 'Kilograms') return value / 35.274;
        if (toUnit == 'Pounds') return value / 16;
        if (toUnit == 'Grams') return value * 28.3495;
        return value;
      case 'Grams':
        if (toUnit == 'Kilograms') return value / 1000;
        if (toUnit == 'Pounds') return value / 453.592;
        if (toUnit == 'Ounces') return value / 28.3495;
        return value;
      default:
        return value;
    }
  }

  double _convertTemperature(double value, String fromUnit, String toUnit) {
    switch (fromUnit) {
      case 'Celsius':
        if (toUnit == 'Fahrenheit') return (value * 9 / 5) + 32;
        if (toUnit == 'Kelvin') return value + 273.15;
        return value;
      case 'Fahrenheit':
        if (toUnit == 'Celsius') return (value - 32) * 5 / 9;
        if (toUnit == 'Kelvin') return (value - 32) * 5 / 9 + 273.15;
        return value;
      case 'Kelvin':
        if (toUnit == 'Celsius') return value - 273.15;
        if (toUnit == 'Fahrenheit') return (value - 273.15) * 9 / 5 + 32;
        return value;
      default:
        return value;
    }
  }

  double _convertArea(double value, String fromUnit, String toUnit) {
    switch (fromUnit) {
      case 'Square Meters':
        if (toUnit == 'Square Feet') return value * 10.7639;
        if (toUnit == 'Square Kilometers') return value / 1000000;
        if (toUnit == 'Hectares') return value / 10000;
        if (toUnit == 'Acres') return value / 4046.86;
        return value;
      case 'Square Feet':
        if (toUnit == 'Square Meters') return value / 10.7639;
        if (toUnit == 'Square Kilometers') return value / 10763910;
        if (toUnit == 'Hectares') return value / 107639;
        if (toUnit == 'Acres') return value / 43560;
        return value;
      case 'Square Kilometers':
        if (toUnit == 'Square Meters') return value * 1000000;
        if (toUnit == 'Square Feet') return value * 10763910;
        if (toUnit == 'Hectares') return value * 100;
        if (toUnit == 'Acres') return value * 247.105;
        return value;
      case 'Hectares':
        if (toUnit == 'Square Meters') return value * 10000;
        if (toUnit == 'Square Feet') return value * 107639;
        if (toUnit == 'Square Kilometers') return value / 100;
        if (toUnit == 'Acres') return value * 2.47105;
        return value;
      case 'Acres':
        if (toUnit == 'Square Meters') return value * 4046.86;
        if (toUnit == 'Square Feet') return value * 43560;
        if (toUnit == 'Square Kilometers') return value / 247.105;
        if (toUnit == 'Hectares') return value / 2.47105;
        return value;
      default:
        return value;
    }
  }

  double _convertVolume(double value, String fromUnit, String toUnit) {
    switch (fromUnit) {
      case 'Cubic Meters':
        if (toUnit == 'Cubic Feet') return value * 35.3147;
        if (toUnit == 'Liters') return value * 1000;
        if (toUnit == 'Gallons (US)') return value * 264.172;
        if (toUnit == 'Milliliters') return value * 1000000;
        return value;
      case 'Cubic Feet':
        if (toUnit == 'Cubic Meters') return value / 35.3147;
        if (toUnit == 'Liters') return value * 28.3168;
        if (toUnit == 'Gallons (US)') return value * 7.48052;
        if (toUnit == 'Milliliters') return value * 28316.8;
        return value;
      case 'Liters':
        if (toUnit == 'Cubic Meters') return value / 1000;
        if (toUnit == 'Cubic Feet') return value / 28.3168;
        if (toUnit == 'Gallons (US)') return value / 3.78541;
        if (toUnit == 'Milliliters') return value * 1000;
        return value;
      case 'Gallons (US)':
        if (toUnit == 'Cubic Meters') return value / 264.172;
        if (toUnit == 'Cubic Feet') return value / 7.48052;
        if (toUnit == 'Liters') return value * 3.78541;
        if (toUnit == 'Milliliters') return value * 3785.41;
        return value;
      case 'Milliliters':
        if (toUnit == 'Cubic Meters') return value / 1000000;
        if (toUnit == 'Cubic Feet') return value / 28316.8;
        if (toUnit == 'Liters') return value / 1000;
        if (toUnit == 'Gallons (US)') return value / 3785.41;
        return value;
      default:
        return value;
    }
  }

  double _convertSpeed(double value, String fromUnit, String toUnit) {
    switch (fromUnit) {
      case 'Meters per second':
        if (toUnit == 'Kilometers per hour') return value * 3.6;
        if (toUnit == 'Miles per hour') return value * 2.23694;
        if (toUnit == 'Knots') return value * 1.94384;
        return value;
      case 'Kilometers per hour':
        if (toUnit == 'Meters per second') return value / 3.6;
        if (toUnit == 'Miles per hour') return value / 1.60934;
        if (toUnit == 'Knots') return value / 1.852;
        return value;
      case 'Miles per hour':
        if (toUnit == 'Meters per second') return value / 2.23694;
        if (toUnit == 'Kilometers per hour') return value * 1.60934;
        if (toUnit == 'Knots') return value / 1.15078;
        return value;
      case 'Knots':
        if (toUnit == 'Meters per second') return value / 1.94384;
        if (toUnit == 'Kilometers per hour') return value * 1.852;
        if (toUnit == 'Miles per hour') return value * 1.15078;
        return value;
      default:
        return value;
    }
  }

  double _convertData(double value, String fromUnit, String toUnit) {
    const Map<String, int> sizes = {
      'Bytes': 1,
      'Kilobytes': 1024,
      'Megabytes': 1024 * 1024,
      'Gigabytes': 1024 * 1024 * 1024,
      'Terabytes': 1024 * 1024 * 1024 * 1024,
    };
    return value * sizes[fromUnit]! / sizes[toUnit]!;
  }

  double _convertEnergy(double value, String fromUnit, String toUnit) {
    switch (fromUnit) {
      case 'Joules':
        if (toUnit == 'Kilojoules') return value / 1000;
        if (toUnit == 'Calories') return value / 4.184;
        if (toUnit == 'Kilocalories') return value / 4184;
        return value;
      case 'Kilojoules':
        if (toUnit == 'Joules') return value * 1000;
        if (toUnit == 'Calories') return value * 239.006;
        if (toUnit == 'Kilocalories') return value / 4.184;
        return value;
      case 'Calories':
        if (toUnit == 'Joules') return value * 4.184;
        if (toUnit == 'Kilojoules') return value / 239.006;
        if (toUnit == 'Kilocalories') return value / 1000;
        return value;
      case 'Kilocalories':
        if (toUnit == 'Joules') return value * 4184;
        if (toUnit == 'Kilojoules') return value * 4.184;
        if (toUnit == 'Calories') return value * 1000;
        return value;
      default:
        return value;
    }
  }

  double _convertPressure(double value, String fromUnit, String toUnit) {
    switch (fromUnit) {
      case 'Pascals':
        if (toUnit == 'Kilopascals') return value / 1000;
        if (toUnit == 'Atmospheres') return value / 101325;
        if (toUnit == 'Bar') return value / 100000;
        if (toUnit == 'PSI') return value / 6894.76;
        return value;
      case 'Kilopascals':
        if (toUnit == 'Pascals') return value * 1000;
        if (toUnit == 'Atmospheres') return value / 101.325;
        if (toUnit == 'Bar') return value / 100;
        if (toUnit == 'PSI') return value / 6.89476;
        return value;
      case 'Atmospheres':
        if (toUnit == 'Pascals') return value * 101325;
        if (toUnit == 'Kilopascals') return value * 101.325;
        if (toUnit == 'Bar') return value * 1.01325;
        if (toUnit == 'PSI') return value * 14.6959;
        return value;
      case 'Bar':
        if (toUnit == 'Pascals') return value * 100000;
        if (toUnit == 'Kilopascals') return value * 100;
        if (toUnit == 'Atmospheres') return value / 1.01325;
        if (toUnit == 'PSI') return value * 14.5038;
        return value;
      case 'PSI':
        if (toUnit == 'Pascals') return value * 6894.76;
        if (toUnit == 'Kilopascals') return value * 6.89476;
        if (toUnit == 'Atmospheres') return value / 14.6959;
        if (toUnit == 'Bar') return value / 14.5038;
        return value;
      default:
        return value;
    }
  }
}

// Currency Converter Page
class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final _inputController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  String _result = '';
  bool _isLoading = false;
  String? _errorMessage;

  final List<String> _currencies = const ['USD', 'EUR', 'GBP', 'JPY', 'AUD', 'CAD','MAD', 'CNY', 'INR', 'KRW'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Amount',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _fromCurrency,
                    decoration: const InputDecoration(labelText: 'From'),
                    items: _currencies.map((String currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(currency),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _fromCurrency = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.swap_horiz),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _toCurrency,
                    decoration: const InputDecoration(labelText: 'To'),
                    items: _currencies.map((String currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(currency),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _toCurrency = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _convertCurrency,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              )
            else if (_result.isNotEmpty)
              Text(_result, style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }

  Future<void> _convertCurrency() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _result = '';
    });
    final amount = double.tryParse(_inputController.text);
    if (amount == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Invalid Input';
      });
      return;
    }

    const apiKey = 'e3180ac0748274241ee465b8';
    final url = Uri.parse('https://api.exchangerate-api.com/v4/latest/$_fromCurrency');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rate = data['rates'][_toCurrency];
        if (rate != null) {
          final result = amount * rate;
          setState(() {
            _result = '$result $_toCurrency';
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = 'Could not find rate for $_toCurrency';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Failed to fetch data';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Something went Wrong: $e';
        _isLoading = false;
      });
    }
  }
}

//expression parser
class ExpressionParser {
  int _index = 0;
  String _expression = "";

  double eval(String expression) {
    _expression = expression.replaceAll(' ', '');
    _index = 0;
    return _parseExpression();
  }

  double _parseExpression() {
    double result = _parseTerm();
    while (_index < _expression.length) {
      if (_expression[_index] == '+') {
        _index++;
        result += _parseTerm();
      } else if (_expression[_index] == '-') {
        _index++;
        result -= _parseTerm();
      } else {
        break;
      }
    }
    return result;
  }

  double _parseTerm() {
    double result = _parseFactor();
    while (_index < _expression.length) {
      if (_expression[_index] == '*') {
        _index++;
        result *= _parseFactor();
      } else if (_expression[_index] == '/') {
        _index++;
        result /= _parseFactor();
      } else {
        break;
      }
    }
    return result;
  }

  double _parseFactor() {
    if (_index >= _expression.length) throw Exception('Unexpected end of expression');

    if (_expression[_index] == '(') {
      _index++;
      double result = _parseExpression();
      if (_index >= _expression.length || _expression[_index] != ')') {
        throw Exception('Mismatched parentheses');
      }
      _index++;
      return result;
    } else if (_expression[_index] == '-') {
      _index++;
      return -_parseFactor(); // Apply negation to the factor
    } else if (_expression[_index] == 's') {
      if (_expression.startsWith('sin', _index)) {
        _index += 3;
        return math.sin(_parseFactor());
      }
    } else if (_expression[_index] == 'c') {
      if (_expression.startsWith('cos', _index)) {
        _index += 3;
        return math.cos(_parseFactor());
      }
    } else if (_expression[_index] == 't') {
      if (_expression.startsWith('tan', _index)) {
        _index += 3;
        return math.tan(_parseFactor());
      }
    } else if (_expression[_index] == 'l') {
      if (_expression.startsWith('log', _index)) {
        _index += 3;
        return math.log(_parseFactor()) / math.log(10);
      } else if (_expression.startsWith('ln', _index)) {
        _index += 2;
        return math.log(_parseFactor());
      }
    } else if (_expression.startsWith('sqrt', _index)) {
    _index += 4; // Skip the 'sqrt' part
    double operand = _parseFactor(); // Parse the operand for the square root
    return math.sqrt(operand);   // Apply square root to the factor
    } else if (_expression[_index] == 'p') {
      if (_expression.startsWith('pi', _index)) {
        _index += 2;
        return math.pi;
      }
    } else if (_expression[_index] == 'e') {
      _index++;
      return math.e;
    }
    return _parsePower();
  }

  double _parsePower() {
    double result = _parseNumber();
    if (_index < _expression.length && _expression[_index] == '*') {
      _index++;
      if (_index < _expression.length && _expression[_index] == '*') {
        _index++;
        result = math.pow(result, _parsePower()).toDouble();
      } else {
        _index--;
      }
    }
    return result;
  }

  double _parseNumber() {
    String number = "";
    while (_index < _expression.length &&
        (_isDigit(_expression[_index]) || _expression[_index] == '.')) {
      number += _expression[_index];
      _index++;
    }
    if (number.isEmpty) {
      if (_index < _expression.length) {
        throw Exception('Invalid character');
      } else {
        throw Exception('Number expected');
      }
    }
    return double.parse(number);
  }

  bool _isDigit(String char) {
    return char.codeUnitAt(0) >= '0'.codeUnitAt(0) &&
        char.codeUnitAt(0) <= '9'.codeUnitAt(0);
  }
}

// Equation Solver Page
class EquationSolverPage extends StatefulWidget {
  const EquationSolverPage({super.key});

  @override
  State<EquationSolverPage> createState() => _EquationSolverPageState();
}

class _EquationSolverPageState extends State<EquationSolverPage> {
  final _equationController = TextEditingController();
  String _solution = '';
  List<FlSpot> _graphData = [];
  bool _showGraph = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equation Solver'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _equationController,
                decoration: const InputDecoration(
                  labelText: 'Enter Equation (e.g., y = 2x + 3 or 2x+3=7)',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _solveEquation,
                child: const Text('Solve'),
              ),
              const SizedBox(height: 20),
              if (_solution.isNotEmpty)
                Text(
                  'Solution: $_solution',
                  style: const TextStyle(fontSize: 18),
                ),
              const SizedBox(height: 20),
              if (_showGraph)
                SizedBox(
                  height: 300,
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: true),
                      titlesData: const FlTitlesData(
                        leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true)),
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true)),
                      ),
                      borderData: FlBorderData(show: true),
                      lineBarsData: [
                        LineChartBarData(
                          spots: _graphData,
                          isCurved: true,
                          color: Colors.blue,
                          barWidth: 3,
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _solveEquation() {
    String equation = _equationController.text;
    setState(() {
      _solution = '';
      _graphData = [];
      _showGraph = false;
    });

    if (equation.contains('y=')) {
      try {
        _graphEquation(equation);
      } catch (e) {
        setState(() {
          _solution = "Invalid Equation For Graph Drawing: $e";
        });
      }
      return;
    }

    try {
      final result = solve(equation);
      setState(() {
        _solution = result;
      });
    } catch (e) {
      setState(() {
        _solution = 'Error : $e';
      });
    }
  }

  void _graphEquation(String equation) {
    String expression = equation.substring(equation.indexOf('=') + 1).trim();
    final parser = ExpressionParser();
    _graphData = [];

    for (double x = -10; x <= 10; x += 0.5) {
      try {
        final y = parser.eval(expression.replaceAll('x', '($x)'));
        _graphData.add(FlSpot(x, y));
      } catch (e) {
        setState(() {
          _solution = 'Error : $e';
        });
        return;
      }
    }
    setState(() {
      _showGraph = true;
    });
  }

  String solve(String equation) {
    equation = equation.replaceAll(' ', '');
    if (!equation.contains('=')) {
      throw Exception("Invalid Equation: Must contain '=' sign");
    }

    final parts = equation.split('=');
    if (parts.length != 2) {
      throw Exception("Invalid Equation: Only one '=' sign is allowed");
    }

    final left = parts[0];
    final right = parts[1];

    double rightValue;

    try {
      final parser = ExpressionParser();
      rightValue = parser.eval(right);
    } catch (e) {
      throw Exception("Invalid Right Hand Side expression");
    }

    if (!left.contains('x')) {
      throw Exception(
          "Invalid Left Hand Side Expression: Must contains variable 'x'");
    }

    final xCoeff = _extractCoefficient(left);
    if (xCoeff == null) {
      throw Exception(
          "Invalid Left Hand Side expression: Invalid Coefficient of x");
    }

    final constant = _extractConstant(left);

    final solution = (rightValue - constant) / xCoeff;

    return "x = $solution";
  }

  double? _extractCoefficient(String expression) {
    expression = expression.replaceAll('-', '+-');
    if (expression.startsWith('+')) {
      expression = expression.substring(1);
    }
    final parts = expression.split('+');

    for (final part in parts) {
      if (part.contains('x')) {
        final coeffString = part.replaceAll('x', '');
        if (coeffString.isEmpty) {
          return 1;
        }
        if (coeffString == '-') {
          return -1;
        }
        return double.tryParse(coeffString);
      }
    }
    return null;
  }

  double _extractConstant(String expression) {
    expression = expression.replaceAll('-', '+-');
    if (expression.startsWith('+')) {
      expression = expression.substring(1);
    }

    double constantSum = 0;
    final parts = expression.split('+');

    for (final part in parts) {
      if (!part.contains('x')) {
        final parsedValue = double.tryParse(part);
        if (parsedValue != null) {
          constantSum += parsedValue;
        }
      }
    }
    return constantSum;
  }
}

// Matrix Solver Page
class MatrixSolverPage extends StatefulWidget {
  const MatrixSolverPage({super.key});

  @override
  State<MatrixSolverPage> createState() => _MatrixSolverPageState();
}

class _MatrixSolverPageState extends State<MatrixSolverPage> {
  int _rowsA = 2;
  int _colsA = 2;
  int _rowsB = 2;
  int _colsB = 2;
  List<List<TextEditingController>> _matrixAControllers = [];
  List<List<TextEditingController>> _matrixBControllers = [];
  String _result = '';

  @override
  void initState() {
    super.initState();
    _initializeMatrixControllers();
  }

  void _initializeMatrixControllers() {
    _matrixAControllers = List.generate(_rowsA, (_) => List.generate(_colsA, (_) => TextEditingController()));
    _matrixBControllers = List.generate(_rowsB, (_) => List.generate(_colsB, (_) => TextEditingController()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matrix Solver'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Matrix A', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Rows'),
                  onChanged: (val) => _rowsA = int.tryParse(val) ?? _rowsA,
                )),
                const SizedBox(width: 10),
                Expanded(child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Cols'),
                  onChanged: (val) => _colsA = int.tryParse(val) ?? _colsA,
                )),
                ElevatedButton(onPressed: _updateMatrixA, child: const Text('Update')),
              ],
            ),
            _buildMatrixInput(_rowsA, _colsA, _matrixAControllers),
            const SizedBox(height: 20),
            const Text('Matrix B', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Rows'),
                  onChanged: (val) => _rowsB = int.tryParse(val) ?? _rowsB,
                )),
                const SizedBox(width: 10),
                Expanded(child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Cols'),
                  onChanged: (val) => _colsB = int.tryParse(val) ?? _colsB,
                )),
                ElevatedButton(onPressed: _updateMatrixB, child: const Text('Update')),
              ],
            ),
            _buildMatrixInput(_rowsB, _colsB, _matrixBControllers),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _addMatrices, child: const Text('Add')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _subtractMatrices, child: const Text('Subtract')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _multiplyMatrices, child: const Text('Multiply')),
            const SizedBox(height: 20),
            Text('Result: $_result', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  void _updateMatrixA() {
    setState(() {
      _initializeMatrixControllers();
    });
  }

  void _updateMatrixB() {
    setState(() {
      _initializeMatrixControllers();
    });
  }

  Widget _buildMatrixInput(int rows, int cols, List<List<TextEditingController>> controllers) {
    return Column(
      children: List.generate(rows, (i) => Row(
        children: List.generate(cols, (j) => Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
              controller: controllers[i][j],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: const OutlineInputBorder()),
            ),
          ),
        )),
      )),
    );
  }

  List<List<double>> _getMatrixValues(List<List<TextEditingController>> controllers, int rows, int cols) {
    return List.generate(rows, (i) => List.generate(cols, (j) {
      return double.tryParse(controllers[i][j].text) ?? 0.0;
    }));
  }

  void _addMatrices() {
    if (_colsA != _colsB || _rowsA != _rowsB) {
      setState(() => _result = 'Matrices must have the same dimensions for addition.');
      return;
    }
    final matrixA = _getMatrixValues(_matrixAControllers, _rowsA, _colsA);
    final matrixB = _getMatrixValues(_matrixBControllers, _rowsB, _colsB);
    final resultMatrix = MatrixSolver.add(matrixA, matrixB);
    setState(() => _result = MatrixSolver.formatMatrix(resultMatrix));
  }

  void _subtractMatrices() {
    if (_colsA != _colsB || _rowsA != _rowsB) {
      setState(() => _result = 'Matrices must have the same dimensions for subtraction.');
      return;
    }
    final matrixA = _getMatrixValues(_matrixAControllers, _rowsA, _colsA);
    final matrixB = _getMatrixValues(_matrixBControllers, _rowsB, _colsB);
    final resultMatrix = MatrixSolver.subtract(matrixA, matrixB);
    setState(() => _result = MatrixSolver.formatMatrix(resultMatrix));
  }

  void _multiplyMatrices() {
    if (_colsA != _rowsB) {
      setState(() => _result = 'Number of columns in Matrix A must equal number of rows in Matrix B for multiplication.');
      return;
    }
    final matrixA = _getMatrixValues(_matrixAControllers, _rowsA, _colsA);
    final matrixB = _getMatrixValues(_matrixBControllers, _rowsB, _colsB);
    final resultMatrix = MatrixSolver.multiply(matrixA, matrixB);
    setState(() => _result = MatrixSolver.formatMatrix(resultMatrix));
  }
}

class MatrixSolver {
  static List<List<double>> add(List<List<double>> a, List<List<double>> b) {
    return List.generate(a.length, (i) => List.generate(a[0].length, (j) => a[i][j] + b[i][j]));
  }

  static List<List<double>> subtract(List<List<double>> a, List<List<double>> b) {
    return List.generate(a.length, (i) => List.generate(a[0].length, (j) => a[i][j] - b[i][j]));
  }

  static List<List<double>> multiply(List<List<double>> a, List<List<double>> b) {
    int m = a.length;
    int n = b[0].length;
    int p = b.length;
    List<List<double>> result = List.generate(m, (_) => List.filled(n, 0.0));
    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        for (int k = 0; k < p; k++) {
          result[i][j] += a[i][k] * b[k][j];
        }
      }
    }
    return result;
  }

  static String formatMatrix(List<List<double>> matrix) {
    return matrix.map((row) => row.map((e) => e.toStringAsFixed(2)).join('\t')).join('\n');
  }
}