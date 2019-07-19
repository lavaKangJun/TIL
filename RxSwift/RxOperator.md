## Operator

### Creating Observables

- Create
  - 옵저버를 파라미터로 받는 function을 매개변수로 받는다. 
  - <img width="861" alt="스크린샷 2019-07-11 오후 6 55 58" src="https://user-images.githubusercontent.com/37703727/61042543-5e981280-a40f-11e9-8f44-51ddde7b5f83.png">
- Just
  - 하나의 아이템만(배열도 가능하다)을 방출시키는 옵저버블 생성
  - <img width="855" alt="스크린샷 2019-07-11 오후 7 00 14" src="https://user-images.githubusercontent.com/37703727/61042552-622b9980-a40f-11e9-9e51-9961d1b92410.png">
- Range
  - 특정 범위의 순차적인 정수 범위를 방출시키는 옵저버블 생성
- Empty
  - 어떠한 아이템도 방출시키지 않지만 종료이벤트는 발생시킨다.
- Never
  - 어떤 이벤트도 생성시키지않는 옵저버블을 생성
    - 종료이벤트(onComplete)도 생성하지 않기 때문에 종료되지 않는다.
- Time
  - 주어진  delay뒤에 아이템을 방출시키는 Observable 생성
  - <img width="849" alt="스크린샷 2019-07-11 오후 6 45 33" src="https://user-images.githubusercontent.com/37703727/61042561-635cc680-a40f-11e9-8a78-71b9be8ba4e8.png">

### Transforming Observables

- FlatMap
  - 옵저버블에서 방출된 아이템들 특정 함수를 적용한 옵저버블로 변형시킨뒤 그 옵저버블끼리 merge시켜 하나의 옵저버블로 만든다.
  - <img width="847" alt="스크린샷 2019-07-11 오후 8 00 37" src="https://user-images.githubusercontent.com/37703727/61045995-06650e80-a417-11e9-97a4-58f09f68fabd.png">
- Map
  - 옵저버블에서 방출된 각각의 아이템에  function을 적용시킨다.
  - <img width="869" alt="스크린샷 2019-07-11 오후 7 51 48" src="https://user-images.githubusercontent.com/37703727/61046014-11b83a00-a417-11e9-816a-87fb247c16d6.png">
- Scan
  - 옵저버블에 의해 방출된 각 항목에 함수를 순차적으로 적용하고 각 연속값을 방출한다.
  - <img width="855" alt="스크린샷 2019-07-11 오후 7 51 34" src="https://user-images.githubusercontent.com/37703727/61046044-209eec80-a417-11e9-9546-225bdddcdbe2.png">

### Filtering Observables

- filter
  - 옵저버블에서 매개변수로 들어온 predicate function을 통과한 아이템들만 필터링한다.
- Last
  - 옵저버블에서 가장 마지막에 방출된 아이템을 반환
- First
  - 옵저버블에서 제일먼저 방출된 값을 반환
- Take
  - 앞에서 n번째 아이템을 취한다.
  - TakeLast
    - 뒤에서 n 번째 아이템을 취한다.
- Skip
  - 앞에서 부터  n번째 아이템까지 스킵한다.
  - SkipLast
    - 뒤에서 부터 n개의 아이템을 스킵

### Combining Observables

- CombineLastest

  - 두개의 옵저버블에서 각각 아이템들을 방출시킬 때, 각각 옵저버블의 최신 값을 특정 함수를 적용시켜 컴바인 시킨다.
  - <img width="728" alt="스크린샷 2019-07-13 오후 2 41 29" src="https://user-images.githubusercontent.com/37703727/61167582-54dfed80-a57c-11e9-82cc-71888c9f22a1.png">
- Merge
  - 여러개의 옵저버블을 하나로 컴바인 시키는 데, 특정함수를 적용하진 않고 하나의 Stream으로 만들뿐.
  - <img width="722" alt="스크린샷 2019-07-13 오후 2 50 16" src="https://user-images.githubusercontent.com/37703727/61167713-8efdbf00-a57d-11e9-82f5-fd042b916fad.png">
- Zip

  - 여러개의 옵저버블에서 방출된 아이템을 특정 함수를 통해 컴바인시킨다 , 그리고 함수를 통해 컴바인 된 하나의 아이템을 방출시킨다 

    - CombineLatest와 비슷하지만 각각 옵저버블에서 방출된 최신의 아이템들을 한번만 컴바인 시킨다는 게 다르다.

  - <img width="708" alt="스크린샷 2019-07-13 오후 2 48 02" src="https://user-images.githubusercontent.com/37703727/61167682-40e8bb80-a57d-11e9-97b8-fad5c59b5373.png">

