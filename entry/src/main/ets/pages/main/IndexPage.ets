import RecordPage from '../../views/record/RecordPage';
import DiscoverPage from '../../views/discover/DiscoverPage'
import ProfilePage from '../../views/profile/ProfilePage';
import { TabModel } from '../../models/TabModel';
import UPTabContent from '../../common/componet/UPTabContent';

@Entry
@Component
export struct IndexPage {
  static routeName:string = 'pages/main/IndexPage'

  @State idx: number = 0

  build() {
    Tabs({barPosition:BarPosition.End}) {
      TabContent() {
        RecordPage()
      }.tabBar(this.TabBarBuilder($r('app.media.ic_calendar'), '记录', 0))

      TabContent() {
        DiscoverPage()
      }.tabBar(this.TabBarBuilder($r('app.media.discover'), '发现', 1))

      TabContent() {
        ProfilePage()
      }.tabBar(this.TabBarBuilder($r('app.media.ic_user_portrait'), '我的', 2))
    }
    .width('100%')
    .height('100%')
    .barHeight(88)
    .onChange((index:number) => {
      this.idx = index
      console.log('index == ', index)
    })
  }

  //自定义底部tab组件
  @Builder
  TabBarBuilder(icon:ResourceStr, title:string, idx:number) {
    Column({space: 8}) {
      Image(icon).width(24).fillColor(idx == this.idx ? $r('app.color.primary_color') :  $r('app.color.gray'))
      Text(title).fontSize(14).fontColor(idx == this.idx ? $r('app.color.primary_color') :  $r('app.color.gray'))
    }
  }
}