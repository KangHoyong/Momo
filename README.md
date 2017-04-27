# MOMO iOS APP 
> FastCampus School TeamProject  
> 2017. 03. 27 ~ 2017. 04. 25  

## Momo (Map Of My Oasis)  
###내가 아끼는 곳, 나만의 지도 MOMO  
> 지도를 만들고, 지도에 장소를 등록하고  
> 장소에 기록(글, 사진)을 남길 수 있습니다.  

<iframe width="560" height="315" src="https://www.youtube.com/embed/u_HlN_1t79g" frameborder="0" allowfullscreen></iframe>  




## iOS Dev Features  
개발 언어 : Objective-C  
개발 도구 : Xcode, Git(GitHub), Postman, Sketch, Zeplin  

- Google Maps 기반의 지도 앱  
    > Apple Map이 더 가볍고, 이쁘고(구글 로고 노출...), (당연하지만) 프레임웍에 친화적인 것 같습니다.  

- 일반 계정(e-mail) / Facebook 계정(FB Login, Graph API) 로그인, 회원가입  
    > 후반까지 웹서버 팀원들과 합의된 페북 로그인 구조가 조금은 특이했어서  
    > 직접 Facebook Graph API를 통해 userName, profileImg, e-mail 등을 가져와 서버에 보내는 방식을 취했습니다.
    
- Network (일반 코드, AFNetworking) 코드 로직 설계 및 네트워크 연결
    > [Momo API Documents](https://momo-wps.gitbooks.io/momo-apis/content/)

- Realm Mobile DataBase로 데이터셋 구조 설계 및 관리 
    > 데이터 셋 클래스는 아래와 같이 7가지이며  
    > 크게 봤을 때, [Login - User > Map > Pin > Post] 1 > n (일대다) 구조로 설계하였습니다.  
    > LoginDataSet  : 자동로그인을 위한 token, pk관리  
    > UserDataSet   : 유저 정보, 맵 리스트  
    > MapDataSet    : 맵 정보, 핀 리스트  
    > PinDataSet    : 핀 정보, 포스트 리스트  
    > PostDataSet   : 포스트 정보  
    > PlaceDataSet  : 위도, 경도, 주소 등 위치 정보  
    > AuthorDataSet : 맵, 핀, 포스트 작성자 정보  

- AutoLayout(StoryBoard, Xib/Nib) / Code(frame) / AutoLayout & Code 다양한 방식으로 UI를 적용  
    > 어떤 UI라도 디테일하게 잘 구현할 자신이 있습니다.  

- Tab-Navi-ViewController 구조에서 CustomTabBar 구현  
    > 어렵지 않게 TabBarItem을 추가할 수 있게 짰습니다.  
    > 탭바 아이콘 갯수대로 자동으로 Layout n등분하여 이쁘게 탭바에 올라갑니다.  
    > 탭바를 어떨 때 누르느냐에 따라 다르게 분기 처리하여 Navi popToRootViewController를 동작한다던지,  
    > 지도에서 내 위치로 이동한다던지, TableView 상단으로 스크롤이 된다던지 합니다.  
    
- NaviBar Hidden에 따른 popGesture 예외 처리  
    > NaviBar를 Hidden하면 popGesture도 사라집니다.  
    > NaviController의 interactivePopGestureRecognizer.delegate를 self나 nil로 맞는 VC&시점에 세팅하여야 하고  
    > NaviController의 rootViewController에서는 popGesture가 동작하지 않도록 예외처리 해야합니다.  
    > 만약, 어설프게 처리했다면  
    > rootView에서 popGesture를 한 뒤, push 처리를 할 때, 앱이 죽지는 않는데 잠시 멈추고, 동작도 이상하게 하거나
    > popGesture가 어느순간부터 작동하지 않을 수도 있습니다.  
    > ex. MapView를 push, pop 지나고 나면 popGesture가 다시 작동하지 않습니다.  

- CustomTableViewCell, CustomTableViewHeaderView Self-Sizing 적용  
    > Cell에 올라가는 컨텐츠의 길이에 따라, 따로 Height를 설정해주지 않아도 알아서 자동 조정됩니다.  
    
- 다양한 UX/에러 상황에 대한 예외 처리   
	 > ex1. 지도탭에서 특정 pin데이터를 통한 PinView를 보고 있는데, 내기록탭에서 해당 pin데이터를 지우고, 다시 지도탭으로 이동하는 상황  
	 > ex2. Navi push구조 잘 유지시키며 핀 마커 생성 도중 맵뷰로 돌아올 때, 핀 마커 생성 후 맵뷰로 이동하는 것 다르게..  
	 > ex3. CustomTabBar 위치가 다른 것 처리 (테더링 켰다가 껐을 때)  
	 > 등등... 크든 작든 아주 많은 예외처리를 하였습니다.  
	 
- 직접 UX/UI 디자인 및 적용  
    > 한선이형 👍  

- Google Analytics, Facebook Analytics 적용  
- pch파일 만들어 프로젝트 전체에서 공통적으로 자주 접근할만한 헤더들을 모아 정의  

- 개발하며 사용한(했던) OpenSource SDK, Library들  
	- Google Maps SDK  
	- Facebook SDK
	- Realm  
	- AFNetworking  
	- UIPlaceHolderTextView  
	- SDWebImage  
	- FontAwesomeKit  

- 그 외 얻은 것들?  
	- 삽질을 해야만 알 수 있는 Cocoa Touch Framework의 세세한 부분들  
	- Git StoryBoard Conflict 따위 이젠 두렵지 않음  

- 아직 남아있는 개발거리, 이슈들  
	- 리팩토링  
	- 보다 효율적인 네트웍 처리, 제대로 된 캐싱구조 적용  
	- indicator 띄울 때, 버튼 등 눌리지 않게 처리  
	- 검색, 소셜기능 적용  


##Momo Team  
협업 방식 : 주 1~2회 스프린트 미팅, Daily Scrum으로 매일(평일) 개발 상황 공유  
협업 도구 : Slack, Google docs, Hangout, Trello  



   | Name | GitHub | e-mail   
--- | --- | --- | ---  
**iOS** | **최제헌** | [**Jeheonjeol**](https://github.com/Jeheonjeol) | [**c92921@gmail.com**](c92921@gmail.com)  
**iOS** | **정한선** | [**hansonjung**](https://github.com/hansonjung) | [**hansonjung@gmail.com**](hansonjung@gmail.com)  
web | 노안영 | [anohk](https://github.com/anohk) | [anyoung.noh@gmail.com](anyoung.noh@gmail.com)  
web | 김준모 |  | [kizmo04@gmail.com](kizmo04@gmail.com)  
front | 최병광 |  | [owlgwang@gmail.com](owlgwang@gmail.com)
front | 방현지 |  | [groovehyunji@gmail.com](groovehyunji@gmail.com)
android | 박지훈 | [reach0328](https://github.com/reach0328) | [reach0328@gmail.com](reach0328@gmail.com)
android | 박유석 | [yseok](https://github.com/yseok) | [ys920603@gmail.com](ys920603@gmail.com) 
 
