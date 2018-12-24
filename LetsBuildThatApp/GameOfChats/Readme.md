### GameOfChats

#### 1. 사용기술

##### 1. Swift

 1. TableView

     1. TableViewCell

         1. 셀의 재사용

            ```swift
            // 테이블의 셀은 재사용이 되기 때문에 이미지를 초기화 하는 것이 좋다
            //Brian voong code in extension ImageView Feil
            extension UIImageView {
                func loadImageUsingCacheWithUrlString(urlString: String) {
                  self.image = nil   
                }
            }
            
            //My code in CustomTableCell
            override func prepareForReuse() {
                    super.prepareForReuse()
                    self.profileImageView.image = nil
                }
            ```

         2. CellRegister

              테이블뷰에서 셀을 사용하기 위해서 Register작업을 해줘야 한다.(기본셀을 사용하는 경우는 Register 하지 않아도 된다.)

              ```swift
              //CustomCell 등록
              tableView.register(UserTableViewCell.self, forCellReuseIdentifier: cellId)
              ```

         3. layoutSubview <- ViewContorller Lifecycle Method

              1. TableViewCell에서 기본으로 제공해주는 UI객체들의 배치나 크기를 조절할 수 있다.

              ```swift
              override func layoutSubviews() {
                          super.layoutSubviews()
                          textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
                          detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
                      }
              ```


2. NSCache

   1. 서버에서 불러온 데이터를 캐시에 저장해서 사용할 수 있다.

      ```swift
      //선언
      let cache = NSCache<NSString , UIImage>()
      
      // 서버에서 이미지 가져오는 메서드(캐시에 존재하면 서버에서 가져오지 않는다.) 
      func loadImageUsingCacheWithUrlString(urlString: String) {
              
              //check chache for image first
              if let cacheImage = cache.object(forKey: urlString as NSString) {
                  self.image = cacheImage
                  return
              }
          
          //otherwise fire off a new download
              let profileImageURL = urlString
                  if let url = URL(string: profileImageURL) {
                      print(url)
                      do {
                          let imageData = try Data(contentsOf: url)
                          if let downloadImage = UIImage(data: imageData) {
                              cache.setObject(downloadImage, forKey: urlString as NSString)
                              self.image = downloadImage
                          }
                      } catch {
                          print(error.localizedDescription)
                      }
                  }
              }
      }
      ```

3. ImageView

   1. ImageVIew의 image를 png, jpeg data로 변경

      ```
      // PNG
      // if let uploadData == self.profileImageView.image?.pngData(){
      // JPEG
      if let profileImage = self.profileImageView.image, let uploadData = profileImage.jpegData(compressionQuality: 0.1) {
      				// jpeg 파일로 변경 후 Firebase Storage에 저장
                      storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                          if error != nil {
                              print(error!)
                              return
                          }
                          storageRef.downloadURL(completion: { [weak self]  (url, error) in
                              guard let url = url else {
                                  return
                              }
                              let values = ["name": name, "email": email, "profileImageURL": "\(url)"]
                              self?.registerUserIntoDatabaseWithUID(uid: uid, values: values)
                          })
                      })
                  }
      ```

4. TitleView 

   NavigatiomItem의 titleview를 Custom

   ```swift
   let titleView = UIView()
           titleView.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
           
           let profileImage = UIImageView()
           profileImage.contentMode = .scaleAspectFill
           profileImage.translatesAutoresizingMaskIntoConstraints = false
           profileImage.layer.cornerRadius = 20
           profileImage.layer.masksToBounds = true
           if let profilImage = user.profileImageURL {
               profileImage.loadImageUsingCacheWithUrlString(urlString: profilImage)
           }
   
           titleView.addSubview(profileImage)
   
           NSLayoutConstraint.activate([
               profileImage.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
               profileImage.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
               profileImage.widthAnchor.constraint(equalToConstant: 40),
               profileImage.heightAnchor.constraint(equalToConstant: 40)
               ])
   
           let nameLabel = UILabel()
           titleView.addSubview(nameLabel)
           nameLabel.translatesAutoresizingMaskIntoConstraints = false
           nameLabel.text = user.name
           NSLayoutConstraint.activate([
               nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 8),
               nameLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
               nameLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
               nameLabel.heightAnchor.constraint(equalTo: profileImage.heightAnchor)
               ])
           
           self.navigationItem.titleView = titleView
   }
   ```

