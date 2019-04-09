## Swift  문법 1

### 콘솔로그

1. print()

   줄바꿈 문자 자동 삽입

2. dump()

   출력하려는 인스턴스의 자세한 내부 콘텐츠까지 출력해줌

### 데이터 타입 기본

1. Int, UInt

   - Int: +, - 부호를 포함한 정수
   - Uint: 양의 정수

2. Bool

   - True, False 만 값으로 가진다.
   - 다른 언어들 처럼 0,1로 표현할 수 **없다**

3. Float, Double
   - 부동소수점을 사용하는 실수
   - Double: 64비트의 부동소수 표현
   - Float: 32비트의 부동소수 표현
   - **CGFloat**
   	-- 32비트에서는 Float로 표현
	-- 64비트에서는 Double로 표현
4. Character
   - 단 하나의 문자를 의미
   - `""` 큰따옴표를 사용하여 표현
5. String
   - 문자열의 나열
   - `+` 연산자를 사용하여 문자열을 이어붙일 수 있다.
   - `append()` 메서드를 통해 문자열을 이어붙일 수 있다.
   - `count` 로 문자의 수를 셀 수 있다.
6. Any, AnyObject
   - Any: 스위프트의 모든 데이터 타입을 사용가능
   - AnyObject: Any보다는 한정된 의미로 클래스의 인스턴스만 사용할 수 있다.
   - Any, AnyObject로 선언된 변수 값을 가져다 쓰기 위해선 **타입확인 및 변환이 필수적이다.**



### 데이터 타입 고급

1. typealias

   - 스위프트에서 제공하는 데이터 타입이든, 사용자가 만든 데이터 타입이든 별칭을 부여할 수 있다.

     ```swift
     typealias NewInt = Int
     typealias NewDouble = Double
     
     let age: NewInt = 100
     let height: NewDouble = 100.4
     ```


2. Tuple(튜플)

   - 프로그래머 마음대로 만드는 타입

   - 튜플은 타입 이름이 따로 없으므로 일정 타입의 나열만으로 튜플 타입을 생성해줄 수 있다.

     ```swift
     var studentInfo: (String, Int) = ("Junyoung", 26)
     var studentNewInfo: (name: String, age: Int)  = ("Junyoung", 26)
     
     // 인덱스를 통해 접근이 가능하다
     print(studentInfo.0) // Junyoung
     studentInfo.0 = "Jaemin"
     
     // 요소의 이름을 통해 접근이 가능하다.
     print(studentNewInfo.name)
     studentNewInfo.name = "Jaemin"
     
     // 별칭을 통해 깔끔하게 코드를 작성할 수 있다.
     typealias StudentInfo = (name: String, age: Int)
     
     let student1: StudentInfo = ("Nahee", 20)
     let student2: StudentInfo = ("Najung", 23)
     ```


3. Collection Type

   1. Array

   2. Dictionary

      - 순서없이 키와 값의 쌍으로 구성
      - 키는 유일한 식별자

   3. Set

      - 같은 타입의 데이터를 순서 없이 하나의 묶음으로 저장

      - 세트 내의 값은 모두 유일하며, 중복된 값이 존재하지 않는다.

      - 세트의 요소는 해시 가능한 값만 해당 (Hashable 프로토콜을 준수하는 데이터 타입[스위프트의 기본 데이터 타입은 해시 가능])

        ```swift
        // 타입추론을 하면 컴파일러가 Array로 지정하기 때문에 타입을 꼭 명시해야함
        var names: Set<String> = Set<String>()
        var ages: Set<Int> = []
        
        ages = [1, 2, 3, 4]
        ```

   4. Enum(열거형)

      - 원시값 지정이 가능하다.

        ```swift
        enum School: String {
        	case: elementary = "초등학교"
            case: middle = "중학교"
            case: high = "고등학교"
            case university = "대학교"
        }
        
        let elementayStudent = School(rawValue: "초등학교") // School.elementary
        print(School.moddle) // 중학교
        
        ```

   **indices:  유효한 값의 범위를 가짐**

 ### 연산자

1. 비교연산자
   - A == B : 값이 같다
   - A === B : 참조가 같다. (클래스 인스턴스에서만 사용가능)
   - A ~= B : 패턴매치

2. 삼항 조건 연산자

   - Question ? A : B (참이면  A, 거짓이면 B를 반환)

3. 범위 연산자
   - A...B : A부터 B까지 (A, B포함)
   - A..<B : A부터 B미만 까지

4. nil 병합연산자

   ```swift
   var job: String?
   guard job = job ?? "swan"
   ```




### 흐름제어

