# CalTask

## Overview
This project is an iOS application built in Swift. It follows best practices for scalable iOS architecture, using the MVVM design pattern and a variety of modern development techniques.

## Features
- **Data Management**: Uses an in-app data manager to move data between screens, acting similarly to dependency injection.
- **Navigation**: The app employs the Coordinator pattern for managing navigation between views.
- **Programmatic UI**: All UI components are created programmatically, without the use of interface builders.
- **MVVM Architecture**: The Model-View-ViewModel (MVVM) pattern is used to separate concerns and improve maintainability and testability.
- **Reactive Views**: Implements reactive programming using `Combine` to keep the views updated in response to data changes.
- **Scalability**: The project is built with scalability in mind, aiming to support large-scale applications.
- **Unit Testing**: Includes unit tests to ensure functionality and reliability of the app's components.

## Tech Stack
- **Language**: Swift
- **UI**: Programmatic UI, no Interface Builder
- **Architecture**: MVVM
- **Reactive Programming**: Combine
- **Navigation**: Coordinator pattern
- **Dependency Injection**: Custom in-app data manager
- **Testing**: Unit testing using XCTest framework

## Project Structure

- **Models**: Contains the data structures used throughout the app.
- **ViewModels**: Manages the business logic and data presentation for the views.
- **Views**: Contains the UI components, all created programmatically.
- **Coordinators**: Handles screen navigation and flow of the app.
- **DataManager**: Manages the flow of data between different parts of the app.
- **UnitTests**: Includes unit tests for the key components of the app.

## Installation
1. Clone the repository:
    ```bash
    git clone https://github.com/Israelper/CalTask.git
    ```
2. Open the `.xcodeproj` file in Xcode.
3. Run the app on the simulator or a physical device.


## License
This project is licensed under the MIT License.
