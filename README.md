# Bike-Go
Bike Go – Eco-Friendly Ride App
Bike Go is a Flutter-based mobile application that allows users to register, log in, view their profiles, and navigate using eco-friendly motorcycle rides. The app supports both cash and mobile money payments via Orange Money and MTN Mobile Money.

Features
🔐 User Registration and Login (with form validation)

👤 User Profile with persistent session using SharedPreferences

🗺️ Interactive Map with route and nearby drivers (Flutter Map)

💬 Messaging and location-based interactions

💵 Payment Info (Cash or Mobile Money)

🌍 Multi-screen Navigation with Navigator

Screens
LandingPage: App welcome screen with navigation

SignupPage: Form with validation (name, email, password, confirm password)

LoginPage: User login

ProfilePage: Displays user info from SharedPreferences

HelpSupportPage: Explains how the app works

PaymentMethodsPage: Describes available payment methods

AboutUsPage: Info about the app and team

MapScreen: Main map view for navigation and ride interaction

📦 Technologies Used
Flutter & Dart

http – For API communication

shared_preferences – Local user session

google_fonts – Custom fonts

flutter_map – Map rendering

latlong2 – Geolocation support

Firebase/Firestore ( for backend)

Getting Started
1. Clone the Repository
git clone https://github.com/yourusername/bike-go.git
cd bike-go
2. Install Dependencies
flutter pub get
Run the App
flutter run

Author
Groupe 24
📍 ICT University, Yaoundé, Cameroon
