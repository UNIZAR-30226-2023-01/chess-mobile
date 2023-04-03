[![Production CI](https://github.com/UNIZAR-30226-2023-01/chess-mobile/actions/workflows/badge.svg)](https://github.com/UNIZAR-30226-2023-01/chess-mobile/blob/main/.github/workflows/production.yml)

## Folder structure

- `lib/`: Contains all the code of the applicaction:
    - `main.dart`: Entry point of the app, it setups the general configurations.
    - `components/`: Contains all the specific components which are reused along all the code.
        - `buttons/`: Contains all the custom buttons used in the app
        - `chessLogic/`: Contains the core of the gameplay logic and all the elements that we visualize in game.
        - `communications/`: Contains the core of the API/Socket calls to the backend.
        - `popups/`: Contains all the different popups of the application.
        - `visual/`: Contains all the customizations in visual aspects like the theme colors.
    - `pages/`: Contains all the screens code.
        - `auth_pages`: Contains the login, registry, password recover screens code.
        - `game_pages`: Contains the core gameplay screen code.
        - `menus_pages`: Contains all the intermediate screens between the login and the gameplay.
- `images/`: Logos and chess pieces images.
- `pubspec.yaml`: Dependencies of the application.
- `assets/`: Icons and animations of the application.
- `fonts/`: Fonts of the application.

## How to run

```bash
flutter run
```

## How to build apk

```bash
flutter build apk
```