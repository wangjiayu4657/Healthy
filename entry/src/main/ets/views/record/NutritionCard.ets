import { CommonConstants } from '../../common/constants/CommonConstants'
import RecordService from '../../service/RecordService'

declare interface nutritionInfo {
  value:number        //摄入量
  maxVal:number       //最多摄入量
  desc:string         //描述
  color:ResourceStr   //颜色
}

//营养统计组件
@Component
export default struct NutritionCard {
  @Consume recordService:RecordService

  //碳水化合物摄入量上限
  maxCarbon:number = CommonConstants.RECOMMEND_CARBON
  //蛋白质摄入量上限
  maxProtein:number = CommonConstants.RECOMMEND_PROTEIN
  //脂肪摄入量上限
  maxFat:number = CommonConstants.RECOMMEND_FAT

  build() {
    Row() {
      this.CardItem({
        value:this.recordService.statisticModel.info.carbon,
        maxVal:this.maxCarbon,
        desc:'碳水化合物',
        color:$r('app.color.carbon_color')
      })

      this.CardItem({
        value:this.recordService.statisticModel.info.protein,
        maxVal:this.maxProtein,
        desc:'蛋白质',
        color:$r('app.color.protein_color')
      })

      this.CardItem({
        value:this.recordService.statisticModel.info.fat,
        maxVal:this.maxFat,
        desc:'脂肪',
        color:$r('app.color.fat_color')
      })
    }
    .width('100%')
    .padding({bottom: 10})
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  //统计项
  @Builder
  CardItem($$:nutritionInfo) {
    Column({space: 4}) {
      Stack() {
        //进度条
        Progress({
          value: $$.value,
          total: $$.maxVal,
          type:ProgressType.Ring
        })
          .width(100)
          .style({strokeWidth: 6})
          .color($$.color)


        Column({space: 6}) {
          Text('摄入推荐')
            .fontSize(14)
            .fontWeight(CommonConstants.FONT_WEIGHT_600)
            .fontColor($r('app.color.gray'))

          Text(`${$$.value.toFixed(1)}/${$$.maxVal}`)
            .fontSize(16)
            .fontWeight(CommonConstants.FONT_WEIGHT_700)
        }
      }

      Text(`${$$.desc} (克)`)
        .fontSize(14)
        .margin({top: 10})
        .fontColor($r('app.color.light_gray'))
    }
  }
}