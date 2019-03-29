## Stanford iOS11

### Demo

- mutating
- protocols
- String
- NSAttributedString
- Closure



#### 1. Mutating

Value type 구조체인 경우에 self를 바꾸는 메서드를 구현하기 위해서는 `mutating` 을 명시해 줘야한다.



#### 2. Protocol

- 별도의 구현 없는 메서드와 변수의 리스트

- 프로토콜 다중 채택가능

- 선택구현

  - Swift

    - 프로토콜을 채택하면 프로토콜안에 있는 메서드와 프로퍼티들을 모두 구현해야한다

  - Objc

    - 구현이 선택적
      - Optional이 아닌것만 필수로 구현


- 프로토콜이 다른 프로토콜을 상속(채택)가능하다
  - 상속하는 프로토콜을 모두 구현해 줘야한다.

- 프로토콜이 구조체에 의해 구현되어서 그 내용을 수정해야한다면 `mutating`키워드를 명시해줘야한다.

- Only class protocol인 경우

  `protocol protocolName: class {}`

- Init사용가능

  - class에서 Init사용하는 경우 required표시해 줘야한다
    - 서브 클래스가 init을 구현하지 않게하기위해

- 기존에 존재하는 Type에 extension해서 프로토콜 채택가능하게 할 수 있다.

- 기본구현

  - 프로토콜을 익스텐션해서 구현
  - 프로토콜에서 메서드에 대한 기본구현이 가능하다
  - 기본구현이 되어있는 프로토콜을 채택하면 별도의 구현없이 메서드 사용가능

- 대표적인 Protocol

  - CountableRange
    - 계수가능 범위
  - Sequence
  - Collection

#### 3. String

**문자(Character)의 조합**

- 정수로 색인할 수 없다 (It's not Sequence)

  - 그러나 String.Index로 색인가능

  - 정수로 색인하고 싶으면

    - `let array = Array(str) //Array<Character> ` 

    - Collection Protocol method
      - component(seperatedBy:) - 배열로 반환해준다.

#### 4. NSAttributedString

- String의 Atrribute들을 dictionar로 한번에 설정가능
- String과는 별개의 class이다.
- NSString으로 부터 파생



#### 5. Closure

- Reference type
- Capturing
  - 주변코드로 부터 변수를 받았으면 그 변수들도 힙에 존재하게된다.
    - 클로져가 없어지면 변수들도 힙에서 사라진다
    - 클로저안에 클래스(참조타입)가 들어오면 서로 가르키게 되어서 **메모리사이클** 발생

#### 6. ETC

- outlet에서 willSet, didSet 사용가능
- Why swift에서는 class보다 struct사용을 지향하는가?
  - Struct는 COW방식을 채택하고 있어서 무한정 복사를 계속하지 않기때문에 Struct사용해도 메모리에 크게 문제가 생기지 않는다.

