import { CommonConstants } from '../../common/constants/CommonConstants'

//营养统计组件
@Component
export default struct NutritionCard {
  //碳水化合物摄入量
  carbon:number = 34
  //碳水化合物摄入量上限
  carbonLimit:number = CommonConstants.RECOMMEND_CARBON

  //蛋白质摄入量
  protein:number = 9
  //蛋白质摄入量上限
  proteinLimit:number = CommonConstants.RECOMMEND_PROTEIN

  //脂肪摄入量
  fat:number = 7
  //脂肪摄入量上限
  fatLimit:number = CommonConstants.RECOMMEND_FAT

  build() {
    Row() {
      this.CardItem(this.carbon, this.carbonLimit,'碳水化合物',$r('app.color.carbon_color'))
      this.CardItem(this.protein, this.proteinLimit,'蛋白质', $r('app.color.protein_color'))
      this.CardItem(this.fat, this.fatLimit,'脂肪', $r('app.color.fat_color'))
    }
    .width('100%')
    .padding({bottom: 10})
    .borderRadius(12)
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  //统计项
  @Builder CardItem(value:number, valueLimit:number, desc:string, color:ResourceStr) {
    Column({space: 4}) {
      Stack() {
        //进度条
        Progress({
          value: value,
          total: valueLimit,
          type:ProgressType.Ring
        })
          .width(100)
          .style({strokeWidth: 6})
          .color(color)


        Column({space: 6}) {
          Text('摄入推荐')
            .fontSize(14)
            .fontWeight(CommonConstants.FONT_WEIGHT_600)
            .fontColor($r('app.color.gray'))

          Text(`${value}/${valueLimit}`)
            .fontSize(16)
            .fontWeight(CommonConstants.FONT_WEIGHT_700)
        }
      }

      Text(`${desc} (克)`)
        .fontSize(14)
        .margin({top: 10})
        .fontColor($r('app.color.light_gray'))
    }
  }
}