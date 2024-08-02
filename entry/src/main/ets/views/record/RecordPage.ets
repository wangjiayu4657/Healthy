import StatisticsCard from './StatisticsCard';
import DietList from './DietList'


//记录
@Component
export default struct RecordPage {
  static routeUrl: string = 'pages/record/RecordPage'

  build() {
    Column({space: 10}) {
      //搜索
      this.SearchHeaderBuilder()
      //统计卡片
      StatisticsCard().width('94%')
      //列表
      DietList()
        .width('94%')
        .layoutWeight(1)
        .margin({top: 5})
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F2F3')
  }

  @Builder
  SearchHeaderBuilder() {
    Row({space: 10}){
      Search({placeholder:'请输入搜索内容'})
        .layoutWeight(1)

      Badge({count: 10, style: {
        badgeSize: 16
      }}){
        Image($r('app.media.bz_msg'))
          .width(30)
          .objectFit(ImageFit.Contain)
      }
    }
    .width('100%')
    .padding({top: 15, left: 15, right: 15})
  }
}