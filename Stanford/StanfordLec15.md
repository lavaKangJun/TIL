## Stanford iOS11

### Demo

- App Lifecycle



#### 1. App Lifecycle

<img width="405" alt="스크린샷 2019-04-05 오후 3 56 19" src="https://user-images.githubusercontent.com/37703727/55611611-f9ee6b80-57c0-11e9-8b80-103a9eaa6764.png">

- Inactive
  - 코드는 실행되지만 UIEvent 받지못함 (준비작업 실행)
- Active
  - 코드가 실행되며 UIEvent 받을 수 있는 상태 (일반적인 Running 상태)
- Background
  - 코드는 실행되고 있지만 UIEvent 받지못함
  - 대략 백그라운드 상태는 30초정도로 제한

- Suspended
  - 코드가 실행되지 않고, 언제든지 죽임당할 수 있는 상태
- Example
  - Switch to another app
    - Active ->  Inactive -> Background -> Suspend
- App Lifecycle func
  - Not running -> Inactive
    - `application:willFinishLaunchingWithOptions:`—This method is your app’s first chance to execute code at launch time.
    - `application:didFinishLaunchingWithOptions:`—This method allows you to perform any final initialization before your app is displayed to the user.
  - Inactive -> Active
    - `applicationDidBecomeActive:`—Lets your app know that it is about to become the foreground app. Use this method for any last minute preparation.
  - Active -> Inactive
    - `applicationWillResignActive:`—Lets you know that your app is transitioning away from being the foreground app. Use this method to put your app into a quiescent state.
  - Inactive -> Background
    - `applicationDidEnterBackground:`—Lets you know that your app is now running in the background and may be suspended at any time.
  - Background -> Inactive
    - `applicationWillEnterForeground:`—Lets you know that your app is moving out of the background and back into the foreground, but that it is not yet active.
  - `applicationWillTerminate:`—Lets you know that your app is being terminated. This method is not called if your app is suspended.
