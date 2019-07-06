### Observable vs Observer

- Observable

  - Observable은 element를 갖고있는 next이벤트를 방출시킨다
    
    -  Observable은 event들의 stream
    
  - Event
  
    - Next
      - element를 갖는 event
    - Complete
      - Observable 종료 event
    - Error
      - Observable의 error event
      - Error 발생하면 Observable은 종료된다.
  
  - Observable은 종료되기 전까지 next이벤트를 계속 방출한다.
    - Error, complete event에 의해 Observable이 종료된다.
    - Observable이 종료되면 더이상 이벤트를 방출시키지 않는다.
    
  - Creating observable
  
    - `just`
  
      - 하나의 element를 갖는 Observable sequence 생성
  
        - 배열도 하나의 element!
  
        ```swift
        let observable = Observable<Int>.just(2)
        let observable = Observable<[Int]>.just([1, 2, 3])
        ```
  
    - `of`
  
      - 여러개의 element들을 갖는 Obsevable sequence생성
  
        ```swift
        let observable = Observable.of(1, 2, 3)
        let observable = Observable.of([1, 2, 3])
        ```
  
    - `from`
  
      - Array 타입의 value들을 각각 하나의 element를 갖는 Observable로 만들어준다.
  
      - from은 오직 array 타입만 사용할 수 있다.
  
        ```swift
        let observable = Observable.from([1, 2, 3])
        ```
  
  - **HotObservable(=Connectable Observable)**
  
    - 생성과 동시에 이벤트를 방출시킨다.
    - Subscribe되는 시점과 상관없이 이벤트를 방출하기 때문에 
      Observer가 중간 이벤트부터 받는 경우가 생길 수 있가.
  
  - **ColdObservable**
  
    - Observable가 이벤트는 생성시키지만 Observer가 없다면 이벤트를 발생시키지 않는다.
      - Observer가 Subscribe하는 시점부터 이벤트 발생
      - 구독시작할때 아이템들을 emit 하기 때문에 Observer 가 모든 event 을 구독할수 있는 보장이 된다.
- Observer
  -   Observer는 Subscribe를 통해 Observable가 방출한 이벤트를 구독할 수 있다. 
    - 하나의 Observable에 여러개의 Observer가 Subscribe할 수 있다.
  - Observer는 dispose되기전까지 Observable의 이벤트를 구독할 수 있다.
    - Observable은 subscription 되면 이벤트를 trigger하기 시작한다. (Cold Observable의 개념!)
      -  Subscription을 명시적으로 끝내는 방법이 dispose()다
        - dipose로 subscription이 종료되면 observable은 observer에 event를 방출시키는 걸 중지한다.
        - subscribe를 끝내지 않고 있으면 메모리 누수가 발생.
      - `DisposeBag`
        - 생성하는 subscribe마다 별도로 diposed를 관리하는 것 보다, 
          DiposeBag(Disposable타입을 담을 수 있는 객체)을 통해서 관리하는 게 더 좋다.
    - `subscribe` 는 disposable을 리턴한다.
  
