

RxCocoa

- 모든 플랫폼에서 사용가능하다.
  - iOS, tvOS, macOS
- RxSwift는 UIKit과 Cocoa를 사용해서 작업을 할 수 없다.
  - 그 대안으로 RxCocoa가 탄생되었다.

- **Binding**

  - Uni-directional stream of data.

  - Observable을 다른 객체(Subject(ObserverType)를 따르는 객체)에 bind하기위해 사용한다.

  - bind(to: observer)을 사용하는 건 내부적으로 subscribe(observer)를 사용하는 것과 
    동일하다.

  - Observable의 데이터를 display할 수 있는 UI요소와 바인딩하기 위해 많이 사용된다.

    ```swift
    @IBOutlet private var searchCityName: UITextField!
    
    let search = searchCityName.rx.text.orEmpty
      .filter { !$0.isEmpty }
      .flatMapLatest { text in
        return ApiController.shared.currentWeather(city: text)
            .catchErrorJustReturn(ApiController.Weather.empty)
      }
      .share(replay: 1)
      .observeOn(MainScheduler.instance)
    
    search.map { "\($0.temperature)° C" }
      .bind(to: tempLabel.rx.text)
      .disposed(by: bag)
    ```

    

- ReactiveCompatible

  - Rx namespace를 제공

    - ReactiveCompatible를 따르는 객체들을 위해
    - NSObject는 ReactiveCompatible를 채택하고 있기 때문에 NSOject를 따르는 타입에 `rx` 키워드를 사용할 수 있다.

    ```swift
    /// Extend NSObject with `rx` proxy.
    extension NSObject: ReactiveCompatible { }
    ```
