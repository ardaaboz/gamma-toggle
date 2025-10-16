# Gamma Toggle for Windows

Quick gamma adjustment via hotkeys. No more interrupting your games or movies to adjust brightness in Windows settings.

## Why?

Opening Windows Color Calibration every time you need to adjust gamma is annoying when you're gaming or watching movies. This script lets you do it instantly with a keypress.

## Requirements

- [AutoHotkey v2](https://www.autohotkey.com/v2/)

## Usage

- **Numpad \*** - Increase gamma (brighter)
- **Numpad -** - Default gamma

## Setup

1. Install [AutoHotkey v2](https://www.autohotkey.com/v2/)
2. Download `gamma_toggle.ahk`
3. Double-click to run

**To start automatically on boot:**
1. Press `Win + R`
2. Type `shell:startup` and press Enter
3. Copy `gamma_toggle.ahk` into that folder

## Configuration

Edit these values at the top of the script:

```ahk
DEFAULT_GAMMA := 1.0    ; Normal
INCREASED_GAMMA := 1.5  ; Brighter (try 1.5-3.0)
```

**To change hotkeys**, find these lines and replace with your preferred keys:

```ahk
NumpadMult::  ; Change this to your preferred "ON" key
NumpadSub::   ; Change this to your preferred "OFF" key
```

See [AHK key list](https://www.autohotkey.com/docs/v2/KeyList.htm) for all available keys.
