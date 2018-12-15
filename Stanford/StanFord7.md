## StanFord Lec 7

1.  다른MVC를 뷰로 가지는 특수한 컨트롤러가 있다.
   1. UITabBarController(탭바의 탭이 5가 보다 많은 경우 더보기 버튼으로 나머지 버튼들을 보여준다.)
   2. UISplitViewController: master 와 detail 뷰를 가진다.
      1. master가 detail에 영향을 준다.
   3.  NavigationController: viewControllers: [UIViewController]? {get set}
      네비데게이션 컨트롤러에 연결되어있는 뷰들을 인덱스로 접근가능

2. UISplitViewController

   1. IPad에서만 잘 나타남 (화면크기 때문-> 아이폰8+ 는 IPad와 IPone의 중간이여서 스플릿뷰가 문제없이 나타남)

   2. iPhone에서는 보여지지 않을 수 있어 SplitView를 NaviCont 로 감싸서 사용

      - iPhone에서는 NaviCont로 iPad에서는 SplitView로 보여진다.

   3. SplitView로 감싼 Navi Scene들은 IPhone에서 볼 때 Master가 먼저 보여지는게 아니라

      Detail이 먼저 보여진다. [Apple의 정책]

      -> 하지만 SplitView의 Delegate로 Master가 먼저 보여지게 할 수 있다.

   4. `SplitView의 viewcontrollers`: Master 와 Detail을 갖는 배열 프로퍼티

3. Segue

   1. 항상 새로운 MVC를 만든다.

      1. 세그웨이는 향하고 있는 MVC를 잡은 뒤 포인터를 이용해서 계속 잡고있다.

         네비게이션스택을 벗어나더라도 힙을 벗어나지 않은채로 계속쥐고 있다

         -> 그 MVC를 재사용하려면 push해버리면 된다.

   2. 종류: 

      1. show segue
      2. show detail: 스플릿뷰에서 작동
      3. Modal segue: 화면 전체를 차지 
      4. Popover segue:  팝업

   3. prepare(for: sugeu)

      1. 새로운 mvc를 준비시킬 수 있는 유일한 방법
      2. `Segue.destination`은 viewcontroller타입이므로 원하는 뷰 컨트롤 타입으로 타입팅!

   4. shouldPerformSegue()

      1. 세그웨이가 되는 것을 막아줌

         함수결과가 거짓이면 세그웨이는 연결되지 않는다.

4. 콘솔창 명령어 `po`

   1. `po outletName` : 검색한 outlet의 상태가 나옴

5. Timer 

   1. weak로 선언: weak로 설정하면 타이머를 사용하지 않을 때는 Timer의 값이 nil로 변한다

      -> 따라서 타이머가 실행되고 있는 지 아닌 지 를 알 수 있다.

      1. 어떤 변수가 weak로 선언되었다면 아무도 이 변수를 향해 강한 포인터(강한참조)를 갖고있지 않는다.

         -> 참조 되지 않을 때 nil로 설정됨

   2. tolerance : 배터리를 효율적으로 사용가능

   3. Timer는 백그라운드에서 돌아가지 않지만 백그라운드로 완전히 바뀌기전 30초정도 사용가능

6. Animating : UIView Properties 

**궁금점**

delegate 설정하는 걸 왜 viewDidLoad에서 안하고 awakeFromNib()에서 할까?