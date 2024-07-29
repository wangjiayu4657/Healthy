import StatisticsCard from '../../views/record/StatisticsCard';

//记录
@Entry
@Component
export default struct RecordPage {
  static routeUrl: string = 'pages/record/RecordPage'
  @State message: string = 'Hello World';

  build() {
    Column({space: 10}) {
      //搜索
      this.SearchHeaderBuilder()
      Column() {
        //统计卡片
        StatisticsCard()

        //列表

      }
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
    .padding(15)
  }
}