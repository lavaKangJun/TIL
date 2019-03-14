## 운영체제

### 1. 프로세스

- 프로그램: 

  - 디스크에 저장된 실행가능한 파일
  - 프로그램 클릭하면 인스턴스 생성

- 프로세스: 

  - 실행중인 프로그램의 인스턴스
  - 프로세스는 독립적
  - 프로세스마다 메모리 공간을 가지고 있음
    (가상메모리를 통해 실제 메모리를 다 사용하는 것 처럼 느끼게 해준다.)

- 프로세서(CPU): 

  - 프로그램을 메모리로부터 읽어들여 프로그램이 명령하는 대로 명령을 실행하는 하드웨어
  - CPU에는 2개의 Addredd 버스가 존재
    - Virtual address 버스
    - Physical address 버스

- 가상메모리

  **UserMode**

  - 코드영역

  - Static Data, Global 변수 영역

  - Heap 영역 [Dynamic Data]

  - Stack 영역 [Dynamic Data]

    - function이 들어감 (함수가 리턴되면 스택에서 pop)
    - 지역변수는 함수안에 존재하기 때문에 stack영역에 올라감 

  - UserCode 영역

    **KernelMode**

  - Kernel(code, data, stack, heap) 영역

    - 프로세스가 실행중일 때 OS가 필요한경우가 있기에 존재한다. 
      Ex) 인터럽트
      - 프로세스가 처음 실행될 때 UserMode로 들어가는 데 Systemcall을 하거나, 인터럽트, 익셉션이 발생, 프로세스가 끝나는 경우 커널모드로 들어감

- 변수

  - Life vs Scope

    - Life: 메모리 공간에 존재한다
    - Scope: 변수가 사용될 수 있는 범위
      지역변수는 함수내의 { } 안에가 Scope
      전역변수는 프로그램 전체가 Scope

- Program Counter

  - CPU의 레지스터 중 하나로 다음에 실행될 명령어의 주소를 가지고 있다.

- 문맥교환( = 프로세스 스위칭) 

  - 커널에 의해 실행

  - 문맥교환할 때 프로세스의 상태를 기억해야한다(다음 명령어 주소를 저장)

    -> 그래야 다음에 다시실행할 수 있음

  - Exception: 

    - 내부에서 발생하는 이벤트
    - 프로세스가 명령어 처리를 마치지 못하는 경우. Ex) Page fault 

  - Interrupt:  

    - 외부에서 발생하는 이벤트

  - Timeout

- Process Control Block (PCB)

  - 특정 프로세스에 대한 정보(processId(현재 processId, 부모 processId, 사용자 processId) , state, priority)를 
    관리
  - OS에 의해 만들어지고 관리된다.

- Two State Process Model

  - running 

    - Dispatcher에 의해 CPU할당 받으면 RunningState

      **Dispatcher: 커널안에 존재하는 스케줄러**

  - notrunning

  - ReadyQueue: Reay State의 프로세스가 저장

  - Pause: Interrupt, timer, I/O

  - Exit: 프로세스에 'exit systemcall' 하면 process 종료된다. 
  <img width="871" alt="스크린샷 2019-03-14 오후 10 03 18" src="https://user-images.githubusercontent.com/37703727/54361805-2b38b780-46ab-11e9-9f92-055cde2772ed.png">


- fork()

  - 새로운 (자식)프로세스 생성
  - 처음에는 부모 프로세스를 복사(COW)
  - fork()는 리턴이 2번 되는데 하나는 부모프로세스에, 하나는 자식프로세스에 리턴
    - Return 0 : child
    - Return child processId : parent
    - 부모와 자식은 다른 주소공간을 갖는다.
    - 부모에서 여러개의 자식 프로세스 fork() 가능

- exit(0)

  - 프로세스 종료

- Five - State - Process - Model

  - Event Wait:  보통 I/O 기다림

  - Event Occur : 이벤트 종료

  - Ready : 프로세스가 메인 메모리에 올라온 상태

  - BlockedQueue: BlockState 상태의 프로세스 저장


  	<img width="731" alt="스크린샷 2019-03-14 오후 10 11 36" src="https://user-images.githubusercontent.com/37703727/54361887-515e5780-46ab-11e9-90ca-b4b9326aed2a.png">
    <img width="522" alt="스크린샷 2019-03-14 오후 10 11 24" src="https://user-images.githubusercontent.com/37703727/54361936-6b983580-46ab-11e9-9615-9e3482aa37ff.png">


- Swapping

  - 메모리에 올라온, 지금 당장 쓰지 않는 프로세스들을 디스크(baking store)에 올려 놓는 것

    **backing store: 디스크내에 파일 시스템과는 별도로 존재하는 영역**

  - 스레싱(스와핑의 역 효과 )

    - 메모리 영역에 접근할 때 메모리안에 페이지의 부재율이 놓은 것

  - swap out : 메모리에서 디스크로

  - Swap in: 디스크에서 메모리로



- Seven - State - Process - Model (= Two Suspend State)

  - Suspend (= Swapping)

    <img width="667" alt="스크린샷 2019-03-14 오후 10 20 25" src="https://user-images.githubusercontent.com/37703727/54361978-7a7ee800-46ab-11e9-84bd-1ec56c7ffacf.png">

- Unix - State - Process - Model

  - 좀비상태: 더이상 실행 못하고, 메모리에도 못올라감.
    끝나긴 했는 데, 리소스가 남아있는 상태.
    부모가 거둬줘야 죽을 수 있음.

  - Preempted: Ready와 거의 동일

  - UserRunning: Usermode

  - KernelRunning: Kernelmode

    - kernelmode에서 kernel만을 위한 명령어가 존재함.

    <img width="678" alt="스크린샷 2019-03-14 오후 10 22 45" src="https://user-images.githubusercontent.com/37703727/54362003-87034080-46ab-11e9-9b6f-f58324089864.png">



- Exception
  - Traps: 
    - Intentional
    - Ex) systemcall, debug
    - return 후 다음명령어 실행
  - Faults:
    - unIntentional
    - 명령어 처리 못하는 경우
    - return 후 실행했던 그 명령어를 다시 실행
    - Ex) pageFault
  - Aborts: 
    - 복구불가능한 error 
    - 프로세스 중단시킴
- Interrupt:
  - INT: 무시할 수 있다.
  - NMI: 무시할 수 없는 인터럽트.
  - return 후 다음 명령어 실행
