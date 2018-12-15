# StanFord 



##  #Lec1

1. 모든 인수(매개변수)들에겐 이름이 있고, 이름을 2개(내부이름, 외부이름) 가질 수 있다.
   메서드를 부를 때 인수의 이름을 포함해야 한다.

   ```swift
   func addNumber(first a: Int, second b: Int) -> Int {
       return a + b
   }
   
   addNumber(first: 3, second: 4) //7
   ```


2. 매개변수 이름 중 `_` 는 매개 변수를 쓰지 않아도 된다는 것

   ```swift
   @IBAction func touchButton(_ sender: UIButton) {
       ....
   }
   
   // _는 메서드를 사용할 때 인수 명을 작성해 주지 않아도 된다.
   touchButton(firstButton)
   touchButton(sender: firstButton)
   ```

     

3. `UILabel` : Swift의 읽기전용 TextField



4. 프로퍼티 감시자 `didSet, willSet`

   `didSet`: 속성이 설정될 때마다 이 안의 코드가 실행된다.

   ```[swift]
   @IBOutlet weak var filpCountLabel: UILabel!
   var flipCount: Int = 0 {
       didSet {
   		flipCountLabel.text = "FlipCount\(flipCount)"
   	}
   }
   ```

5. `OutletCollection`: UI의 배열



6. *소스코드 내 오타 수정하기* : `Command` 누르고 `오타`클릭 후 `Rename` 클릭



## #Lec2

1. MVC Model: 
   (1) Model: 무엇(집중력 게임에 대한 지식들)
   (2) View: View는 Controller가 어떤 모델과 일하는 지  모른다.
   (3) Controller: 모델이 어떻게 View에 보여지나
2. API: Application Programming Interface
3. Lazy: 속성관찰자(didSet, willSet) 가질 수 없다.



## #Lec3

1. left, right가 아닌이유
   아랍, 히브리어는 오른쪽에서 왼쪽으로 정렬되어있기 때문에 leading, tail로 표시한다.

2. Float -> Countable range : `stribe(from, through, by)` -> 부동소수점을 셀 수 있게 해준다.

3. Tuple

   ```swift
   // 튜블의 요소 이름을 나중에 설정할 수 있다.
   let x: (String, Int, Double) = ("hello", 5, 0.85)
   let (word, number, value) = x
   print(word) // "hello"
   print(number) // 5
   print(value) // 0.85
   
   // 이름.변수로 값을 가져 올 수 있고, 이름을 재설정 할 수 있다.
   let x: (w: String, i: Int, v: Double) = = ("hello", 5, 0.85)
   print(x.w) // "hello"
   print(x.i) // 5
   print(x.v) // 0.85
   let (word, number, value)
   
   // 튜플을 사용하면 함수에서 원하는 만큼 리턴이 가능하다.
   func getSize() -> (weight: Double, height: Double) {retuen (50, 180)}
   let z = getSize()
   print(z.weight) //50
   print(z.height) //180
   
   // Indexting not support
   ```

4. 계산된 속성
   (1) `var foo: Double`: 메모리에 저장됨
   (2) `var foo: Double {get{} set{}}`: 어디에도 저장되지 않는다.
   foo를 요청할때마다 get안에 있는 코드를 실행하고, 
   foo값을 요청할 때마다 set안에 있는 코드를 실행. *읽기 전용인 경우 get{}을 표시하지 않아도 된다.*

5. 접근제어

   (1) internal  - 앱 내에서 접근하는 데 제한이 없다. [default]

   (2) private - 다른 객체로 불러올 수 없다.

   (3) private(set) - 변수를 위한 접근제어
   ​			     접근할 수 있지만 할당할 수 없다.

   (4) fileprivate - 그 파일안에 있는 어떤 것이던 서로 접근이 가능

   (5) public - 프레임워크의 외부사용자가 불러올 수 있다.

   (6) open - 외부사용자가 불러올 수 있다.
   ​		  클래스의 서브클래스를 만들거나 메소드를 오버라이드하는 등 모든 것을 할 수 있다. [완전히 open]

6. extension: 저장변수를 할당 할 수 없다. 
   계산된 변수만 가질 수 있음.

7. enum

   ```swift
   enum FastFoodMenuItem{
        case hambuger(numberOfPatties: Int)
        case fries(size: FryOrderSize)
        case drink(String, ounces: Int)
        case cookie
   } 
   
   enum FryOderSize {
       case large
       case small
   }
   
   // 어떤 정보를 요청할 때 이름 재설정 가능
   switch menuItem {
       case .hamburger(let pattyCount): print("a burger with \(pattyCount) patties")
       case .fries(let size): print("a \(size) order of fries")
       case .drink(let brand, let ounces): print("a \(ounces)oz \(brand)")
       case .cookie: print("a cookie!")
   }
   
   //self를 이용해서 enum의 self를 변경할 때 mutating을 써야한다.
   //mutating: 내부 상태를 변경시킬 때 사용
   ```

