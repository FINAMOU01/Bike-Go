
}

class BikeGoApp extends StatelessWidget {
  const BikeGoApp({super.key});

  Future<bool> _shouldShowOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool('onboarding_complete') ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(

      ),
    );
  }
}
