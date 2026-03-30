# Image Encryption Vault Application using Flutter

**Secure Image Encryption & Decryption Using AES**  
_Miniproject – Semester V–VI_BACHELORS in COMPUTER ENGINEERING MUMBAI UNIVERSITY

Nitro_img_AES is an image encryption and decryption application that uses the **Advanced Encryption Standard (AES)** algorithm to secure image files. The project demonstrates the practical implementation of symmetric cryptography for protecting visual data.

This application allows users to encrypt image files into unreadable formats and decrypt them back to their original form using a secure key.

---

## 📌 Table of Contents

- [About](#about)
- [Features](#features)
- [How It Works](#how-it-works)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Future Improvements](#future-improvements)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

---

## 🚀 About

Nitro_img_AES was developed as a semester mini-project to explore and implement modern cryptographic techniques in real-world applications.

The application uses the AES symmetric encryption algorithm to:
- Secure image files
- Prevent unauthorized access
- Demonstrate encryption/decryption workflows
- Provide a simple UI for cryptographic operations

AES is widely adopted in industry for secure data protection due to its strength, speed, and reliability.

---

## 💡 Features

- 🔐 AES-based image encryption
- 🔓 Secure image decryption with correct key
- 📁 Supports common image formats (PNG, JPG, JPEG)
- 📱 Mobile-friendly implementation (Flutter-based)
- 🧠 Demonstrates real-world cryptographic concepts
- 💾 Local file handling and processing

---

## 🧠 How It Works

1. **Image Selection**  
   The user selects an image file from local storage.

2. **Key Input**  
   The user enters a secret encryption key.

3. **Encryption Process**  
   - The image is converted into byte data.
   - AES encryption is applied.
   - The encrypted file is stored locally.

4. **Decryption Process**  
   - The encrypted image is selected.
   - The same key is provided.
   - AES decryption restores the original image.

> Note: Since AES is a symmetric algorithm, the same key must be used for both encryption and decryption.

---

## 🛠️ Technologies Used

| Component | Technology |
|-----------|------------|
| UI Framework | Flutter |
| Programming Language | Dart |
| Android Integration | Java |
| Encryption | AES (Advanced Encryption Standard) |
| File Handling | Native APIs / Flutter Plugins |

---

## 📦 Installation

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/D-G-X/Nitro_img_AES.git
cd Nitro_img_AES
