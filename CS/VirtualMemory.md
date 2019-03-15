## 운영체제

### *용어정리

**버스: 전기적통로 (데이터버스(실자료 교환), 주소버스(주소만 교환), 제어버스 존재)**

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
  - 작지만 빠른 메모리
  - CPU와 Main Memory 사이에 존재
  - Benefits
    - bus traffic을 줄여준다.
    - load, store할 때 빠르다.