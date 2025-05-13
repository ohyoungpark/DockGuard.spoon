--- === DockGuard ===
---
--- Prevents the macOS Dock from moving to another monitor by nudging the mouse cursor upward when it nears the bottom edge of the main screen.
---
--- Author: Ohyoung Park
--- Homepage: https://github.com/ohyoungpark/DockGuard.spoon
--- License: The Unlicense

local obj = {}
obj.__index = obj

obj.name = "DockGuard"
obj.version = "0.1"

--- How many pixels from the bottom edge the cursor must approach to trigger the Dock movement prevention. Default: 1
--- The margin (in pixels) from the bottom edge of the main screen that triggers the fake mouse event to keep the Dock fixed on the main monitor. Increase this value if the default does not work on your macOS version.
obj.edgeTriggerMargin = 1

--- Delay (in seconds) before restarting the watcher after nudging the cursor. Default: 0.1
--- The delay (in seconds) before restarting the mouse movement watcher after the cursor is nudged. Increase this value if the Dock is still able to move to another monitor.
obj.watcherRestartDelay = 0.1

--- How many pixels the cursor will be nudged upward when triggered. Default: 1
--- The distance (in pixels) to nudge the mouse upward when the Dock movement prevention is triggered. Increase this value if the Dock is still moving to another monitor.
obj.mouseNudgeDistance = 1

---
--- Starts monitoring mouse movement and prevent the Dock from moving to another monitor.
--- Starts monitoring mouse movement. When the mouse cursor approaches the bottom edge of the main screen, it nudges the cursor upward to prevent the Dock from moving to another monitor.
function obj:start()
  local mouseMoveWatcher = nil

  mouseMoveWatcher = hs.eventtap.new({ hs.eventtap.event.types.mouseMoved }, function(event)
    local pos = event:location()
    local screen = hs.mouse.getCurrentScreen()
    if not screen then
      return false
    end
    local frame = screen:fullFrame()
    local relativeY = pos.y - frame.y
    local bottomY = frame.h

    if relativeY >= (bottomY - self.edgeTriggerMargin) then
      mouseMoveWatcher:stop()
      local fakePos = { x = pos.x, y = pos.y - self.mouseNudgeDistance }
      hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.mouseMoved, fakePos):post()
      hs.timer.doAfter(self.watcherRestartDelay, function()
        mouseMoveWatcher:start()
      end)
    end
    return false
  end)
  mouseMoveWatcher:start()
  self._mouseMoveWatcher = mouseMoveWatcher
end

---
--- Stops monitoring mouse movement and allows the Dock to move between monitors.
--- Stops monitoring mouse movement and allows the Dock to move to another monitor.
function obj:stop()
  if self._mouseMoveWatcher then
    self._mouseMoveWatcher:stop()
    self._mouseMoveWatcher = nil
  end
end

return obj