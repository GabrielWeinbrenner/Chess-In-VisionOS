# Chess App

This repository contains the source code for a Chess application developed in Swift using SwiftUI. The application features a fully functional chess board, complete with player management, move validation, and game state tracking.

## Features

- Full implementation of a chess game with standard rules.
- Supports two players, with each player controlling either the black or white pieces.
- Each chess piece (pawn, knight, bishop, rook, queen, king) is implemented with its unique movement and behavior.
- The board state is managed and updated dynamically as moves are made.
- Game state is tracked, including move history and check/checkmate detection.
- Serialization and deserialization of the game state for saving and loading games.

## Technologies Used

- **Swift**: The primary programming language used for development.
- **SwiftUI**: Used for building the user interface.
- **Foundation**: Provides essential data types, collections, and operating-system services.
- **UniformTypeIdentifiers**: Manages uniform type identifiers for handling data types.

## File Descriptions

### `BoardModel.swift`

This file contains the `BoardModel` class, which is the main model representing the chessboard. It handles the initialization of the board, movement of pieces, and game state tracking.

### `SquareModel.swift`

This file defines the `SquareModel` class, representing individual squares on the chessboard. It includes properties for the square's position, color, and the chess piece it contains.

### `SelectionModel.swift`

This file contains the `SelectionModel` class, which manages the selection of squares and pieces during the game. It ensures valid moves are highlighted and processed correctly.

### `ChessModel.swift`

This file includes the `ChessModel` class, which manages multiple `BoardModel` instances and allows for switching between different boards.

### `BoardMove.swift`

This file defines the `BoardMove` struct, which represents a move made on the board. It includes the starting and ending squares of the move and the player who made the move.

## Installation

To run this project, you will need Xcode installed on your macOS system. Follow these steps to get started:

1. Clone the repository:
 ```bash
 git clone https://github.com/yourusername/ChessApp.git
 ```
2. Open the project in Xcode:
```bash
cd ChessApp
open ChessApp.xcodeproj
```

3. Build and run the project in the Xcode simulator or on a connected device.


## Usage
Once the application is running, you can start a new game of chess by following the standard chess rules. The application supports move validation, turn-based play, and game state tracking.

## Screenshots




## Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

For any questions or inquiries, please contact Gabriel Weinbrenner at gabriel.weinbrenner@gmail.com.
