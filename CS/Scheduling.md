## 운영체제

### *용어정리

**scheduling: 시스템 리소스를 스레드, 프로세스에 할당 시키는 것**

### 5. Scheduling(단일 프로세서 스케줄링)

- Long Term Scheduling

  - New <-> Ready Queue
  - 어떤 프로세스를 Reay Queue에 넣을 것인가
  -  어떤 프로세스를 먼저?
    - Priority, FCFS ...

- Mid Term Scheduling

  - Suspend <-> Blocked, Ready Queue
  - Swapper
    - Swap In, Swap Out

- Shot Tmer Scheduling

  - ReadyQueue <-> Running
  - CPU Scheduler or Dispatcher
  - 어떤 프로세스를 먼저?
    - Response time, priority...

- Scheduling Policy

  - PriorityQueue

    - Starvation 문제 발생
    - 우선순위에 따라 Queue 생성

  - FCFS

    - 들어온 순서대로 서비스
      - 짧은 프로세스인 경우 들어온 순서대로 기다려야하기 때문에부적절

  - RoundRobin

    - timeslice만큼 실행
    - Valance 있게 실행된다.
    - Virtual RR

      - I/O 작업들도 문제 없이 잘 실행시키기 위해 고안
    - SPN(SJF)

      - NonPreemptive
      - 짧은 job 먼저 실행
      - Starvation 문제 발생
    - SRT

      - Preempvite

        - 작업 실행중에 새로 들어온 작업과 실행중인 작업의 나머지 작업을 비교해서 더 짧은 작업을 실행
      - 짧은 job을 먼저 실행
      - Starvation 문제 발생
    - HRRN
      - 대기한 시간 + 서비스실행 시간 이 큰 값 먼저 실행
    - Feedback Scheduling(= Muti Level Feedback Queue)
      - 우선순위가 있는 Queue를 생성
      - 프로세스들이 timeslice 단위의 작업을 마치면 그 다음 Queue에 들어감 ... 계속 반복
        - 작업이 긴 프로세스들은 Starvation이 발생할 수 있다.
    - Fair Share Scheduling
      - Process 별로 작업하지 않고, 사용자 별(그룹별)로 스케줄링 하겠다.
        - 서버에서 사용된다.



