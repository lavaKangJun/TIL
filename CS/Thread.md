## 운영체제

### * 용어정리

**시그널: 프로세스간 통신을 하기위한 메커니즘**

### 2. Thread

- 스레드

  - 한 프로세스안에는 여러개의 스레드가 존재한다(멀티 스레드)
  - 각각 독립적인 성질을 가지고 있다.
  - 스레드 별로 스케줄링한다
    - 스레드가 프로세스보다 가볍기 때문에 스케줄링을 프로세스단위로 하지않고 스레드 단위로 하는 게 더 효율적임.
      - 스레드 단위로 스케줄링이 되면 스레드가 Blocked되면 같은 프로세스안의 다른 스레드들은 running될 수 있다. 따라서 프로세스가 Blocked되지 않는다.
    - 자원은 프로세스단위로 
  - 스레드는 주소공간(가상메모리)을 공유하고, 프로세스 자원을 공유한다.
  - 스레드에서는 Suspend(Swapping) 개념이 존재하지 않음 (프로세스만 해당)
  - 각 스레드는 TCB와 Excution Stack을 갖는다.
    - TCB(Thread Control Block)
      - Tread Context: register value(pc, stack pointer)
      - Thread State, Priority....
    - Excution Stack
      - User Stack
      - Kernel Stack
- 멀티스레드

  - OS가 Support (CPU가 지원하는 멀티스레딩도 있는데 성질이 조금 다름)
  - User Level Thread
  - Cocurrent paths of execution within a single process
  - 멀티 프로세스안에 멀티 스레드
- 스레드의 상태
  - Ready
  - Run
  - Blocked
- 스레드의 장점
  - 프로세스를 생성(fork())하는 것 보다 스레드 생성이 더 빠르다.
  - 스레드는 종료도 빠르다.
  - 스레드간 커뮤니 케이션도 빠르다.

- User Level Thread
  - OS Thread와 별개로 사용자가 만들 수 있는 스레드
  - 하나의 어플리케이션에서 관리된다.
  - OS단에서는 프로세스 하나가 실행되는 것처럼 느껴짐 -> OS User Level Threa가 실행되는 지 모름
- User Level Thread 장점
  - Kernel의 영향을 받지 않는다. -> 빠르게 Switching된다.
  - App에 특화된 스케줄러가 사용된다.
- User Level Thread 단점
  - User Level Thread가 system call 하면 thread만 blocked되는게 아니라 프로세스 전체가 blocked되어버림
  - OS가 멀티스레드의 장점을 이용하지 못함.
- Thread State와Process State는 완전 독립적
  - Process State가 Blocked 되도 Thread는 Running 중일 수 있다.
- Kernel Level Thread 장점
  - 한 프로세스내의 여러개의 스레드를 각각 CPU에 할당할 수 있다.
    - 한 스레드가 Blocked 되더라도 다른 스레드는 Blocked되지 않는다.
    - OS도 멀티스레드를 사용할 수 있게되어 성능 향상된다.
- Kernel Level Thread 단점
  - Kernel 레벨의 스레드를 Support하려면 오버헤드가 커진다.
- Combined Approach
  - User Level Thread + Kernel Level Thread 
  - Ex) Solaris

