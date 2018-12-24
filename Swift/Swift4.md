## Swift 문법4

### 서브스크립트

*컬렉션, 리스트, 시퀀스 등 타입요소에 접근하는 단축 문법 -> 인덱스를 사용하여 값을 설정하거나 가져올 수 있다.*

1. get, set을 사용하여 구현함

2. 서브스크립트를 복수로 구현 가능하다.

   ```swift
   struct Student {
   	var name: String
       var number: Int
   }
   
   class School {
       var number: Int = 0
       var students: [Students] = []
    	
       func addStudent(name: String) {
   		let student: Student = Student(name: name, number: self.number)
           self.students.append(student)
           self.number += 1
       }
       
       subscript(index: Int) -> Student? {
           get{
               if index < self.number {
   				return self.student[index]
               }
               return nil
           }
           set {
               guard var newStudent: Student = newValue else {
                   return
               }
               var number: Int = index
               
               if index > self.number {
   				number = self.number
                   self.number += 1
               }
               
               newStudent.number = number
               self.students[number] = newStudent
           }
       }
       
       subscript(name: String) -> Int? {
           get{
               return self.students.filter{ $0.name == name}.first?.number
           }
           set{
               guard var number: Int = newValue else {
                   return
               }
               
               if number > self.number {
                   number = self.number
                   self.number += 1
               }
               
               let newStudent = Student(name: name, number: number)
               self.students[number] = newStudent
           }
       }
   }
   ```


### 상속

*상속은 스위프트의 다른 타입과 클래스를 구별짓는 클래스만의 특징*

1. 부모클래스에서 연산 프로퍼티로 정의한 프러퍼티든 저장 프로퍼티로 정의한 프로퍼티든 자식 클래스에서는 프로퍼티 감시자를 구현할 수 있다.

2. 재정의

   - 프로퍼티를 자식 클래스에서 용도에 맞게 재정의할 수 있다. 그러나 저장 프로퍼티로 재정의 할 수 없다.
   - 프로퍼티 감시자도 재정의가 가능하지만 조상클래스에 정의한 프로퍼티 감시자도 동작한다.
   - 서브스크립트도 재정의 가능

3. 재정의 방지

   - 재정의를 방지하고 싶은 특성 앞에 final 키워드를 명시하면 된다.
   - 클래스 자체를 상속하거나 재정의할 수 없도록 하고 싶다면 class 키워드 앞에 final 키워드를 명시해 주면 된다.

4. 클래스의 이니셜라이져

   1. 지정 이니셜라이저

      - 필요에 따라 부모 클래스의 이니셜라이저를 호출할 수 있다.

      - 이니셜라이저가 정의된 클래스의 모든 프로퍼티를 초기화해야하는 임무를 갖고 있다.

   2. 편의 이니셜라이저 `convenience`

      - 지정 이니셜라이저를 자신 내부에서 호출한다.
      - 자식클래스에서는 부모클래스의 편의 이니셜라이저는 호출할 수 없다.

   3. 지정 이니셜라이저와 편의 이니셜라이저의 관계

      1. 자식클래스의 지정 이니셜라이저는 부모의 지정 이니셜라이저를 반드시 호출한다.
      2. 편의 이니셜라이저는 자신을 정의한 클래스의 다른 이니셜라이저를 반드시 호출한다.
      3. 편의 이니셜라이저는 궁극적으로 저정 이니셜라이저를 반드시 호출해야 한다.

   4. 이니셜라이저 자동 상속

      1. 자식클래스에서 프로퍼티 기본값을 모두 제공한다고 가정할때, 다음 두가지 규칙에 따라 이니셜라이저가 자동 상속된다.
         1. 자식클래스에서 별도의 지정 이니셜라이저를 구현하지 않는다면, 부모클래스의 지정 이니셜라이저가 자동으로 상속된다.
         2. 자식클래스에서 부모클래스의 지정 이니셜라이저를 자동으로 상속받은 경우 또는 부모클래스의 지정 이니셜라이저를 모두 재정의하여 부모클래스와 동일한 지정 이니셜라이저를 모두 사용할 수 있는 상황이라면 부모클래스의 편의 이니셜라이저가 모두 자동으로 상속된다.

   5. 요구 이니셜라이저 `required`

      *클래스 이니셜라이저 앞에 required를 명시해 주면 이 클래스를 상속받은 자식클래스에서 반드시 해당 이니셜라이저를 구현해 주어야한다. 재정의 할 때도 reguired를 명시해 준다.*



### 타입캐스팅

*스위프트의 타입캐스팅은 인스턴스의 타입을 확인하거나 자신을 다른 타입의 인스턴스인양 행세할 수 있는 방법으로 사용된다.*

1. `is` 데이터 타입 확인

   - is 를 사용하여 인스턴스가 어떤 클래스의 인스턴스인지 타입을 확인해볼 수 있다.

2. `as` 다운캐스팅

   부모클래스 타입을 자식클래스 타입으로 캐스팅

   *캐스팅은 실제로 인스턴스를 수정하거나 값을 변경하는 작업이 아니다. 인스턴스는 메모리에 똑같이 남아 있고, 다만 인스턴스를 사용할 때 어떤 타입으로 다루고 어떤 타입으로 접근해야 할지 판단할 수 있도록 컴퓨터에 힌트를 주는 것*

   1. as? : 다운캐스팅에 실패한 경우 nil 반환
   2. as! : 다운캐스팅에 실패한 경우 런타임 오류발생
      - 다운캐스팅에 성공한 경우 옵셔널이 아닌 인스턴스가 반환 된다.

3. Any, AnyObject의 타입캐스팅

   - Any, AnyObject로 전달받은 데이터가 어떤 타입인지 확인하고 사용해야 한다.

     *타입캐스팅 필수!*

