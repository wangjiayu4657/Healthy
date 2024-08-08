import { RecordModel } from '../../models/RecordModel'

@Component
export default struct FoodListItem {
  recordModel?:RecordModel
  @Prop amount:number = 1
  @BuilderParam tailBuilder:() => void = this.tBuilder

  build() {
    Row({space: 8}) {
      //食物图片
      Image(this.recordModel?.info.image).width(48)
      //食物信息
      Column({space: 8}) {
        //食物名称
        Text(this.recordModel?.info.name).fontSize(16).fontWeight(FontWeight.Medium)
        //食物数量
        Text(`${this.amount}${this.recordModel?.info.unit}`).greyTextStyle()
      }
      Blank()
      //尾部的组件, 默认为食物热量信息
      this.tailBuilder()
    }
    .width('100%')
    .padding(15)
    .backgroundColor(Color.White)
  }

  @Builder
  tBuilder() {
    Text(`${this.recordModel?.info.calorie}千卡`).greyTextStyle()
  }
}

@Extend(Text) function greyTextStyle(color:ResourceStr = $r('app.color.light_gray')) {
  .fontSize(14)
  .fontColor(color)
}