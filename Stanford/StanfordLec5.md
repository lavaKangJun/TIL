## Stanford iOS11

### Demo

- Error Handling
- Any
- Other Interesting Classes
- Custom Drawing
- Enum

#### 1. Error Handling

- throw
  - 메서드에서 error가 발생하면 에러를 날림
- error catch
  - `do {try }catch let error {}`
    - `let error`
      - Error  프로토콜의 구현체
      - iOS에서 날라오는 error는 NSError
      - NSError는 클래스로서 다양한 메서드와 변수들을 가지고 있다.
  - `try!`
    - error가 발생하면 앱 강제종료
  - `try?`
    - error가 발생하면 nil이 리턴된다.
      - error를 무시

#### 2. Any

- Any & AnyObject
  - Any
    - 모든 타입
  - AnyObject
    - Class 타입에 한정적
  - 타입변환이 필수적이다.
    - Casting
      - Down Casting: as?

#### 3. Class

- NSObject
  - Object-C의 모든 클래스들의 root class
- NSNumber
  - Object-C에서 숫자를 전달할 때 사용
  - 소수, 정수,,, 모든 숫자 표현이 가능하고,  boolean도 표현가능

- Date
  - 날짜, 시간 Type
  - 1970년 이후로 몇초가 흘렀는 지 표현
  - Calander, DateFormatter, DateComponents같은 class로 형태를 변형해서 사용해야한다.
- Data
  - 비트를 담는 Type

#### 4. View

- UIWindow
  - iOS의 최상의 뷰
- Initialize
  - awakeFromNib()
    - 이 메서드는 뷰들이 스토리보드로 작성됐을 때 호출된다.
    - 이 메서드는 이니셜라이즈 메서드가아니라 이니셜라이즈가 되고난 직후 호출되는 메서드

#### 5. Drawing

- CGFloat

  - **CG** - 코어 그래픽스(2차원 드로잉을 하기위한 시스템)
  - 코어그래픽스에서 드로잉할 시점은 부동소수점으로 나타낸다.
    - 이 숫자들이 CGFloat이다.

- CGPoint

  - CGFloat타입인 변수 x, y가 들어있는 구조체

- CGSize

  - CGFloat 타입의 높이, 너비가 들어있는 구조체

- CGRect

  - 직사각형 
    - ex. 뷰의 경계

- 좌표계

  - 좌측상단이 원점
    - 우측으로 갈수록 x증가
    - 아래로 내려갈수록 y증가

- bounds

  - 드로잉좌표계의 원점과 높이, 너비
  - 뷰마다 서로다른 좌표계를 가지고 있다.
  - 지금 그리고있는 것에 관한 정보

- frame

  - 드로잉과 전혀 상관없다
  - 슈퍼뷰에서 어디에 위치해있는 지를 알려줌
  - 슈퍼뷰의 좌표계

- draw method

  - `override func draw(_ rect: CGRect)`
    - 이 메서드안에 그려질 정보들을 넣는다.
    - 직접호출할 수 없다. 대신 아래의 메서드를 통해 호출할 수 있음.
      - `setNeedDisplay()`
        - 전체를 다시 드로잉
      - `setNeedDisplay(_ rect: CGRect)`
        - Rect 부분만 다시 드로잉
  - drawing하는 2가지 방법
    - UIBezierPath
    - drawing context
      - context를 얻어서 드로잉
      -  UIGraphicsGetCurrentContext()를 통해 context 획득

- CALayer

  - CoreAnimationLayer

  - 애니메이션 효과를 줄 수 있는 layer

- Layout on bounds change (레이아웃의 경계가 변경됐을 때)

  - `override layoutSubviews() {}` 메서드를 통해 Subview 재배치 가능
    - 오토레이아웃이 적용되지 않은 경우에만 사용하는 메서드
