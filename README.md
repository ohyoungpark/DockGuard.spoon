# DockGuard.spoon

DockGuard.spoon is a Hammerspoon plugin(Spoon) that prevents the macOS Dock from moving from the main monitor (the one with the menu bar) to another monitor.

> ⚠️ Note: If 'Automatically hide and show the Dock' is enabled, this plugin(Spoon) may not work as expected.

## Overview
By default, macOS allows the Dock to move to a secondary monitor if the mouse cursor stays at the bottom edge of a screen without a Dock for a certain period. DockGuard.spoon prevents this by nudging the mouse cursor upward when it approaches the bottom edge, so the Dock does not move.
Don't worry, unless you look very closely, you won't notice the cursor movement.

[Alternative solutions](https://blog.seekella.com/blog/stop-the-dock-from-moving-across-monitors-in-macos/)

## Installation & Usage
1. **Install Hammerspoon**
   - If you have Homebrew, run:
     ```bash
     brew install --cask hammerspoon
     open -a Hammerspoon
     ```
   - Or download and install from the [official Hammerspoon website](https://www.hammerspoon.org/).
2. Download or clone this repository.
3. Copy the `DockGuard.spoon` folder to your `~/.hammerspoon/Spoons/` directory.
4. Add the following to your `~/.hammerspoon/init.lua` to activate DockGuard.spoon:
   ```lua
   hs.loadSpoon("DockGuard")
   spoon.DockGuard:start()
   ```
5. Click the Hammerspoon icon in the menu bar and select **'Reload Config'**. (If it does not work, check Accessibility permissions in **'Preferences'**.)

DockGuard.spoon has been tested with macOS Sequoia (15.1.1) using the default settings. If it does not work as expected on your macOS version, try adjusting the following parameters:

- `edgeTriggerMargin`: Number of pixels from the bottom edge to trigger the nudge (default: 1)
- `mouseNudgeDistance`: Number of pixels to nudge the cursor upward (default: 1)
- `watcherRestartDelay`: Delay (in seconds) before restarting the watcher after nudging (default: 0.1)

Example configuration:
```lua
hs.loadSpoon("DockGuard")
spoon.DockGuard.edgeTriggerMargin = 5 -- Trigger within 5px of the bottom edge
spoon.DockGuard.mouseNudgeDistance = 2 -- Nudge cursor up by 2px
spoon.DockGuard.watcherRestartDelay = 0.2 -- Restart watcher after 0.2s
spoon.DockGuard:start()
```

## License
This project is released under The Unlicense. See [LICENSE](./LICENSE) for details.

---
- [한국어 문서로 이동 (View in Korean)](./README.ko.md)