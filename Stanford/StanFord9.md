## Lec 9



### Life Cycle

#### 1. 뷰 컨트롤러 생성

 	1. 세그준비  > 2. 아울렛 > 3. 뷰 컨트롤러 화면에 나타남





#### 2. Life Cycle Method

<!--*생명주기 메서드: super.LifeCycleMethod()꼭 해주기!-->

1. `viewDidLoad`:
   1. 초기화 하기 좋은 메서드

   2. 모든것이 준비되고 아울렛 설정 뒤 한번만 불림

   3. viewDidLoad()가 실행 될 때 경계는 아직 지정되지 않았기 때문에 기하변경(화면크기) 메서드 넣지말라

      - 어떤 기기인지 확인하고 맞춰 놓기 전 이기 때문

2. `viewWillAppear`

   1. 모델의 모든 정보를 뷰에 로드 (여러번 불릴 수 있다.)
   2. 변경된 모델(ex.DB내용) 내용 업데이트하기 좋은 메서드

3. `viewDidAppear`

   1. 뷰가 다 그려진 후에 호출.
   2. 애니메이션, GPS, 자이로 위치 시작하기 좋은 장소 .
   3. 비용이 큰 작업을 시작하기 좋음 > 백그라운드에서 돌려야한다. (Ex. 네트워크에서 고화질 이미지 가져오는 경우)

4. `viewWillDisappear`

   1. viewDidAppear에서 했던 작업들(사라질 것을 확신하는 것들)을 그대로 되돌리기 좋은 메서드

5. `viewDidDisappear`

   1. 완전히 사라졌을 때 호출
   2. MVC 정리

6. 기하설정할 메서드 [`viewWillLayoutSubviews`,  `viewDidLayoutSubviews`]

   1. 최상의 뷰(self.view)의 경계가 바뀔 때 마다 호출(경계가 바뀌지 않아도 뷰가 잘 놓여져 있는 지 확인하기 위해 호출되기도 한다.)
      - 자주호출됨
   2. **그러나** *AutoLayout* 때문에 잘 사용하지 않음

7. LowMemory: `didReceiveMemoryWarning`
   1. 비디오, 이미지, 음악파일 사용하는 경우에만 신경쓰면 된다.
   2. 메모리 누수가 심하면 강제 종료됨
8. `awakeFromNib`
   1. 초기화 다음 세그웨이 준비 전 , 아울렛 연결 전에 호출
   2. 스토리보드에서 나온 객체 (모든 UI뷰와 뷰 컨트롤러)는 awakeFromNib으로 호출된다.
   3. 정말 일찍 구현해야 하는 경우를 제외하고 사용하지 않는 것을 추천


​       

### Scrollview

1. 이동, 확대할 수 있는 뷰
2. `contentSize` : *scrollview*에서 필수로 설정해 줘야한다.
   - 스크롤할 수 있는 영역의 크기 지정
3. `contentOffset`
   - scrollview가 표시하는 왼쪽 위 코너의 x, y좌표
4. `flashScrollIndicator`: 
   - scrollview를 처음 나타낼 때 스크롤을 반짝 보여줘서 스크롤이 가능하다는 것을 알려줌
5. Zooming
   - ContentSize에 영향을 준다.
     - 확대하면 Content 영역도 같이 커진다.
   - minimumZoomScale
   - maximumZoomScale
   - `viewForZooming`: 어느 서브뷰를 확대/축소할 것인지를 리턴
   - zoomScale
   - zoomToRect: 사각형 크기에 맞춰서 확대 축소
   - `scrollViewDidEndZooming`: zooming 끝난다음에 호출
     - 이 메서드 안에서 손을 떼는 순간 날렵하게 이미지를 다시그려 이미지 화질을 보정하는 코드를 자주 사용함



### 오류 처리

#### Try

1. Try? 
   - try로 받는 값은 오류가 발생하면 옵셔널이 된다 (nil이되기 때문)
2. do{try} catch(error){}
   - 오류처리 해줌
3. try!
   - 오류 발생하면 런타임 오류 발생



### ImageView

**인터페이스 빌더에서 Intrinsic 의미** 

- Placeholder: 이미지뷰에 크기가 생기고, 실행하는 순간 우리가 어떤 이미지를 쓰는지에 따라 실제 크기가 달라짐 (임시로 크기 지정) 
  - 코드에서 `imageView.sizeToFit()` 이 같은 의미