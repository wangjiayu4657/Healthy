import { CommonConstants } from '../../common/constants/CommonConstants'

//热量统计组件
@Component
export default struct CalorieCard {
  //摄入量
  intake:number = 192
  //推荐摄入量
  recommend:number = CommonConstants.RECOMMEND_CALORIE
  //消耗量
  consumption:number = 143

  build() {
    Row() {
      this.CardItem('饮食摄入', this.intake)
      this.ResidualIntakeCardItem('还可以吃', 1280, '推荐1280')
      this.CardItem('饮食摄入', 154)
    }
    .width('100%')
    .padding({bottom: 10})
    .borderRadius(12)
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  //统计项
  @Builder CardItem(label:string, value:number, tip?:string) {
    Column({space: 4}) {
      Text(label)
        .fontSize(14)
        .fontWeight(CommonConstants.FONT_WEIGHT_600)

      Text(value.toFixed(0))
        .fontSize(16)
        .fontWeight(CommonConstants.FONT_WEIGHT_700)

      if(tip) {
        Text(tip)
          .fontSize(12)
          .fontColor($r('app.color.stats_title_bgc'))
      }
    }
  }

  //剩余摄入量
  @Builder ResidualIntakeCardItem(label:string, value:number, tip?:string) {
    Stack() {
      //进度条
      Progress({
        value: this.intake,
        total: this.residualIntakeValue(),
        type:ProgressType.Ring
      })
        .width(115)
        .style({strokeWidth: 6})

      //统计项
      this.CardItem(label, value, tip)
    }
  }

  //还可以继续摄入的量
  residualIntakeValue() {
    return this.recommend - this.intake + this.consumption
  }
}
