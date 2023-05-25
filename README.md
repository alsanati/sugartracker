# Getting Started with Flutter App

This guide will walk you through the process of setting up and running a Flutter app from a GitHub repository. Flutter is an open-source UI toolkit developed by Google for building natively compiled applications for mobile, web, and desktop from a single codebase.

## Prerequisites

Before you begin, make sure you have the following installed on your system:

1. Flutter SDK: Follow the official Flutter installation guide ([Flutter Install](https://flutter.dev/docs/get-started/install)) to set up Flutter on your machine.

2. Git: Install Git if it is not already installed. You can download Git from the official website ([Git](https://git-scm.com/downloads)).

## Steps

1. Clone the repository: Open your terminal or command prompt and navigate to the directory where you want to store the project. Run the following command to clone the repository:

   ```bash
   git clone https://github.com/alsanati/sugartracker.git
   ```

   Replace `username` with the GitHub username and `repository` with the name of the repository you want to clone.

2. Change to the project directory: Once the repository is cloned, navigate into the project directory using the following command:

   ```bash
   cd sugartracker
   ```


3. Install dependencies: Run the following command to fetch and install the project dependencies using Flutter's package manager, `flutter pub`:

   ```bash
   flutter pub get
   ```

4. Run the app: Connect your mobile device or start an emulator, then use the following command to launch the app:

   ```bash
   flutter run
   ```

   Flutter will compile the code and deploy the app to your connected device or emulator.

