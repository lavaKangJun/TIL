## StanFord Lec 6

**1. Enum**

1. Enum의 type을 지정해주면 swift는 값을 자동으로 할당해 준다.
   1. String은 각 케이스의 문자열을 원시값으로 갖는다. 

**2. switch**

1. where 절과 함께 패턴을 매칭해서 사용 (where을 쓸 때 default 꼭 추가해야 함)

**3. UIView**

1. Cocoa Touch, UIKit의 서브뷰

2. draw(Rect) : UIView를 상속한 소스에서 draw(Rect)가 있는지  iOS가 확인한다
   소스안에 draw(Rect)가 있으면 화면밖에 버퍼를 만들고 드로잉을 할 준비를 한다.[가벼운 작업이아님]
   따라서 draw(Rect)하지 않는다면 소스를 주석처리하라

   1. draw() 메서드는 직접 호출할 수 없다. 
      그대신 `setNeedsDisplay()`를 사용.
      서브뷰 재 배치를 하기 위해선 `setNeedsLayout()`을 사용

3. 코어그래픽스를 사용하여 드로잉하려면 context가 필수 <-> context대신 UIBezierPath 사용가능

   ````swift
   var context: Context
   context.strokePath() // 경로를 없애가며 그린다.
   context.fillPath() // 그래서 fillPath()를 실행할때는 경로가 없어져 버려 실행할 수 없게된다.
   
   var path: UIBezierPath
   path.stroke() //그린후에 경로가 남아있어 채우기가 가능하다. (경로가 남아있다는 말은 경로를 움직이거나 크기를 줄어서 다시 그릴 수 있다 -> 경로애 계속 곡선을 그릴 수 있다.)
   path.fill()
   
   addClip() // 이 테두리안에만 그리겠다.
   ````

   1. 현재 그리고 있는 영역을 알려주는 직사각형: Bounds 
      1. 현재영역의 가운데: bounds.mid.x, bounds.mid.y
      2. 오른쪽 끝: bounds.maxX, 아래끝: bonds.maxY

4. 아핀변환 [크기, 평행이동, 회전]

   1.`UIView.transform`

   2. 회전: 원점을(좌측상단 그림이 시작) 중심으로 돈다
      따라서 원래 자리에서 회전을 하면 위치가 위로 올라감.
      원래 자리에서 회전한 결과를 보고 싶다면 (1) 평행이동으로 원점의 위치를 바꾸고 (2) rotated

**4. contentMode: Redraw**

1. 기본설정으로 뷰의 경계를 바꿨을 때 비트를 새 크기에 맞춰 늘리거나 줄여 그림이 깨진다.
   그래서 뷰의 경계가 바꼈을 때 다시 그리려면 인스펙터로가서 contentMode를 redraw로 선택 (그림이 좌로 길어지는 거 방지)

**5. NSAttributedString**

**6. Setting에서 폰트 조절한거 앱에서도 영향 받을 수 있도록**

`UIFontMatrics.().scaleFont()`

**7. UILabel**

1. `numberOfLines = 0`설정하면 원하는 대로 라인을 쓸 수 있다.
2. `sizeToFit() 하기전에 frame.size를 0으로 초기화 시켜야 한다.(width 때문?)`

**8. layoutSubView()**

1. 경계가 바뀔때 마다 (핸드폰을 돌릴 때) 실행되는 코드



 **9. swift는 함수안에 함수 가능**

**10. @IBDesignable**

1. VIew에 그려주는 클래스 위에 작성하면 인터페이스 빌더에 소스로 그려질 모습을 확인할 수 있다.

2. 하지만 이미지불러오는 건 보여지지 않는다.

3. 그러나 UIImage에 추가인자를 작성하여 이미지를 불러오는 방법이 있다.

   ````swift
   UIImage(named: , in: Bundle(for: self.classForcorder), computibleWith: traitCollection)
   ````

**11. @IBInspectable**

1. 인스펙터 확장
2. 인터페이스 빌더에서 확인하고 싶은 변수 앞에 쓴다.(변수에 타입지정자 필수!)

**12. UIGestureRecognizer**

1. iOS의 모든 제스쳐를 나타냄
2. 뷰는 여러개의 제스처 인식을 가질 수 있다.
3. 제스처 인식단계 (1) 제스처를 인식한다.[아울렛 설정자의 didSet에 소스를 추가해서 제스처인식]
   (2)제스처 처리[핸들러]-> 핸들러를 쓸 때 state(ex) .end. chaned...)별로 적어줘야한다.
4. Gesture: 
   - Swipe
   - Pinch(=Scale)
   - Pan(=Move)
   - Tap
   - Rotation
   - LongPress



**궁금: PlayingCardView.adjustFaceCardScale 로 어떻게 접근가능? 타입메서드도 아닌뎅?**
