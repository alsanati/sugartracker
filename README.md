# Getting Started with Sugartracker

This guide will walk you through the process of setting up and running a Flutter app from a GitHub repository. The app utilizes Supabase, an open-source Firebase alternative, as its backend. Before you begin, you will need to obtain the Supabase URL and anonymous key to connect the app to the backend.

## Prerequisites

Before you start, make sure you have the following installed on your system:

1. Flutter SDK: Follow the official Flutter installation guide ([Flutter Install](https://flutter.dev/docs/get-started/install)) to set up Flutter on your machine.

2. Git: Install Git if it is not already installed. You can download Git from the official website ([Git](https://git-scm.com/downloads)).

3. Supabase Account: Sign up for a Supabase account at [Supabase](https://supabase.io) and create a new project. Once the project is created, you will obtain the Supabase URL and anonymous key.

## Steps

1. Clone the repository: Open your terminal or command prompt and navigate to the directory where you want to store the project. Run the following command to clone the repository:

   ```bash
   git clone https://github.com/alsanati/sugartracker.git
   ```

2. Change to the project directory: Once the repository is cloned, navigate into the project directory using the following command:

   ```bash
   cd repository
   ```

   Replace `repository` with the actual repository directory name.

3. Add Supabase credentials: Open the project in your preferred text editor. Locate the `lib/constants.dart` file and update the `SUPABASE_URL` and `SUPABASE_ANON_KEY` constants with your Supabase URL and anonymous key obtained from your Supabase project.

   ```dart
   const SUPABASE_URL = 'https://your-supabase-url.supabase.co';
   const SUPABASE_ANON_KEY = 'your-supabase-anonymous-key';
   ```

   Save the file after making the necessary changes.

4. Install dependencies: Run the following command to fetch and install the project dependencies using Flutter's package manager, `flutter pub`:

   ```bash
   flutter pub get
   ```
   
 6. Configure launch settings (VSCode): If you are using Visual Studio Code as your preferred IDE, you may need to update the launch settings to include the Supabase credentials. Follow these steps:

   - Open the project in Visual Studio Code.
   - Navigate to the debugging section by clicking on the debug icon in the left sidebar.
   - Click on the gear icon to open the "launch.json" file for editing.
   - Inside the "configurations" array, locate the configuration that corresponds to running the Flutter app (e.g., "Flutter").
   - Update the "args" section of the configuration with the Supabase URL and anonymous key:

     ```json
     "args": [
       "--dart-define=SUPABASE_URL=https://your-supabase-url.supabase.co",
       "--dart-define=SUPABASE_ANON_KEY=your-supabase-anonymous-key"
     ]
     ```

     Replace `https://your-supabase-url.supabase.co` with your Supabase URL and `your-supabase-anonymous-key` with your anonymous key.

   - Save the "launch.json" file.

7. Run the app in debug mode: In Visual Studio Code, select the debug configuration you updated in the previous step from the dropdown menu in the top toolbar. Then, click on the "Start Debugging" button or press `F5` to launch the app with the Supabase credentials.




