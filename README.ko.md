[View this document in English (EN)](./README.md)

# DockGuard.spoon

DockGuard.spoon은 macOS에서 Dock이 메인 모니터(메뉴바가 있는 모니터)에서 다른 모니터로 이동하는 것을 방지하는 Hammerspoon 플러그인(Spoon)입니다.

> ⚠️ 참고: Dock의 'Automatically hide and show the Dock'(Dock 자동 숨김) 옵션이 활성화된 경우, 본 플러그인(Spoon)은 정상적으로 동작하지 않을 수 있습니다.

## 개요
Dock이 없는 보조 모니터의 하단에 마우스 커서가 일정 시간 머물면 Dock이 해당 모니터로 이동하는 macOS의 기본 동작을 방지합니다. DockGuard.spoon은 마우스 커서가 화면 하단에 접근할 경우, 커서를 위로 살짝 이동시켜 Dock 이동 조건이 충족되지 않도록 만듭니다.
걱정하지 마세요. 눈 크게 뜨고 보지 않는 이상 커서의 움직임은 느껴지지 않습니다.

[다른 대안들](https://blog.seekella.com/ko/blog/stop-the-dock-from-moving-across-monitors-in-macos/)

## 설치 및 사용 방법
1. **Hammerspoon 설치**
   - Homebrew가 설치된 경우, 터미널에서 다음 명령어를 실행합니다:
     ```bash
     brew install --cask hammerspoon
     open -a Hammerspoon
     ```
   - 또는 [Hammerspoon 공식 사이트](https://www.hammerspoon.org/)에서 직접 다운로드하여 설치할 수 있습니다.
2. 본 저장소를 다운로드하거나 클론합니다.
3. `DockGuard.spoon` 폴더를 `~/.hammerspoon/Spoons/` 디렉터리에 복사합니다.
4. `~/.hammerspoon/init.lua` 파일에 아래 코드를 추가하여 DockGuard.spoon을 활성화합니다:
   ```lua
   hs.loadSpoon("DockGuard")
   spoon.DockGuard:start()
   ```
5. 메뉴바의 Hammerspoon 아이콘을 클릭하여 **'Reload Config'**를 실행합니다. (설정이 적용되지 않거나 동작하지 않을 경우, **'Preferences'**에서 접근성 권한을 확인해 주세요.)

DockGuard.spoon은 macOS Sequoia(15.1.1)에서 기본 설정으로 정상 동작함을 확인하였으나, macOS 버전에 따라 동작이 다를 수 있습니다. 이 경우 아래 설정값을 조정해 보시기 바랍니다.

- `edgeTriggerMargin`: 화면 하단에서 몇 픽셀 이내로 커서가 접근하면 동작할지 설정 (기본값: 1)
- `mouseNudgeDistance`: 커서를 위로 몇 픽셀 이동시킬지 설정 (기본값: 1)
- `watcherRestartDelay`: 커서를 이동시킨 후 감시를 재시작하는 지연 시간(초) (기본값: 0.1)

예시 설정:
```lua
hs.loadSpoon("DockGuard")
spoon.DockGuard.edgeTriggerMargin = 5 -- 5픽셀 이내 접근 시 동작
spoon.DockGuard.mouseNudgeDistance = 2 -- 2픽셀 위로 이동
spoon.DockGuard.watcherRestartDelay = 0.2 -- 0.2초 후 감시 재시작
spoon.DockGuard:start()
```

## 라이선스
이 프로젝트는 The Unlicense로 배포됩니다. 자세한 내용은 [LICENSE](./LICENSE) 파일을 참고하세요.