### Error Handling Operators

Error Handling은 onError 노티에 대한 응답이다.

- Catch

  - 에러 노티가 발생하면 에러가 발생한 아이템들을 교체하거나 그부분을 다른 시퀀스로 교체한다.
  - ![스크린샷 2019-07-13 오후 2.59.17](/Users/kakao/Desktop/스크린샷 2019-07-13 오후 2.59.17.png)
  - **InSwift**
    - `func catchError(_ handler:) -> RxSwift.Observable<Self.E>`
      - 에러가 발생하면 핸들러를 통해 새로운 옵저버블을 만들 수 있다.
    - `func catchErrorJustReturn(_ element:) -> RxSwift.Observable<Self.E>`
      - 어떤 에러가 발생하던지 미리 정의해 놓은 데이터를 반환한다
        - 그래서 어떤에러가 발생하던지 간에 동일한 데이터를 반환

- Retry

  - 옵저버블이 에러를 발생시키면,  옵저버블이 에러 없이 끝날걸 기대하며 다시 resubscribe 한다.

    - **처음부터** 다시 resubscribe한다.
  - 성공할때까지 계속 반복한다.
  
- ![스크린샷 2019-07-13 오후 2.55.37](/Users/kakao/Desktop/스크린샷 2019-07-13 오후 2.55.37.png)
  
  - **In Swift**
  
    -  `func retry() -> RxSwift.Observable<Self.E>`
    
    - `func retry(_ maxAttemptCount:) -> Observable<E>`
    
      - 무한번 retry되는 걸 방지하고자 limit count를 줄 수 있다.
    
      - ```swfit
        .....
        .retry(3) // retry 3번 후에 catchError 실행
        .catchError { error in
        	...
        }
        ```
    
    - `  func retryWhen(_ notificationHandler:) -> Observable<E>`
    
      - Retry 되는 횟수와 Retry될 때 시간차를 둘 수 있다.
    
    

### Utility Operators

- Delay

  - 특정시간만큼 옵저버블의 시퀀스를 시간상 이동시킨다.
  - <img width="714" alt="스크린샷 2019-07-13 오후 3 07 31" src="https://user-images.githubusercontent.com/37703727/61167966-4ba54f80-a581-11e9-9a71-ccaa28c037b2.png">

- Do

  - 옵저버블의 액션을 등록하는 메서드

- Materialize/Dematerialize

  - Materialize를 통해 방출된 아이템들에게 이번트 액션을 씌운다.
  - <img width="723" alt="스크린샷 2019-07-13 오후 3 15 45" src="https://user-images.githubusercontent.com/37703727/61167955-24e71900-a581-11e9-903b-7fe62136624f.png">
  - Dematerialize를 통해 방출된 이벤트들에서 값들만 꺼낸다.
  - <img width="706" alt="스크린샷 2019-07-13 오후 3 15 39" src="https://user-images.githubusercontent.com/37703727/61167954-24e71900-a581-11e9-985d-26c324fbf577.png">

  - 두가지를 같이 쓸 경우 강력한 파워를 가지게된다!!

  - ```swift 
    observableToLog.materialize()
      .do(onNext: { (event) in
        myAdvancedLogEvent(event)
      })
      .dematerialize()
    ```

- ObserveOn

  - Observer가 Observable을 Observe할 스케줄러를 지정해 주는 것
    - 즉, Observation이 일어나는 스케줄러를 지정
  - ![스크린샷 2019-07-13 오후 3.26.38](/Users/kakao/Desktop/스크린샷 2019-07-13 오후 3.26.38.png)

- Subscribe

  - Subscribe 를 통해 옵저버가 옵저버블이 발생시키는 이벤트나 아이템들을 받을 수 있다.
    - ObservableEvent
      - onNext
      - onComplete
      - onError

- SubscribeOn

  - Rx의 많은 구현은 스케줄러를 사용하여 다중 스레드 환경에서 옵저버블의 스레드 간 전환을 관리한다.
  - Observable이 자신의 work를 수행할 스케줄러를 지정
    - SubscibeOn을 사용하고 다른 스케줄러를 사용하지 않았다면, Observable과 Obsever가 같은 스레드에서 작업하게 된다.
  - ![스크린샷 2019-07-13 오후 3.36.09](/Users/kakao/Desktop/스크린샷 2019-07-13 오후 3.36.09.png)

