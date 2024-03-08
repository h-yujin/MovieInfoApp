# MovieInfoApp

TMDB에서 제공하는 API를 활용해 영화 관련 정보를 가져오는 앱

## Overview

### 제공하는 기능
현재 제공하는 기능은 다음과 같습니다.
- 홈 > 인기영화, 최고 평점 영화, 개봉 예정 영화   
  <img src = "https://github.com/h-yujin/MovieInfoApp/assets/60815411/716f0e4e-840f-4836-9f44-3e7a0fb95320" width="30%" height="30%">

- 영화 검색   
  <img src = "https://github.com/h-yujin/MovieInfoApp/assets/60815411/01bb852f-7162-4963-bf8d-a215ad44ab7a" width="30%" height="30%">


## 학습목표
- MVVM 아키텍쳐, Combine을 이용한 View-ViewModel 데이터 바인딩
- UITableViewDiffableDataSource, UICollectionViewDiffableDataSource 이용한 UI 개발

## 학습내용
- UICollectionViewDiffableDataSource를 사용하여 홈처럼 여러 Section,item이 있는 경우 기존 UICollectionViewDataSource보다
- UITableViewDiffableDataSource를 사용하여 데이터 검색시 애니메이션을 통해 검색하고 있는 느낌을 주는 사용자 경험이 좋아졌다.   
https://github.com/h-yujin/MovieInfoApp/assets/60815411/230c809e-6764-4c97-bf95-34eb66d356e6
- MVVM을 통해 View와 ViewModel의 역할을 명확하게 나눠주니 확실히 ViewController의 역할이 명확해졌다.
- View와 ViewModel의 DataBinding이 되어 있으니, 따로 reloadData를 해주지 않아도 알아서 업데이트가 되어 있으니 편했다.

