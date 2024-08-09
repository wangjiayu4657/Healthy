import { CommonConstants } from '../../common/constants/CommonConstants'
import RecordService from '../../pages/service/RecordService'

declare interface infoInterface {
  label:string,
  value:number,
  tip?:string
}

//热量统计组件
@Component
export default struct CalorieCard {
  @Consume recordService:RecordService

  build() {
    Row() {
      this.CardItem({
        label:'饮食摄入',
        value:this.recordService.statisticModel.info.intake
      })

      this.ResidualIntakeCardItem({
        label:'还可以吃',
        value:this.recordService.statisticModel.info.delCalorie,
        tip:`推荐${CommonConstants.RECOMMEND_CALORIE}`
      })

      this.CardItem({
        label:'运动消耗',
        value:this.recordService.statisticModel.info.consumption
      })
    }
    .width('100%')
    .padding({bottom: 10})
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  //统计项
  @Builder CardItem($$:infoInterface) {
    Column({space: 4}) {
      Text($$.label)
        .fontSize(14)
        .fontWeight(CommonConstants.FONT_WEIGHT_600)

      Text($$.value.toFixed(0))
        .fontSize(16)
        .fontWeight(CommonConstants.FONT_WEIGHT_700)

      if($$.tip) {
        Text($$.tip)
          .fontSize(12)
          .fontColor($r('app.color.light_gray'))
      }
    }
  }

  //剩余摄入量
  @Builder ResidualIntakeCardItem($$:infoInterface) {
    Stack() {
      //进度条
      Progress({
        value: this.calculatorIntake(),
        total: CommonConstants.RECOMMEND_CALORIE,
        type:ProgressType.Ring
      })
        .width(115)
        .style({strokeWidth: 6})

      //统计项
      this.CardItem($$)
    }
  }

  //还可以继续摄入的量
  calculatorIntake() {
    let result = this.recordService.statisticModel.info.intake - this.recordService.statisticModel.info.consumption
    result = result < 0 ? 0 : result
    return result
  }
}
