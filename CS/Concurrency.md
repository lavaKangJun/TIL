## 운영체제

### *용어정리

**critical section: 한번에 한 프로세스만 사용**

**멀티테스킹 이유: CPU가 놀게하지 않기위해, 멀티테스킹이 가능하려면 메인 메모리 상에 프로세스가 적재되어 있어야 한다.**

### 3. Concurrency(동시성)

- Process Interaction
  -  자원을 이용할 때 프로세스간 경쟁에 의해 발생하는 문제
    - Mutual exclusion 보장 x
      - 오직 하나의 프로세스만 한 시점에 ciritical section에 들어가야하는 데 그렇지 못한 상태
    - DeadLock
      - 프로세스 간 서로의 자원을 무한정 기다리는 것
        - P1, P2가 각각 자기의 자원을 차지하고 있고 서로의 자원을 갖기를 기다리는 상태
    - Starvation
      - 잘못된 스케줄로 프로세스가 자원을 할당받지 못하는 상태
  - 자원을 이용할 때 프로세스간 협렵에 의해 발생하는 문제
    - race condition
      - 자원을 서로 같이 공유하다가 문제가 발생
        - 하나는 지우고, 하나는 삽입하는 연산일 때 원하지 않는 결과가 생성되는 상태



- Critical Section 문제 해결방법
  - CPU가 1개인 경우
    - Interrupt를 disable 시키고 Critical section에 들어감
    - Critical section이 끝나면 Interrupt를 able시킨다.
    - 이렇게 하면 Critical section에 있는동안 Interrupt(time out: time slice 다쓴 경우)를 받지 않음
  - CPU가 여러개(= Muti Core)인 경우
    - Automatic Instruction
      - 메모리에서 한번에 읽고 쓰는 것
      - Busy Wait 현상이 발생
  - Semaphore 
    - 큐가 존재한다.
      - 자원이 해제되면  큐에서 빼서 crictial section으로 이동
    - 사용한 리소스의 Count를 가지고 있다.
    - 두개의 Operation 존재
      - V operation (semaphore signal)
        - 세마포의 카운트가 1 증가
        - 자원에 대한 release
      - P operation (= semaphore wait) 
        - 세마포의 카운트 1 감소
        - 자원에 대한 요청
    - Strong / Weak Semaphore
      - Strong Semaphore
        - 세마포가 자원을 release 시켰을 때 FIFO으로 큐에서 나옴
      - Weak Semaphore
        - 세마포가 자원을 release 시켰을 때 아무거나 큐에서 뺀다.
    - Synchronization 지원
  - Monitor
    - 세마포의 단점(코드가 어렵다)을 해결하고자 나옴
      - Program language constructor 
        - 세마포와 동일한 기능을 하지만 사용하기는 더 쉽다.
    - Synchronization 지원
  - Message Passing
    - Synchronization
    - Mutual exclusion
    - communication
