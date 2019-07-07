### Subject

- Observable + Observer
- Method
  - asObservable(): Subject to Observable
  - asObserver(): Subject to Observer

- Async Subject

  - 가장 마지막 값(이벤트)만 방출시킨다.
    - 가장 마지막 값이라 하면 complete가 호출되기 전의 next이벤트
    - <img width="886" alt="스크린샷 2019-07-07 오후 7 53 23" src="https://user-images.githubusercontent.com/37703727/60767839-4f0b8780-a0f8-11e9-952d-b54f41277388.png">
  - 만약 error가 발생한다면 error외에 어떤 값도 방출시키지 않는다.
    - <img width="846" alt="스크린샷 2019-07-07 오후 7 53 33" src="https://user-images.githubusercontent.com/37703727/60767840-5468d200-a0f8-11e9-9a34-f5d9eec66b21.png">

- Publish Subject

  - subscribe된 그 이후의 값(이벤트)들을 방출시킨다.
    - <img width="876" alt="스크린샷 2019-07-07 오후 7 53 42" src="https://user-images.githubusercontent.com/37703727/60767843-6fd3dd00-a0f8-11e9-9c8e-c5d389da9403.png">
  - Subject가 종료된경우 미래의 subscribers들에게 stop event를 re-emit한다.
    - <img width="849" alt="스크린샷 2019-07-07 오후 7 53 51" src="https://user-images.githubusercontent.com/37703727/60767844-706c7380-a0f8-11e9-8125-447f28ae2737.png">


- Behavior Subject

  - subscribe될 때, 가장 최근에 emit한 event를 re-emit(재 방출)한뒤 그 뒤의 event들을 받는다.

    - 따라서 초깃값을 설정하면 가정먼저 초깃값에 대한 emit이 발생한다.
    - <img width="826" alt="스크린샷 2019-07-07 오후 8 03 20" src="https://user-images.githubusercontent.com/37703727/60767852-8b3ee800-a0f8-11e9-8089-4ad78ce7a0b1.png">

  - error(complete)가 발생하고 난뒤에 subscribe하면 error event(stop event)를 re-emit한다.

    - <img width="904" alt="스크린샷 2019-07-07 오후 8 03 28" src="https://user-images.githubusercontent.com/37703727/60767853-8b3ee800-a0f8-11e9-9105-bfba70d316f8.png">

- Replay Subject
  - subscribe되면 이전에 emit되었던 event들을 버퍼에 저장된만큼 re-emit(재 방출) 한다.
    - 버퍼크기는 사용자가 정할 수 있다.
    - <img width="863" alt="스크린샷 2019-07-07 오후 8 12 46" src="https://user-images.githubusercontent.com/37703727/60767854-8bd77e80-a0f8-11e9-83c7-ac016fdc548a.png">

- Relays
  - Wrapper Subject
  - **RxCocoa4**에서 처음 구현되었다.
    - Variable대신해서 사용된다.
  - Error를 만들지 않으며, Complete를 발생시키지 않는다.
    - 종료되지 않기 때문에 UI요소에서 사용된다.
  - Current 값을  `value` property로 요청할 수 있다.
  - Accept 메소드로 value를 update한다.
  - **Publish  Relay**
    - Wrap publish subject
  - **Behavior Relay**
    - Wrap behavior subject
    -  behavior subject처럼 가장 최신의 value을 replay하거나, initial value를 필요로한다.

