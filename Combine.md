### Publisher

- 이벤트를 방출시킴 (= Observable과 동일한 느낌)
- Swift의 NotificationCenter와 비슷함
  - 실제로 NotificationCenter에 publisher(for:object:)라는 메서드가 있고 Publisher를 리턴한다.
  - 그리고 더이상 사용하지 않을때 해지를 시켜주는게 비슷함
  - NotificationCenter같은 기존에 존재하는 API들을 combine화 하고 있다.
 - 두가지의 이벤트를 방출시킴
   
   - 값을 가진 이벤트, 완료 이벤트
   
- 퍼블리셔는 0개 또는 그 이상의 값을 방출할 수 있지만 completion이벤트는 한번만 방출할 수 있다.
- completion event는 두가지로 정의할 수 있다.(완료거나 에러)
- 퍼블리셔는 서브스크라이버가 한개라도 있어야 이벤트를 방출한다. 
- `Just`
  
  - 각 서브스크라이버에게 한번만 이벤트를 방출시키고 끝나는 퍼블리셔
  
- 에러를 발생시키지 않는 것을 보장하는 퍼블리셔가 존재함

  

### Subscriber

- publisher로 부터 이벤트를 받는다.
- `sink(_:_:)`
  - 클로저와 함께 서브스크라이버를 연결하는 메서드
    - 두개의 클로저가 존재함(컴플리션 이벤트를 핸들링하는 클로져, 일반적인(값을 가지고 있는) 이벤트를 핸들링하는 클로져)
  - 퍼블리셔가 이벤트를 방출한다면, 무한정으로 받을 수 있다고 알려져 있다.

- `assign(to:on:)`
  - 객체의 KVO-compliant 프로퍼티에 받을 이벤트 값을 할당해준다. (= 주어진 객체에 대한 프로퍼티 값을 퍼블리셔가 매번 새로운 값을 방출할 때 없데이트 시켜줄 수 있다.)

- 커스텀할 수 있다.
  - 커스텀 하면서 받을 수 있는 이벤트의 최대 갯수를 정할 수 있다.

### Cancellable

- subscriber가 더이상 이벤트 받는걸 원하지 않는다면 subsctiption을 취소해야함
- Subscription은 AnyCancellable을 리턴한다. (AnyCancellable은 CancellableProtocol을 따르는데 이는 구독 취소를 가능하게한다.)
- subscription을 cancel()메서드를 통해서 구독을 취소하지 않는다면 퍼블리셔가 complete될때까지나, 메모리 관리로 구독이 디이니셜라이져 될때까지 계속살아있게 된다.



### Future

- `Just` 와 동일하게 단일 이벤트를 방출하는 퍼블리셔이지만, 비동기적으로 사용된다.
- 긴 비동기 작업을 위해 subscription을 저장하지 않으면 스코프가 끝나는 순간 subscription도 종료되게 된다.
- 퓨쳐는 일반적인 퍼블리셔와 다르게 서브스크라이버가 없어도 바로 실행된다



### Subject

- `send` 를 통해 이벤트를 방출시킨다.
- passthrough subject
- current value subject
  - `subject.value` 로 현재값을 가져올 수 있다.
  - 초깃값을 설정하고, 구독과 동시에 초깃값이 방출된다.
  - `subject.value = ??`  == `send(??)`
  - `subject.send(completion: .finished)` 컴플리션 이벤트는 send로 전달
    - `subject.value = .finished` 로 전달은 불가능함 (.value는 value를 받음)



