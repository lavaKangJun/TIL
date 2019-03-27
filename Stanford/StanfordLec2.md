## StanFord iOS11

### Demo

- MVC
- Struct **VS** Class
- Initialization
- for문
- Static



#### 1. MVC 디자인 패턴

**UI와 Model이 독립적인 디자인 패턴**

![스크린샷 2019-03-27 오후 2.49.37](/Users/kangjun-young/Desktop/스크린샷 2019-03-27 오후 2.49.37.png)

- Model: What, UI와 독립적
  - Model -> Controller: Notification
- Controller: How
- View: UI
  - View -> Controller: Tatget & Action, Delegate, DataSource
  - View는 자기 화면에 표시하고 있는 데이터를 가질수 없다, 아니 가져선 안된다.
    - 그래서 DataSource를 통해 데이터를 View에 보여준다.



#### 2. Struct VS Class

- Struct
  - Value Type
    - Swift는 COW방식 채택
    - Swift에서 Array는 value type
  - Stack에 저장된다.
  - 구조체는 상속이 되지 않는다.
- Class
  - Reference Type
  - Heap에 저장된다.
    - 포인터로 heap에 있는 자료형을 가르킴

#### 3. Initialization

- Class
  - 클래스내의 모든 변수들이 초기화되면 인수가 없는 Init 자동 생성
- Struct
  - 변수들을 초기화하는 Init을 자동으로 생성

#### 4. for

- for _ in _(Sequence면 모두 들어갈 수 있다.)
  - Sequence
    - 어딘가에서 시작해서 다음으로, 다음으로 넘어갈 수 있는 것(= 계수 가능범위)
      - Ex) String, Array ...
  - Indices
    - 배열의 메소드
    - 모든 Index의 계수가능 범위를 배열로 리턴

#### 5. Static

- Static func
  - 타입 메서드
- Static var
  - 타입 변수

