## Stanford iOS11

### Demo

- Tuple
- Computed Properties
- Access Control
- Assertion
- Extension
- Optional
- Enum
- Switch
- DataStructure

#### 1. Tuple

**가벼운 구조체, 값의 집합**

- 어떤 타입이든 다 튜플에 넣을 수 있다

- 이름 설정에 유연하다

- 인덱스 사용할 수 없다

- 장점

  - 함수의 리턴값으로 사용될 수 있다.
    - 하나이상의 값을 리턴할 수 있다.

#### 2. Computed Properties

- get

  - 프로퍼티를 요청할 때 get안에 있는 코드실행
  - get만 쓰는 경우 get이라고 명시하지 않는다.

- set

  - 값이 할당될 때 set안에 있는 코드 실행


#### 3. Access Control

- Internal 
  - default
  - 앱내에서 접근하는 데 제한 없음
- private
  - Scope안에서만 접근할 수 있다.
- private(set)
  - 앱내(모듈내부)에서 접근가능 하지만 읽기만 가능
- fileprivate
  - 같은 파일안에서만 접근가능
- public
  - 모듈외부까지 접근가능
- open
  - 모듈외부까지 접근가능
  - 클래스에서만 사용가능

#### 4. Assertion

- `assert(조건, 조건이 거짓일경우 출력될 구문)`
- 빠른종료

#### 5. Extension

- 저장변수는 선언할 수 없다

#### 6. Optional

- enum으로 선언되어 있다.

  ```swift
  enum Optional<T> { // generic타입이기 때문에 어떤 데이터 타입이든 가능하다.
      case none
      case some(<T>)
  }
  ```


#### 7. Enum

- Value Type

- 변수와 메서드를 가질 수 있다.

  - 변수
    - 저장변수는 가질 수 없다.
  - 메서드
    - mutating 사용가능

- Switch문으로 enum값을 확인

####8. Switch

- Case, default, fall through, break, ,
  - case
    - 조건확인
  - default
    - case에 걸리지 않은 나머지 조건 실행문
  - fall through
    - fallthrough: switch 구문의 case를 연속 실행
  - break
    - switch문을 빠져나온다.
    - swift는 명시해주지 않아도 된다.
  - ,
    - 쉼표로 case문을 묶을 수 있다.

#### 9. DataStructure
**calss, struct, enum, protocol - 모두 Type**

- class

  - 단일상속

  - 참조타입

    - heap에 저장
      - 언제힙에서 사라지나?
        - ARC에 의해

  - ARC

    - heap내의 참조타입에 포인터를 만들때 마다 Counter가 1개씩 증가하고
      포인터가 사라질때마다 Counter가 1개씩 감소

    - 포인터를 가르키는게 없어지면 힙에서 사라짐

    - Strong

      - 가르키고있는 한 heap에 계속둔다.
      - Default

    - Weak

      - 가르키지 않으면 nil로 바뀐다
      - Optional 포인터
      - outlet, delegate에서 많이 사용

    - Unowned

      - 힙에서 사라지면 접근하지 않는다.

    - 메모리사이클

      - 힙에서 서로만 서로를 가르키고 있어서 힙에서 사라지지 않는것

      - 클로저에 의해 자주 발생

- Struct

  - Value Type

    - 복제된다
        - cow

    - 상속은 되지 않는다

  - 스위프트의 모든 데이터 타입

    - Array, Dictionary, String, Int, Double...

  - Protocol 채택가능

- Enum

  - Protocol 채택가능
