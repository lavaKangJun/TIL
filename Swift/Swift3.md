## Swift 문법 3

### 클로저

**코드를 하나의 블록으로 모아놓은 것 따라서 함수는 클로저의 한 형태**

1. 기본 클로저

2. 후행 클로저

   - 맨 마지막 전달인자로 전달되는 클로저에만 해당된다.
   - 단 하나의 클로저만 전달인자로 전달하는 경우에도 소괄호를 생략할 수 있다.

3. 클로저의 값 **Capture**

   - 클로저는 자신이 정의된 위치의 주변 문맥을 통해 상수나 변수를 캡쳐할 수 있다.
   - 클로저를 통해 비동기 콜백을 작성하는 경우, 현재 상태를 미리 획득해주지 않으면, 실제도 클로저의 기능을 실행하는 순간에는 주변의 상수나 변수가 이미 메모리에 존재하지 않는 경우가 발생한다.

4. 클로저는 참조 타입이다.

   - 함수나 클로저를 상수나 변수에 할당할 때마다 사실은 상수나 변수에 함수나 클로저의 참조를 설정하는 것이다. 

   ```swift
   func makeIncrementer(forIncrement amount: Int ) -> (() -> Int) {
       var sumTotal = 0
       func increment() -> Int {
   		sumtotal += amount
           return sumTotal
       }
       return increment
   }
   
   let incrementNum: (() -> Int) = makeIncrement(amount: 2)
   let sameIncrementNum: (() -> Int ) = incrementNum
   // 값 캡쳐
   let first: Int = incrementNum() // 2
   let second: Int =  incrementNum()  // 4
   let third: Int =  incrementNum()  // 6
   
   // 참조 타입
   let fourth: Int = sameIncrementNum() // 8
   ```

5. 탈출 클로저 `@escaping`
   - 함수의 전달인자로 전달한 클로저가 함수 종료 후에 호출될 때 클로저가 함수를 탈출한다.
   - Completion handler에 많이 사용됨

### 빠른종료: guard

**guard뒤에 따라붙는 코드의 실행결과가 true일때 코드가 계속 실행되고, false이면 else 블럭 코드를 실행한다.**
**else 블럭 내부에는 종료하는 코드가 들어가 있다.**

```swift
guard Bool 타입 값 else {
    예외사항 실행문
    제어문 전환 명령어 (return, break, continue, throw)
}
```

1. guard구문을 사용하는 이유

   - if 구문을 사용하면 예외사항을 else 블럭으로 처리해야 하지만 예외사항만을 처리하고 싶으면 guard구문을 사용하는 것이 훨씬 간편 
   - 옵셔널 바인딩

   ```swift
   // 옵셔널 바인딩과 조건물을 사용한 guard문 
   func guardExmple(name: String?, age: Int?) {
       guard let name = name , let age = age, age > 19 else {
           return
       }
   }
   ```

### Map 

*맵은 자신을 호출할 때 매개변수로 전달된 함수를 실행하여 그 결과를 다시 반환해주는 함수입니다.*

맵은 Seguence, Collection 프로토콜을 따르는 타입과 옵셔널은 모두 맵을 사용가능하다.

맵은 컨테이너가 담고있는 각각의 값을 매개변수를 통해 받은 함수에 적용한 후 다시 컨체이너에 포장해서 반환한다.

기존 컨테이너의 값은 변경되지 않고 새로운 컨테이너가 생성되어 반환된다. 그래서 **기존 데이터를 변형** 하는데 많이 사용.

```swift
let strings: [String] = []
let doubleNumbers: [Int] = []

let numbers: [Int] = [1, 2, 3, 4]

doubleNumbers = numbers.map({ return $0 * 2}) // 2,4,6,8
strings = numbers.map { "\($0)"} // "1", "2", "3", "4"

// 다양한 컨테이너 타입에서 맵의 활용
let stringDictionary: [String: String] = ["a" : "A", "b", "B"]
var key: [String] = stringDictionary.map { $0.0 } // "a", "b"
let value: [String] = stringDictionary.map { $0.1 } // "A", "B"

let intSet: Set<Int> = [1, 2, 3, 4]
let setResult = intSet.map { $0*2 } // 2, 4, 6, 8

let rangeInt: CountableClosedRange = (0...3)
let rangeResult: [Int]  = rangeInt.map { $0*2 } // 0, 2, 4, 6
```



### Filter

*컨테이너 내부의 값을 걸러서 추출(특정 조건에 맞게 걸러내는)하는 역할을 하는 고차함수*

맵과 마찬가지로 새로운 컨테이너에 값을 담아 반환.

Filter 함수의 매개변수로 전달되는 함수의 반환 타입은 Bool.

```swift
let numbers: [Int] = [0, 1, 2, 3, 4]
let evenNumbers = numbers.filter { $0 % 2 == 0 } // 0, 2, 4
let oddNumbers = numbers.filter { $0 % 2 != 0 } // 1, 3 
```



### Reduce