8. 옵셔널 체이닝

9. Weak: 옵셔널인 경우에 사용(ex. IBOutlet, delegation)

10. unowned

11. Struct, enum : 프로토콜을 이용하여 상속

12. Assert:  배포되는 App에서는 제외되고 디버깅 중 조건의 검증을 위해서 사용
     `assert(조건, "콘솔창에 보일 오류 문구")` : 조건이 참이면 넘어감

     **Auto Clousure**

      	1. 매개변수를 받지 않고 자신이 감싸고 있는 코드의 결과값만 반환한다.
      	2. 소괄호와 중괄호를 겹쳐써야하는 클로저 문법을 사용하지 않고도 클로저를 사용가능하다.
      	3. 대표적인 예: assert(condition:message:file:line:) -> condition과 message 매개변수가 자동 클로저
           	1. assert: public으로 구현되어 있어  API를 보호할 수 있다.

## Lec4

1. 구조체: 컨트롤러안에 존재(= 컨트롤러에 모델이 내장된 형태)

   클래스: 컨트롤러에 모델의 포인터가 저장

2. mutating: 구조체에서 객체를 바꾸는 `함수`라는 것을 알려줌
   변수는 값이 변경될 수 있다는 것을 알고 있기 때문에 mutating을 쓰지 않는다.
   `var : 변경가능 , let : 변경 불가능, get{}: 읽기전용, set{}: 변경가능 `

3. **프로토콜**

   1. 프로토콜은 저장공간이 없다. 
   2. 프로토콜을 상속받으면 모든 변수와 메서드를 구현해야 한다.
      (But Object-c 로 구현된것은 선택적[@objc로 표시] -> delegate가 대표적인 예 )
   3. 프로토콜이 다른 프로토콜을 상속받는 경우

   ```swift
   protocol C: A, B {}
   // C프로토콜을 구현하기 위해서는 A, B 둘다 구현해야한다.
   ```

   4. 메소드에 대한 기본 구현을 제공할 수 있다.

   5. 프로토콜이 절대 구조체에서 구현되지 않을 걸 안다면 `mutating표시가 필요 없지만 클래스만 받는 프로토콜임을` 표시해 주어야한다.

      ```swift
      protocol onlyClass: class {}
      ```

4. String

   1. String의 문자 색인 결과는 Int(정수형)가 아니라  String.Index이다.

5. NSAttributeString

6. **클로저**

   1. 참조 타입
   2. 주변 속성을 캡쳐한다.



## Lec5

1. Throw : 메서드 옆에 표현하고, 오류가능성을 내포한다.

   1. 오류를 내포하는 throws 함수를 사용할 때는 `try`사용하여 호출한다

      1. `do-catch` 구문을 사용하여 오류발생에 대비

         ```swift
         do{
             try
         } catch {
             
         }
         ```

      2. `try?` 오류결과를 통보받지 않고 nil을 돌려 받는다.
         정상 작동 후에는 옵셔널로 반환한다
      3. `try!` 정상작동 후 결과값 돌려 받는다.
         오류 발생하면 런타임 오류 발생

2. Any & AnyObject
   1. Any: 모든타임
   2. AnyObject: 클래스에 한정
   3. 주로 as와 함께 쓰여 타입을 명확하게 한다.
3. Data class: 비트를 담는 가방
4. Initializing a view
   1. init(fram: CGRect) : 코드로 뷰를 작성했을 때
   2. init(coder: NSCoder): 인터페이스 필더로 구현했을 때
5. CG(코어그래픽스) - iOS에서 2차원 드로잉을 하기위한 시스템
   1. 4개의 타입이 존재
      1. GCFloat: 부동소수점을 나타내는 기본적인 타입
      2. CGPoint: 좌표로 위치지정
      3. CGSize: 크기표현
      4. CGRect: 직사각형으로 범위 지정
6. iOS 좌표계: 좌측상단이 원점(0,0)
7.  Bounds: 어디에 뷰를 그리고 있는 지 알려줌
8. draw()함수를 직접 호출할 수 없고, 호출하고 싶으면 setNeedDisplay()로 호출
9. 구조체 - 이니셜라이저 자동생성



## Lec 6

