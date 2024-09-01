# RepoApp

---

## RepositoriesApp

### Overview

`RepositoriesApp` is an iOS application that allows users to search for GitHub repositories using a search bar. The app fetches repository data from the GitHub API and displays the results in a table view. The app is built using the MVVM architecture pattern, and it utilizes `RxSwift` for reactive programming, making the codebase more maintainable and responsive.

---

### Features

- Search for GitHub repositories using a `UISearchBar`.
- Display repository search results in a `UITableView`.
- Handle errors and provide user feedback through alerts.
- Implement debounce (throttle) to reduce API calls while typing in the search bar.

---

### Technologies Used

- **Swift**: The primary programming language used for iOS app development.
- **UIKit**: Used for building the user interface, including `UIViewController`, `UISearchBar`, and `UITableView`.
- **RxSwift**: A reactive programming framework used to handle asynchronous events, manage state, and bind data between the view and the view model.
- **RxCocoa**: A framework that extends `RxSwift` to work seamlessly with Cocoa components like `UISearchBar` and `UITableView`.
- **MVVM Architecture**: The architecture pattern used to separate concerns between the UI (View), business logic (ViewModel), and data handling (Model).

---

### File Structure

- **`RepoServiceApi.swift`**:
  - This file defines the `RepoServiceApi` class and the `RepoServiceApiProtocol`. It handles the network requests to the GitHub API and returns the parsed data in the form of a `RepoModel`. Error handling is also managed here, with custom errors defined in the `RepoError` enum.

- **`RepoViewModel.swift`**:
  - The `RepoViewModel` class is responsible for interacting with the `RepoServiceApi` to fetch data based on user input. It exposes observable properties (`repoItems` and `errorHandling`) using `RxSwift`'s `BehaviorSubject` to keep track of the repository data and any errors that might occur during the data fetching process.

- **`RepoViewController.swift`**:
  - The `RepoViewController` class is the main view controller of the app. It contains a `UISearchBar` for user input and a `UITableView` to display the search results. It binds the user input and view model data using `RxSwift` and `RxCocoa`, allowing the UI to update reactively based on user actions and fetched data. The view controller also manages the display of alerts for error handling.

---

### Usage

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-repo/RepositoriesApp.git
   ```
   
2. **Open the Project**:
   Open the `RepositoriesApp.xcodeproj` file in Xcode.

3. **Build and Run**:
   - Ensure your development environment is set up with Xcode and the necessary dependencies.
   - Build the project and run it on a simulator or a physical device.

4. **Search for Repositories**:
   - Type a search query into the search bar.
   - The app will fetch and display the GitHub repositories that match your query.

5. **Handle Errors**:
   - If there are any issues with fetching data, the app will display an alert with the error message.

---

### Error Handling

- **`badUrl`**: Indicates that the URL provided for the API request is invalid. The user will see an alert with the message: "The URL provided is invalid. Please check the URL and try again."
- **`badServerResponse`**: This error occurs when the server's response is unexpected (e.g., non-200 status code). The user will be informed via an alert: "The server response was not as expected. Please try again later."
- **`failedFetchData`**: If the app fails to fetch data from the API (e.g., network issues), an alert will display: "Failed to fetch data. Please check your internet connection or try again later."

---

### Dependencies

- **RxSwift**: Ensure you have installed the RxSwift and RxCocoa pods if you’re using CocoaPods. Add the following to your `Podfile`:

  ```ruby
  pod 'RxSwift', '~> 6.0'
  pod 'RxCocoa', '~> 6.0'
  ```

- **Xcode**: Make sure you are using a recent version of Xcode that supports Swift 5.7 or later.

---

### License

This project is licensed under the MIT License - see the LICENSE file for details.

---

### Contact

If you have any questions or need further assistance, feel free to contact Mariam Abdelhamid.

---

This README provides an overview of the app, explains its architecture, and details how to set it up and run it. If you need to add more specific details or instructions, feel free to do so!
