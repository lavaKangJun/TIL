### Readme

이 프로젝트는 **[Brian Voong](https://www.youtube.com/channel/UCuP2vJ6kRutQBfRmdcI92mA/playlists)** 님의 *AutoLayout*강의를 바탕으로 만들어짐.

#### 

#### 주요 개념



#### AutoLayout

1. isActive()

   constraint마다 isActivie()했던 것을 `NSLayoutConstraint.activate` 배열로 한번에 처리가 가능.

   ```swift
   //Before NSLayoutConstraint.activate(
   buttonControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
               buttonControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
               buttonControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
               buttonControlsStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
   
   // After NSLayoutConstraint.activate(
   NSLayoutConstraint.activate([
               //safeAreaLayout
               buttonControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
               buttonControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
               buttonControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
               buttonControlsStackView.heightAnchor.constraint(equalToConstant: 50)
               ])
       }
   ```

2. left, rightAnchor 대신 leading, trailingAnchor을 사용하는 것이 좋다.



#### UICollectionView

1. CollectionViewCell Register : CollectionViewCell을 사용하기 위해선 Cell을 Register해야한다(TableView에서도 동일하게 Register해줘야 한다.)

   ```swift
   // cell을 register할 때 객체로 넣는것이 아니라 self로 class 타입을 넣어야한다.
   collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
   ```

2. CollectionViewCell을 꽉찬 하나의 화면으로 구성할 수 있다.

   ```swift
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       //cell의 사이즈를 디바이스의 스크린화면 크기로
           return CGSize(width: view.frame.width, height: view.frame.height)
       }
   ```

   - 매끄러운 좌우 스크롤

     - 스크롤 방향 좌우로 (default: vertical)

     ```swift
     let layout = UICollectionViewFlowLayout()
             layout.scrollDirection = .horizontal
     ```
     - CollectionView Paging

     ```swift
      //default NO. if YES, stop on multiples of view bounds
     collectionView?.isPagingEnabled = true
     ```

     - 셀 간 간격을 0로 설정

     ```swift
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
             return 0
         }
     ```


3. 디바이스를  가로로 눕혔을 때 Cell들이 한개 씩 보이도록 설정 (이 작업을 해주지 않으면 가로로 눕혔을 때 한 화면에서 여러개의 셀들이 같이 보임)

   - viewWillTrasition(to:with:) : Notifies the container that the size of its view is about to change.
   - invalidateLayout() :  You can call this method at any time to update the layout information. This method invalidates the layout of the collection view itself and returns right away.

   ``` swift
   override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
           
           coordinator.animate(alongsideTransition: { (_) in
               self.collectionViewLayout.invalidateLayout()
               
               if self.pageControls.currentPage == 0 {
                   self.collectionView?.contentOffset = .zero
               } else {
                   let indexPath = IndexPath(item: self.pageControls.currentPage, section: 0)
                   self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally , animated: true)
               }
           } ) { (_) in
               
           }
       }
   ```


#### NSMutableAttributedString

A mutable string object that also contains attributes (such as visual style, hyperlinks, or accessibility data) associated with various portions of its text content.

```swift
private let descriptionTextView: UITextView!

let attributeText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
            
            attributeText.append(NSAttributedString(string: "\n\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.gray]))
            
            descriptionTextView.attributedText = attributeText
            descriptionTextView.textAlignment = .center
```