1. 조건문

   1. if 구문

   2. switch 구문

      - break 구문은 선택 사항

      - fallthrough: switch 구문의 case를 연속 실행

      - default 작성 필수(case에 모든 경우를 다 적지 않은 경우)

      - case에 범위 연산자를 사용할수도 있고, where절을 사용하여 조건을 확장할 수 있다.

      - switch구문의 입력값으로 문자, 문자열, 열거형, 튜플, 범위, 패턴, 숫자 등 다양한 타입들을 사용 가능하다.

      ```swift
      let number: Int = 9
      switch number {
          case 0:
          	print("numer 0")
          case 1...10:
          	print("num 1...10")
          	fallthrough
          case Int.min..<0, 101..<Int.max:
          	print("number < 0 or nember > 100")
          default: 
          	print("10 < number <= 100")
      }
      
      //num 1...10
      //number < 0 or nember > 100
      
      let 
      ```


   3. 반복문

      1. for-in

         ```swift
         // 와일드카드 식별자 사용가능
         for _ in 1...3 {
         	print("print")
         }
         
         let hello = "hello"
         
         for char in hello.characters {
             print(char)
         }
         
         // 딕셔너리는 넘겨받는 값의 타입이 튜플로 지정되어 넘어온다
         let friends = ["jay": 20, "hun": 19]
         for tuple in friends {
         	print(tuple)
         } 
         // ("jay", 20)
         // ("hun", 19)
         ```
	- in 뒤의 범위는 Sequence면 다 가능
	- sequence: 어딘가에서 시작해서, 다음으로 넘어갈 수 있는것(계수가능범위)
		- ex) array, string...
	- Indices: 배열의 메서드
		- 모든 Index계수 가능 범위를 배열로 리턴
	- stribe(from:through:by:)
		- 셀수있는 범위를 생성(부동소수점 범위를 계수가능하게 해준다) `for in stribe(from: 0.5, through: 15.25, by: 0.3)`
		
      2. while 

         1. while
         2. Repeat-while (= do-while)

      3. 구문 이름표

         - 중첩된 반복문에서 반복문 앞에 이름을 지정하여 지정 구문을 제어할 수 있다.

           ```swift
           numbersLoop: for num in numbers {
               if num > 5 {
                   continue numbersLoop
               }
               
               var count: Int = 0
               
               printLoop: while true {
                   print(num)
                   count += 1
                   
                   if count == num {
                       break printLoop
                   } 
                   .....
           	}  
           }
           ```



	### 함수

*스위프트에서 함수는 일급 객체이기 때문에 하나의 값으로도 사용가능*

1. 매개변수 이름과 전달인자 레이블

   - `func 함수명(전달인자 레이블 매개변수 이름: 매개변수 타입)`
     함수 내에서는 매개변수 이름을 사용하고 함수를 호출할 때는 전달인자 레이블을 사용
     전달인자 레이블에  `_` 와일드 카드 식별자를 사용하면 전달인자 레이블을 사용하지 않을 수 있다.

2. 매개변수의 기본값

   - 스위프트 함수는 매개변수에 기본값을 지정할 수 있다. 

     ````swift
     func sunNumber(_ a: Int = 5, _ b: Int = 3) -> Int {
         return a + b
     }
     ````

3. 가변 매개변수

   - 0개 이상의 값을 받아올 수 있다.

   - 함수마다 가변 매개변수 1개만  가질 수 있다.

     ```swift
     func hello(me: String, freinds: String...) -> String {
         ...
     }
     hello(me: "Junyoung")
     hello(me: "Junyoung", freinds: "Mini", "Nahee")
     ```


4. 데이터 타입으로서의 함수

   ```swift
   typealias typeFunc = () -> ()
   
   func printNumber(_ number: Int, _ printFunc: typeFunc) {
       ...
   }
   
   func printNumber() -> typeFunc {
       ...
   } 
   ```

5. 중첩함수

   - 함수안에 함수를 넣을 수 있다.

6. 반환값을 무시하는 함수

   - @discardableResult: 반환값을 사용하지 않겠다.

     ```swift
     @discardResult func discardFunc(_ str: String) -> String {
     	print(str)
         return str
     }
     
     discardFunc("discardString") //discardString
     ```





### 옵셔널

*옵셔널과 옵셔널이 아닌 값은 완전히 다른 타입으로 인식한다.*

1. 옵셔널 추출

   1. 강제 추출: `!` 위험한 방법, 강제 추출 시 옵셔널 값이 없다면 런타임오류발생

   2. 옵셔널 바인딩

      - `if let ~`
      - `if var ~`
      - 쉼표를 통해 바인딩할 옵셔널들을 열거 할 수 있다.

      ```swift
      if let name = opName, let age = opAge {
          // if value is nil
      }
      ```
      - 옵셔널 체이닝: 옵셔널 상수나 변수 뒤에 `?` 를 붙여 표현

      ```swift
      class School {
      	var name: String
          var level: String? 
          
          init(name: String) {
      		self.name = name
          }
      }
      
      class Student {
      	var name: String
          var school: School?
          
          init(name: String) {
      		self.name = name
          }
      }
      
      let student = Student("Jun")
      // school프로퍼티가 nil이기 때문에 nil반환
      let studentSchool: String? = student.school?.name
      ```

      - 빠른종료: 핵심키워드 `guard`
        - 옵셔널 바인딩으로 사용이가능
        - `if let` 과 다르게 구문 밖에서도 변수를 사용할 수 있다.

   3. 암시적 추출 옵서녈

      - 암시적 추출 옵셔널은 선언할 때 느낌표를 사용

      - 암시적 추출 옵셔널로 지정된 타입은 일반 값처럼 사용할 수 있으나, 옵셔널이기 때문에 nil을 할당할 수 있다.

        그러나 nil로 할당된 경우 접근을 시도하면 런타임 오류 발생
