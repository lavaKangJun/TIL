## 운영체제

### *용어정리

**버스: 전기적통로 (데이터버스(실자료 교환), 주소버스(주소만 교환), 제어버스 존재)**

**MMU: TLB 캐시를 저장하고 있다.**

### 4. Virtual Memory

- Address
  - Logical Address
    - = Virtual Address
  - Relative Address
    - page와 segment안에서 상대적인 위치
  - Physical Address
    - 실제 메모리 주소

- Paging
  - 가상메모리와 Physical 메모리에서 둘다 사용
  - 메모리를 같은 크기의 페이지 단위로 잘라 놓은 것 -> page frames
  - 프로세스 이미지를 페이지 단위로 잘라 놓음 -> pages
  - page table
    - virtual address와 physical address를 연결하기 위해서 필요
    - cpu가 실제 주로(physical address)를 알기 위해 page table에 접근한다.
    - [logical address] -> [page table] -> [physical address]

- Segment
  - 페이지 처럼 고정된 크기가 아니라 natural size (Logical한 Segment들의 사이즈로 잘라짐)
  - Segment table
    - segment address  = segment number + offset
    - [logical address] -> [segment table] -> [physical address]

- Memory Hierarchy
  - locality
    - Spatial Locality
      -  데이터나 명령어를 가져올 때 그 주변까지 한번에 가져오는 것
        - Why? 한번 접근한 데이터나 명령어 주변에서 다음 접근이 일어날 확률이 매우 크기 때문에
    - Temporal Locality
      - 한번 사용한 명령어, 데이터 저장해 놓는것 (= Cache)

- Level Memory Hierarchy
  - Register
  - Cache
  - Main Memory (Disk에서 page 단위로 프로세스 가져옴)
  - Disk

- Cache

  - SRAM
  - register와 main memory사이에서 속도차이 극복
  - Main memory에서 cache block, cache line 단위로 가져옴
  - 작지만 빠른 메모리
  - CPU와 Main Memory 사이에 존재
  - Benefits
    - bus traffic을 줄여준다.
    - load, store할 때 빠르다.

- Cache Block Replacement

  - LRU(Least recently used)
    - access할 때 timestamp를 찍고 가장 오래된 것을 쫓아냄
  - Pseudo LRU
    - Reference bit를 두고 access되면 1로 마크 -> 주기적으로 bit 모두를 0으로 reset -> 쫓아낼 때는 0 인것만 쫓아냄(bit 1 은 최근에 access된 것이기 때문에)
  - Random

- Cache miss

  - Cold - Start - Misses

    - 처음 access 하는 block은 캐시에 존재하지 않음 (어쩔 수 없는 현상)


  - Capacity - Misses

    - 용량 때문에 쫓아내야 하는 현상

  - Conflict - Misses

  - Invalidtion - Misses

