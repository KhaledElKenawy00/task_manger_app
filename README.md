# 📋 Task Manager App

## Overview

The Task Manager App is a Flutter application designed to help users manage their tasks efficiently. The app features user authentication, task management, pagination, state management, local storage for persistent data, and comprehensive unit tests to ensure functionality.

![Task Manager App](screenshots/app_banner.png)

## ✨ Features

- **User Authentication**: Secure login using the DummyJSON API.
- **Task Management**: View, add, edit, and delete tasks.
- **Pagination**: Efficiently fetch large numbers of tasks.
- **State Management**: Manage state using the Provider package.
- **Local Storage**: Persist tasks locally using SQLite.
- **Unit Tests**: Comprehensive tests for critical functionalities.

## 📸 Screenshots


## 🛠 Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/yourusername/task_manager_app.git
   cd task_manager_app

2.flutter pub get
3.flutter run


📂 Project Structure
lib/
|-- models/
|   |-- task.dart
|-- providers/
|   |-- auth_provider.dart
|   |-- task_provider.dart
|-- screens/
|   |-- login_screen.dart
|   |-- task_list_screen.dart
|   |-- task_detail_screen.dart
|-- services/
|   |-- local_storage_service.dart
|-- main.dart
test/
|-- providers/
|   |-- auth_provider_test.dart
|   |-- task_provider_test.dart