- **SubscribeOn and ObserveOn**

  - 두 스케줄러를 같이쓰는 방식으로 많이 사용한다.

  - ```swift
    fruit
      .subscribeOn(globalScheduler)
      .dump()
      .observeOn(MainScheduler.instance)
      .dumpingSubscripti
    
    // print
    // 00s | [D] [apple] received on Anonymous Thread
    // 00s | [S] [apple] received on Main Thread
    // 02s | [D] [pineapple] received on Anonymous Thread
    // 02s | [S] [pineapple] received on Main Thread
    // 04s | [D] [strawberry] received on Anonymous Thread
    // 04s | [S] [strawberry] received on Main Thread
    
    // Observable이 event를 발생시키는 작업은 백그라운드 스레드에서 실행되었고,
    // Observer의 Observation(subscribtion)은 메인 스레이드에 실행되었다.
    ```

  - 

- Timeout

  - 옵저버블이 특정시간동안 어떤 아템도 방출시키지 않으면 에러 이벤트와 함께 종료시킨다.

  - ![스크린샷 2019-07-13 오후 3.40.39](/Users/kakao/Desktop/스크린샷 2019-07-13 오후 3.40.39.png)

    

###Conditional and Boolean Operators

- SkipUntil
  - 다른 옵저버블이 아이템을 방출시킬때 까지 옵저버블의 아이템을 무시한다.
  - <img width="722" alt="스크린샷 2019-07-13 오후 3 46 46" src="https://user-images.githubusercontent.com/37703727/61168215-9628cb00-a585-11e9-8ec3-5561bba20728.png">
- SkipWhile
  - 옵저버블이 특정 조건에 false 될까지 옵저버블의 아이템을 무시한다.
  - <img width="731" alt="스크린샷 2019-07-13 오후 3 47 21" src="https://user-images.githubusercontent.com/37703727/61168216-96c16180-a585-11e9-9e89-c3dfec0f6831.png">
- TakeUntil
  - 다른 옵저버블이 아이템을 방출하기 전까지 source 옵저버블의 아이템들을 받는다.
    - 다른 옵저버블이 아이템을 방출하기 시작하면 source 옵저버블의 아이템들을 무시한다.
  - <img width="724" alt="스크린샷 2019-07-13 오후 3 50 38" src="https://user-images.githubusercontent.com/37703727/61168337-cd987700-a587-11e9-98d6-32b99147ca90.png">
- TakeWhile
  - 옵저버블이 특정조건에 대해 false일때까지 미러링한다.
  - <img width="722" alt="스크린샷 2019-07-13 오후 4 03 11" src="https://user-images.githubusercontent.com/37703727/61168335-c40f0f00-a587-11e9-9517-d7548e460b8c.png">
- Contains
  - 옵저버블이 특정 값을 가지고 있으면 true를 반환
- SequenceEqual
  - 두개의 옵저버블이 방출한 시퀀스가 동일한지 판별하는 메서드
  - <img width="726" alt="스크린샷 2019-07-13 오후 4 07 38" src="https://user-images.githubusercontent.com/37703727/61168382-5ca58f00-a588-11e9-98e2-6c6c48861d33.png">

### Other Operators

- reduce
  - 옵저버블에서 방출되는 아이템들에게 순차적으로 함수를 적용시켜서 결과적으로 하나의 값만 방출시킨다.
  - <img width="716" alt="스크린샷 2019-07-13 오후 4 09 40" src="https://user-images.githubusercontent.com/37703727/61168400-a7bfa200-a588-11e9-8c2d-643b1aa749df.png">

### Connectable Observable Operators

- Publish
  - 일반적인 옵저버블을 Connectable Observable로 변환시켜준다.
  - <img width="736" alt="스크린샷 2019-07-14 오전 11 36 58" src="https://user-images.githubusercontent.com/37703727/61178641-e6f2ff00-a62b-11e9-8390-97a64f3013df.png">
- Replay
  - 어떤 옵저버든지 동일한 시퀀스를 가질 수 있게 한다.
  - Observer가 Subscribe하는 시점보다 item이 방출된 시점이 빠르더라도 다시 재 방출한다.
  - <img width="721" alt="스크린샷 2019-07-14 오전 11 37 17" src="https://user-images.githubusercontent.com/37703727/61178642-e8bcc280-a62b-11e9-81ad-195535afc27a.png">
- Conntect 
  - Connectable 옵저버블이 아이템들을 방출시키게 해준다.
- RefCount
  - Connectable 옵저버블이 Ordinary 옵저버블처럼 행동하게 바꿔준다.
  - <img width="719" alt="스크린샷 2019-07-14 오전 11 38 15" src="https://user-images.githubusercontent.com/37703727/61178643-ea868600-a62b-11e9-82c4-2ad51d8ab9f5.png">