# Swiperia

Swiperia is an iOS game built around swipe gestures: an arrow appears on an
orb and you have to swipe in its direction before the time runs out. Play
alone or against friends nearby. Multiplayer runs over Bluetooth or local
Wi-Fi (Apple Multipeer Connectivity), no internet needed. In multiplayer you
generate and fire items at your opponent: an earthquake shakes the arrows, a
blizzard blocks the view, the screen turns upside down, the swipe direction is
reversed, or the time per swipe is halved.

<p align="center">
  <img src="docs/multiplayer.gif" alt="Two phones playing Giant Wars against each other" width="560">
</p>

## Screenshots

| Game | Combo | Mistake | Item ready |
|:-:|:-:|:-:|:-:|
| <img src="docs/game.png" alt="Game view" width="180"> | <img src="docs/screens/game-combo.png" alt="High combo" width="180"> | <img src="docs/screens/game-mistake.png" alt="Wrong swipe" width="180"> | <img src="docs/screens/game-item.png" alt="Item ready to fire" width="180"> |

| Game selection | Game browser | Create lobby | Lobby |
|:-:|:-:|:-:|:-:|
| <img src="docs/screens/game-selection.png" alt="Single player game carousel" width="180"> | <img src="docs/screens/game-browser.png" alt="Searching for Giant Wars lobbies" width="180"> | <img src="docs/screens/create-lobby.png" alt="Lobby creator" width="180"> | <img src="docs/screens/lobby.png" alt="Lobby with players" width="180"> |

| Profile | Settings | Item list |
|:-:|:-:|:-:|
| <img src="docs/screens/profile.png" alt="Profile with scores per opponent" width="180"> | <img src="docs/screens/settings.png" alt="Settings" width="180"> | <img src="docs/screens/item-list.png" alt="List of items" width="180"> |

## How to play

An orb shows an arrow. Swipe in its direction, then the next arrow appears.

- **Time bar:** every game starts with a 10-second time bar that is refilled
  after each swipe. A wrong or missed swipe takes one second off the bar for
  the rest of the game. When the bar runs out, the game is over.
- **Combos:** correct swipes in a row raise the combo level (the first level
  after 5 swipes, each further level needs 1.5 times as many). The score
  multiplier rises with each level, up to ×2.3. From level 2 on, every new
  level gives one second back.
- **Items:** correct swipes charge the orb. When it is full (20 swipes in
  single player, 15 in multiplayer) you get a random item and activate it with
  a tap. Every item lasts 10 seconds.
- **Giant Wars (multiplayer):** your opponent appears as a giant whose health
  bar is their remaining time. Every mistake costs you time, every combo gives
  some back, and items you fire hit your opponent. Whoever runs out of time
  first loses; wins and losses per opponent are saved in the profile.

## Items

| | Item | Mode | Effect (10 seconds) |
|---|---|---|---|
| <img src="docs/items/sameDirection.png" alt="" width="40"> | Same direction | Single player | The swipe direction is frozen, you only need to swipe one way |
| <img src="docs/items/freezeTime.png" alt="" width="40"> | Freeze time | Single player | The time bar stops (wrong swipes still cost time) |
| <img src="docs/items/reverseDirection.png" alt="" width="40"> | Reverse direction | Multiplayer | The opponent has to swipe against the arrow |
| <img src="docs/items/halfArrowTime.png" alt="" width="40"> | Half arrow time | Multiplayer | The opponent has less time per swipe |
| <img src="docs/items/earthquake.png" alt="" width="40"> | Earthquake | Multiplayer | The opponent's arrows shake and the time bar disappears |
| <img src="docs/items/blizzard.png" alt="" width="40"> | Blizzard | Multiplayer | Snow covers the opponent's screen |
| <img src="docs/items/turnAround.png" alt="" width="40"> | Turn around | Multiplayer | The opponent's game is turned upside down |

## Context

