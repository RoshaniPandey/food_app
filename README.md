.

🍴 Flutter Food Ordering App

A modern food ordering application built with Flutter and BLoC (flutter_bloc) for state management.
It demonstrates a complete workflow including browsing restaurants, viewing menus, managing a cart, applying promo codes, and placing orders.

🚀 Features
📌 Restaurant Listing

Load restaurants from a mock repository

View details such as name, category, rating, and average price

📌 Menu & Popular Items

Browse menu items with images, descriptions, and prices

Highlighted popular items with quick add/remove functionality

📌 Cart Management

Add or remove items dynamically

Quantity updates in real-time

Clear cart option

📌 Promotions

Apply promo codes to avail discounts:

FOODIE10 → 10% off

FREE50 → Flat ₹50 off

📌 Checkout & Orders

Place an order (simulated with delay for realism)

Order success/failure states

📌 State Management with BLoC

Well-structured events and states with flutter_bloc

Immutable updates handled using copyWith

📂 Project Structure
lib/
├── bloc/
│   ├── order_bloc.dart        # Core business logic (restaurants, cart, promo, orders)
│   ├── order_event.dart       # Event definitions
│   └── order_state.dart       # State definitions
│
├── models/
│   ├── restaurant.dart        # Restaurant model
│   └── menu_item.dart         # Menu item model
│
├── repository/
│   └── mock_repository.dart   # Mock data source
│
├── ui/
│   ├── screens/
│   │   ├── home_screen.dart        # Restaurant listing
│   │   ├── restaurant_menu.dart    # Menu view
│   │   ├── cart_screen.dart        # Cart and promotions
│   │   └── checkout_screen.dart    # Checkout flow
│   └── widgets/
│       └── popular_item_card.dart  # Popular item widget
│
└── main.dart                   # Entry point

🛠️ Installation

Clone the repository

git clone https://github.com/RoshaniPandey/food_app
cd food_ordering_app


Install dependencies

flutter pub get


Run the app

flutter run

📸 Screenshots (placeholders)

Home Screen – List of restaurants

Menu Screen – Browse and add/remove items

Cart Screen – Apply promo codes and checkout

🎯 Tech Stack

Flutter – UI framework

Dart – Programming language

flutter_bloc – State management

equatable – Simplified value equality

📌 Future Improvements

🔑 Firebase authentication (login/signup)

🛒 Persistent cart using local storage

🏷️ Dynamic promo codes from backend

📦 Real API integration instead of mock repository

👨‍💻 Author

Developed with ❤️ using Flutter & BLoC.