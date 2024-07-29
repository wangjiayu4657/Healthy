import RecordPage from '../record/RecordPage';
import DiscoverPage from '../discover/DiscoverPage'
import ProfilePage from '../profile/ProfilePage';
import TabItem from '../../common/componet/UPTabContent';

@Entry
@Component
export default struct IndexPage {
  static routeName:string = 'pages/main/IndexPage'

  @State idx: number = 0
  titles:string[] = ['记录', '发现', '我的']

  build() {
    Tabs({barPosition:BarPosition.End, index:this.idx}) {
      ForEach(this.titles,(title:string,idx:number) => {
        TabContent() {
          if(idx == 0) {
            RecordPage()
          } else if(idx == 1) {
            DiscoverPage()
          } else {
            ProfilePage()
          }
         }
        .tabBar(title)
      })
    }
    .width('100%')
    .height('100%')
    .onChange((index:number) => this.idx = index)
  }


  @Builder tabItem(idx:number) {

    TabItem({
      icon: '',
      title: '',
      color: ''
    })
  }
}