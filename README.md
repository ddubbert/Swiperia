# Swiperia

Swiperia is an iOS game built around swipe gestures: an arrow appears on an
orb and you have to swipe in its direction before the time runs out. Play
alone or against friends nearby. Multiplayer runs over Bluetooth or local
Wi-Fi (Apple Multipeer Connectivity), no internet needed. In multiplayer you
generate and fire items at your opponent: an earthquake shakes the arrows, a
blizzard blocks the view, the screen turns upside down, the swipe direction is
reversed, or the time per swipe is halved.

<p>
  <img src="docs/game.png" alt="Game view" width="260">
  <img src="docs/items.png" alt="List of multiplayer items" width="260">
</p>

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
- Item system with six items, each with its own visual effect
- Profile with generated avatar (colour picker) and saved single and
  multiplayer results
- Settings for music, sounds, vibration and the colours of the swipe feedback

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

Finished student project, not maintained.
