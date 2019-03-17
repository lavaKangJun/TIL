## 운영체제

### 6. File System

- File

  - 관련 정보를 이름으로 저장
  - 디스크에 저장
  - OS는 저장 장치를 file이라는 논리적 단위로 저장
  - Operation
    - Open, Close, Create, Read ...

- File Attribute

  - 파일에는 파일을 관리하기 위한 정보들(meta data)도 들어가 있다.

- Directory

  - 디렉토리도 하나의 파일
  - 디렉토리에 속한 파일 이름, 속성들을 포함

- Partition (= Logical Disk)

  - 하나의 물리적 디스크에 여러개의 파티션을 두는 게 일반적
  - 각각의 파티션을 다른 용도로 사용한다
    - Backing Store, File System

- Operation

  - open()	
    - 파일에 대한 meta data가 main memory에 올라감

- File Protection

  - Read/write/execution

  - Access control

    - Access Control Matrix

      - 배열 형태로 access 정보 관리

    - Grouping

      - user를 owner, group, public 세 그룹으로 구분

      - 각 파일에 대해 세 그룹에 대한 접근 권한을 3 비트씩 표현
      - Rex r-- r-- [owner, group, public]

    - Password

      - 접근 권한별 password

- 파일 접근 방식

  - 순차접근
    - 카세트 테이프와 같은 방식
      - b로 가기 위해서 a를 거쳐야함
  - 직접접근
    - 바로 접근
      - b로 바로 접근

- Allocation of file data in disk

  - Contiguous Allocation (연속할당)
    - 디렉토리에 file의 시작위치와 length저장
    - 단점
      - 파일의 크기를 키우는 데 제한
       - 연속할당이기 때문에 뒤에 다른 파일들이 있어서 다른 파일들을 추가할 때 연속할당 되어있으면  빈 공간에 넣기 힘들다.
    - 장점 
      - 빠른 I/O
      - 직접 접근 가능
      - 한번의 seek로 많은 데이터를 가져올 수 있다.
    - 활용
      - Process의 Swapping
  - Linked Allocation
    - 디렉토리에 file의 시작위치와 끝 위치만 보여줌
    - 빈 위치 아무곳
    - sector에 가면 다음 위치를 저장하고 있다.
    - 단점
      - 순차 접근만 가능
      - 하나의 sector가 babsector가 되면 그 뒤에 정보 다 유실
    - 변형
      - File Allocation Table(FAT)
  - Indexed Allocation
    - 디렉토리에 indexblock 위치 저장
    - 각 섹터의 index를 담은 block이 존재
    - 장점
      - 직접 접근 가능
    - 단점
      - 작은 파일일 경우 공간 낭비
        - 실제 Data block 과 index block 둘다 필요하기 때문에
      - 너무 큰 파일인 경우 Index block 하나로 부족
        - 해결방법: Index block 의 마지막 값을 다음 Index block의 위치를 저장

- Unix 파일 시스템

  ![스크린샷 2019-03-17 오후 8.46.40](/Users/kangjun-young/Desktop/스크린샷 2019-03-17 오후 8.46.40.png)

  - 어느 시스템이든 disk의 첫번 째 block은 boot block
    - 부팅에 대한 정보를 가지고 있다
    - 시스템이 켜졌을 때 boot block(bootstrap loader)을 메모리에 올림 -> OS의 커널 위치를 찾아서 실행
  - Super block
    - 파일 시스템에 관한 총체적 정보
  - Inode(Index node) list
    - 파일 이름을 제외한 피일의 모든 meta data 정보가 담겨져 있다.
  - Data block
    - 파일의 실제 내용이 담겨져 있다.

- FAT 파일 시스템

  ![스크린샷 2019-03-17 오후 8.46.47](/Users/kangjun-young/Desktop/스크린샷 2019-03-17 오후 8.46.47.png)

  - FAT
    -  Sector의 다음 위치 저장
      - 데이터 유실 위험 x
  - Root directory
  - Data block

- Free Space Management

  - 빈 블럭을 어떻게 관리 하나?
  - Bit Map or Bit Vector
    - 연속적인 n개의 free block을 찾기 좋음
    - 0 - block[i] free
    - 1 - block[i] used
  - Free spca list
    -  비어있는 블럭을 리스트로 관리
  - Grouping
    - 첫번째 block에 비어있는 block list 정보를 담고 그다음 block 에 ...
  - Counting
    - 빈블럭의 위치와 그 위치에서 연속적으로 몇개가 빈 블럭인 지 저장

- Directory Implementation

  - Linear List
  - Hash Table

- VFS and NFS

  - VFS
    -  서로다른 파일에 대해 동일한 API를 통해 접근할 수 있게 해주는 OS Layer
  - NFS
    - 분산 환경에서 파일 공유 되도록

- Page Cache and Buffer Cache

  - Page Cache
    - Page System에서 사용하는 Perform을 Caching
  - Buffer Cache
    - 캐쉬 단위 sector, block
    - 파일시스템을 통한 I/O 연산 은 메모리의 특정영역인 buffer cache 사용
      - Locality 사용
        - LFU, LRU 알고리즘 사용
