# ScanQRCode 📱

## Overview 📚
ScanQRCode is an iOS application that enables users to scan QR codes efficiently using the device's camera. The app includes a countdown timer after each scan, providing a 5-second delay before the scan session restarts. This delay is visually represented with a countdown label in a large, bold black font, ensuring a smooth and user-friendly scanning experience.

## Features ✨

- **QR Code Scanning**: Use the device's camera to scan QR codes, providing instant feedback and dismissing once a code is found.
- **Countdown Timer**: After each scan, a 5-second countdown timer displays in the center of the screen before restarting the scanning session. The countdown label is styled with a large, bold black font for visibility.
- **Customizable Scan Area**: A rectangular overlay defines the scan area, improving focus and accuracy.
- **Intuitive UI**: Clear visual feedback is given when scanning begins, pauses, and resumes, enhancing user interaction.

## How It Works 🛠️

1. **Initialize Capture Session**: Set up the camera using `AVCaptureSession` to detect QR codes.
2. **Start Scanning**: Scan once the app opens and shows the camera feed.
3. **Handle QR Code Detection**: When a QR code is detected, the session stops, and the code's information is displayed.
4. **Countdown Delay**: After dismissing the scan result, a 5-second countdown timer appears, delaying the scan restart.
5. **Restart Scanning**: Once the countdown reaches zero, the session restarts on a background thread to avoid UI lag.

## Setup & Requirements 📋

- **iOS 14.0+**
- **Xcode 12.0+**
- **Swift 5.0+**

## Usage 🚀

1. Clone the repository:
    ```bash
    git clone https://github.com/lymanny/iOS-ScanQRCode.git
    ```
2. Open the project in Xcode.
3. Run the app on an iOS simulator or device with a camera to start scanning QR codes.

## Screenshots 📸

<img src="https://github.com/user-attachments/assets/3d7ed4ab-82cc-41bf-b44e-e69ad328aaf2" alt="QR Code Scan Interface" width="400"/>

## Contributing 🤝
Contributions are welcome! Please feel free to submit issues, fork the repository, and create pull requests.

## License 📄
This project is licensed under the [MIT License](LICENSE).

## Author 👩‍💻
lymanny - iOS Developer  
🌐 [Portfolio](https://lymanny.onrender.com)