Student project in the elective module *Fullstack iOS Entwicklung mit Swift*
(Medieninformatik Master, TH Köln, summer term 2017), supervised by
Alexander Dobrynin. Developed by Dennis Dubbert and Edgar Gellert. The game was
presented with this [poster](docs/poster.jpg).

The code was originally written in the `swiperia/` folder of the course
repository. That history (May to October 2017) is preserved in this repo.

## Features

- Single player: *Beat the Machine*, swipe against the clock
- Multiplayer: *Giant Wars* over Multipeer Connectivity, with lobbies,
  password protection and pause/resume (a second mode, *Sequence Breaker*,
  was planned but not finished)
- Item system with seven items, each with its own visual effect
- Profile with generated avatar (colour picker) and saved single and
  multiplayer results
- Settings for music, sounds, vibration and the colours of the swipe feedback

## Architecture

A single Xcode project (UIKit, storyboards), roughly split into views,
controllers and models/managers:

```mermaid
flowchart TB
  subgraph Navigation
    Tab[CustomTabBarController] --> SP[Single player<br>GameSelectionController + iCarousel]
    Tab --> MP[Multiplayer<br>GameSelectionController + iCarousel]
    Tab --> Prof[ProfileController]
    Tab --> Set[SettingsController<br>ChromaColorPicker] --> ItemsV[ItemViewController]
  end
  subgraph Game
    GVC[GameViewController] --> BTM[BeatTheMachineController]
    GVC --> GW[GiantWarsController]
    GVC --> Scene[GameScene · SceneKit<br>SphereNode, particles]
    GVC --> Overlay[OverlayScene · SpriteKit<br>ItemPanel, progress, health bar]
    GVC --> Mgr[DirectionManager · TimeManager<br>GameScoreManager · ItemManager · MusicPlayer]
  end
  subgraph Multiplayer
    Browser[MultipeerBrowserViewController] --> Lobby[MultipeerLobbyViewController]
    Create[CreateLobbyViewController] --> Lobby
    Lobby --> MPC[MPCManager<br>MCSession, advertiser, browser]
    MPC --> Msg[MessageManager<br>items, time, start/pause/lost]
  end
  SP --> BTM
  MP --> Browser
  MP --> Create
  Lobby --> GW
  GW <--> Msg
  Prof --> Store[(UserDefaults<br>profile, results, settings)]
  BTM --> Store
  GW --> Store
```

- **Game loop:** `GameViewController` holds the shared logic (swipe handling,
  timers, combo and item charge); the two game modes subclass it. The orb is a
  SceneKit scene, the HUD (item panel, progress, opponent health bar) a
  SpriteKit overlay on top.
- **Multiplayer:** each game mode advertises its own Multipeer service type;
  lobbies can require a password. `MessageManager` encodes typed messages
  (item fired, time changed, start, pause, resume, lost, kicked, avatar image)
  and forwards them to the running game via a delegate.
- **Persistence:** a `UserDefaults` extension stores the profile (generated
  avatar via `ProfileImageMaker`), single and multiplayer results and settings.

## Tech

Swift 3, UIKit with storyboards, SpriteKit and SceneKit particle effects,
Multipeer Connectivity, UserDefaults for persistence. Dependencies:
[iCarousel](https://github.com/nicklockwood/iCarousel) (vendored) and
[ChromaColorPicker](https://github.com/joncardasis/ChromaColorPicker) (CocoaPods).

## Building

Open `Swiperia/Swiperia.xcworkspace` in Xcode, select your own development
team under *Signing* and run on a device (multiplayer needs two devices).
The project dates from 2017 and has not been updated for current Xcode and
Swift versions.

## Status

Finished student project, not maintained. The original GitHub wiki was lost
when the course repository was deleted; the sections above were rebuilt from
the code and the project documentation.

## Licence

Code: [MIT](LICENSE). The background music (`Bass17w20.mp3`) and the 3D model
(`golem-radial/golem.obj`) were taken from free-to-use sources at the time and
are not covered by the MIT licence.