##### 2. Firebase

 1. Database에 User정보 생성(=**회원가입**)

    ```swift
    func handleRegister() { 
    	Auth.auth().createUser(withEmail: email, password: password) {
                (dataResult, error) in
                
                if error != nil {
                    print("Register Error : \(error!)")
                    return
                }
                
                guard let uid = dataResult?.user.uid else {
                    return
                }
                
                // Successfully authenticated user
                let imageName = NSUUID().uuidString
                let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).png")
         		// imageUpload
                if let uploadData =  self.profileImageView.image?.pngData() {
                    storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                        if error != nil {
                            print(error!)
                            return
                        }
                        //image url dowmload                                                       
                        storageRef.downloadURL(completion: { [weak self]  (url, error) in
                            guard let url = url else {
                                return
                            }
                            let values = ["name": name, "email": email, "profileImageURL": "\(url)"]
                            self?.registerUserIntoDatabaseWithUID(uid: uid, values: values)
                        })
                    })
                }
            }
    }
    
    // register to Database
    private func registerUserIntoDatabaseWithUID(uid: String, values: [String: String]) {
            let ref = Database.database().reference(fromURL: "https://gameofchats-a7ecf.firebaseio.com/")
            let userReference = ref.child("user").child(uid)
            userReference.updateChildValues(values, withCompletionBlock: { [weak self](err, ref) in
                if err != nil {
                    print("updateUserError: \(err!)")
                    return
                }
                self?.dismiss(animated: true, completion: nil)
                print("Saved user successfully into firebase db")
                
            })
        }
    ```

2. Database에서 User정보 확인 (=**로그인**)

   ``` swift
    Auth.auth().signIn(withEmail: email, password: password) { (dataResult, error) in
               
               if error != nil {
                   print("Login Error: \(error)")
                   return
               }
               
               //successfully loggined in our user
               self.dismiss(animated: true, completion: nil)
           }
   
   
   
   // 로그아웃
   do {
         try Auth.auth().signOut()
       } catch let logoutError {
          print(logoutError)
       }
   ```


3. 앱에서 로그인이 되어있는 지 아닌 지 확인

   ```swift
   func checkIfUserLogin() {
           // user is not logged in
           if Auth.auth().currentUser?.uid == nil {
               performSelector(onMainThread: #selector(handleLogout), with: nil, waitUntilDone: false)
           } 
       }
   ```


4. 데이터 가져오기

   ```swift
   // 한명의 유저 데이터 가져오기
   // 로그인이 되어있으면 관련 유저의 데이터 가져오기
    if let uid = Auth.auth().currentUser?.uid {
             Database.database().reference().child("user").child(uid!).observeSingleEvent(of: .value) { (snapShot) in
                   if let dictionary = snapShot.value as? [String: AnyObject] {
                       self.navigationItem.title = dictionary["name"] as? String
                   }
               }
    }
   
   // 모든 유저 데이터 가져오기
   Database.database().reference().child("user").observe(.childAdded, with: { [weak self] (snapshot) in
               if let dictionary = snapshot.value as? [String: AnyObject] {
                   let user = User()
                   user.name = dictionary["name"] as? String
                   user.email = dictionary["email"] as? String
                   user.profileImage = dictionary["profileImageURL"] as? String
                   self?.users.append(user)
                   DispatchQueue.main.async {
                       self?.activity.stopAnimating()
                       self?.tableView.reloadData()
                   }
               }
           }, withCancel: nil)
   
   ```

5. message관련 데이터 베이스 생성 및 저장 

   ```swift
   @objc func handleSend() {
         let ref = Database.database().reference().child("message")
         let childRef = ref.childByAutoId()
         guard let textContents = self.inputTextField.text else {
             return
         }
         let values = ["text": textContents, "name": "Jhon Snow"]
         childRef.updateChildValues(values)
      }
   ```