- Virtual Memory / Virtual Address 

  - Virtual Address = 데이터 주소 + 명령어 주소
  - Virtual Memory
    - 프로그래머가 생각하는 메모리
    - Process 마다 고유의 VM을 갖는다.
    - VM을 사용하면 PM의 용량을 신경쓰지 않아도 된다.
      - 프로그램의 크기가 PM 크기보다 커도됨.
  - Physical Memory
    - 캐시와 DRAM에 Access 할 때만 사용
  - Memory Allocation
  - Memory Deallocation
    - LRU
  - Memory Mapping
    - TLB(MMU) 를 통해 이루어짐
    - 주소 바인딩
      - 논리적 주소를 물리적 주소로 바꾸는 것

 - TLB 
    - Page Table Entity(PTE) Cache
    - Virtual Address -> Physical Address

  - Virtual Memory Faults
    - Exception Faults에 해당
      - 다음에 다시 같은 명령어를 실행함
    - TLB miss
      - PTE not in TLB
    - PTE miss
      - PTE not in main memory
    - Page miss
      - page not in main memory

  - Page Size
    - Page Size 클때 장점
      - page size가 커야 디스크에서 I/O 할 때 한번에 많이 가져올 수 있다.
    - Page Size 작을 때 단점
      - Page Table 커짐

  - Paged Segment
    - 기본적으로 segment system
    - 프로세스들은 segment 단위로 잘라지지만
    - 각 segment들은 page로 관리된다.
    - [virtual address] -> [segment table] -> [page table] ->[main memory]

  - Virtual Memory Policy 
    - Fetch Policy
      - Demaing paging - page miss 날 때 Fetch
        - 처음 시작할 때는 page fault가 높게 지만, locality 때문에 page 가 점점들어오면서 page fault가 줄어든다.
      - Prepaging - 미리 가져옴 (불필요한 페이지가 들어올 수 있다.)
    - Placement policy
      - 어디든 가능
    - Replacement Ploicy
      - LRU
        - 오랫동안 사용되지 않은 페이지 교체
      - FIFO
      - Frame Locking
        - Replacement 알고리즘이 page를 쫓아낼 때 고려하지 않음
        - 커널이 사용하는 페이지들은 쫓아내선 안되기 때문에 Locking이 걸림

  - Replacement Algorithm
    - 아래의 순서대로 성능이 좋음
    - Optimal
      - 미래에 사용되지 않을 페이지를 쫓아냄
    - LRU
      - 오랫동안 사용되지 않은 페이지를 쫓아냄
    - Clock
      - use bit 를 사용
        - Reference 되면 user bit 1로 set -> 한 사이클 뒤에 use bit를 0으로 set -> 다시 한 사이클 뒤에
           user bit 가 0 이면 쫓아냄
    - FIFO
      - 오래된거 쫓아냄

  - Page Buffering


      - page 쫓아낼 때 바로 쫓아내지 않고 큐에 넣고 대기시킴
      - free page list

          - clean page 관리하는 queue

              - clean page가 쫓겨나면 이 queue로 들어옴
          - Page가 access 되면 queue에서 지워줌
      - Modified page list

          - Dirty page들을 디스크에 반영해 줘야하기 때문에 queue에 넣고 한번에 디스크에 저장

- Working Set


    - 한 프로세스가 현재 시점에서 사용하는 page들의 집합
    - Working Set Management

        - Fixed allocation

            - 할당할 frame 수 고정
        - Variable allocation

            - 프로세스의 Life time에 따라서 그때 그때 프로세스에 필요한 Working Set 조절

                - Page fault를 참고해서 Page fault가 많이 발생하면 Working Set을 키우고 아닌경우는 작게함
    - Replacement Scope

        - Global scope

            - 전체에서 replace될 page 선택
        - Local scope

            - 프로세스안에서 replace될 page 선택

- Cleaning Policy


    - Modified page는 반드시 디스크에 써져야 한다.
    - Demading cleaning

        - 메모리에서 쫓겨나기 전에 cleaning
    - Precleaning

        - 쫓겨나기전에 미리 cleaning

- Multiprogramming


    - 프로세스가 너무 많으면  각 프로세스가 갖는 woking set이 작아져 Thrashing(페이지의 부재율이 높은 것) 발생
    - 프로세스가 너무 적으면 CPU가 놀게된다.

- Process Suspend


    - Lowest - Priority - Process

    - Faulting Process


        - Page fault가 자주 발생하는 process를 suspend

            - Working set이 충분하지 못하다는 의미기 때문에

    - Last Process activated


        - 마지막에 들어온 건 working set 이 충분하지 못할 가능성이 높기 때문

    - Working Set이 가장 작은 Process


        - 나중에 재 로드할 때 부담이 적기 때문에

    - Largest Process 


        - 가장 큰 프로세스 지우면 가장 많은 프레임을 남겨놓기 때문에

    - 실행시간이 가장 많이 남은 Process


        - 짧은 것 먼저 실행시키기 위해
