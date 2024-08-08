import RecordPage from '../../views/record/RecordIndex';
import DiscoverPage from '../../views/discover/DiscoverPage'
import ProfilePage from '../../views/profile/ProfilePage';
import ScreenUtil from '../../common/utils/ScreenUtil';
import ScreenConstants from '../../common/constants/ScreenConstants';
import ScreenInfo from '../../common/bean/ScreenInfo';

//首页
@Entry
@Component
struct IndexPage {
  @State idx: number = 0
  @StorageProp(ScreenConstants.CURRENT_SCREEN) screenType:string = ScreenConstants.SCREEN_SM

  private screenUtil:ScreenUtil = new ScreenUtil()
  private screenInfo:ScreenInfo<boolean> = new ScreenInfo({sm: false, md: true, lg: true})


  aboutToAppear(): void {
    this.screenUtil.register()
  }

  aboutToDisappear(): void {
    this.screenUtil.unregister()
  }

  build() {
    Tabs({barPosition:ScreenConstants.BAR_POSITION.getValue(this.screenType)}) {
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
    .barWidth(this.getBarWidth())
    .barHeight(this.getBarHeight())
    .onChange((index:number) => this.idx = index)
    .vertical(this.screenInfo.getValue(this.screenType))

  }

  //自定义底部tab组件
  @Builder
  TabBarBuilder(icon:ResourceStr, title:string, idx:number) {
    Column({space: 8}) {
      Image(icon).width(24).fillColor(idx == this.idx ? $r('app.color.primary_color') :  $r('app.color.gray'))
      Text(title).fontSize(14).fontColor(idx == this.idx ? $r('app.color.primary_color') :  $r('app.color.gray'))
    }
    .width('100%')
  }

  //获取 tabBar 的宽度
  getBarWidth() {
    return this.screenInfo.getValue(this.screenType) ? 120 : '100%'
  }

  //获取 tabBar 的高度
  getBarHeight() {
    return this.screenInfo.getValue(this.screenType) ? '100%' : 88
  }
}