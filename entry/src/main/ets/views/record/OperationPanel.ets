
//操作面板
// @Preview
@Component
export default struct OperationPanel {
  //数量
  @State amount:number = 1.0
  //取消
  cancel?:() => void
  //提交
  submit?:(amount:number) => void

  build() {
    Column({space: 10}) {
      //头部组件
      this.headerViewBuilder()
      //食物信息
      this.foodInformationBuilder()
      //文本输入组件
      this.inputBuilder()
      //数字键盘
      this.numericKeyboardBuilder()
      //操作按钮
      this.operationBtnBuilder()
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.index_page_background'))
  }


  //头部组件
  @Builder
  headerViewBuilder() {
    Row() {
      //日期
      Text('2024年8月5日 早餐').fontSize(16).fontWeight(FontWeight.Medium)
      //图标
      Image($r('app.media.ic_public_spinner')).width(30)
    }
    .margin({top: 10})
    .onClick(() => console.log('选择日期'))
  }

  //食物信息
  @Builder
  foodInformationBuilder() {
    Column({space: 8}){
      //食物图片
      Image($r('app.media.toast')).width(120)

      //食物名称
      Text('全麦吐司')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .borderRadius(4)
        .padding({top: 4, left: 10, bottom: 4, right: 10})
        .backgroundColor($r('app.color.lightest_primary_color'))

      //分割线
      Divider()
        .strokeWidth(0.5)
        .color($r('app.color.light_primary_color'))
        .padding({top: 10, left: 25, bottom: 10, right: 25})

      //食物详细信息
      Row({space: 8}) {
        this.foodDetailInformationBuilder('热量 (千卡)', 91.0)
        this.foodDetailInformationBuilder('碳水 (克)', 15.5)
        this.foodDetailInformationBuilder('蛋白质 (克)', 4.4)
        this.foodDetailInformationBuilder('脂肪 (克)', 1.3)
      }

      //分割线
      Divider()
        .strokeWidth(0.5)
        .color($r('app.color.light_primary_color'))
        .padding({top: 10, left: 25, bottom: 10, right: 25})
    }
    .width('90%')
  }

  //食物详细信息
  @Builder
  foodDetailInformationBuilder(text:string, value:number) {
    Column({space: 8}) {
      //食物营养名称
      Text(text)
        .fontSize(14)
        .fontColor($r('app.color.light_gray'))

      //营养值
      Text(`${(value * this.amount).toFixed(1)}`)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
    }
  }

  //文本输入组件
  @Builder
  inputBuilder() {
    Row({space: 8}) {
      Column({space: 8}) {
        //输入数量
        Text(this.amount.toFixed(1))
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.primary_color'))

        //分割线
        Divider()
          .color($r('app.color.primary_color'))
          .strokeWidth(1)
          .width(140)
      }
      Text('片').fontColor($r('app.color.light_gray'))
    }
  }

  //数字键盘
  @Builder
  numericKeyboardBuilder() {
    Grid(){
      ForEach(['1','2','3','4','5','6','7','8','9','0','.','删除'],(text:string) => {
        GridItem() {
          Text(text).fontSize(18).fontWeight(FontWeight.Bolder)
        }
        .height(50)
        .borderRadius(6)
        .backgroundColor(Color.White)
        .onClick(() => this.checkNumber(text))
      })
    }
    .width('100%')
    .height(224)
    .columnsTemplate('1fr 1fr 1fr')
    .columnsGap(8)
    .rowsGap(8)
    .padding(8)
    .backgroundColor($r('app.color.index_page_background'))
  }

  //操作按钮
  @Builder
  operationBtnBuilder() {
    Row({space: 16}) {
      Button('取消')
        .btnStyle($r('app.color.light_gray'))
        .onClick(() => {
          console.log('取消')
          this.cancel ? this.cancel() : null
        })

      Button('提交')
        .btnStyle($r('app.color.primary_color'))
        .onClick(() => {
          console.log('提交')
          this.submit ? this.submit(this.amount) : null
        })
    }
  }

  //校验输入的数据是否正确
  checkNumber(num: string) {
    if(num === '删除') {
      let val = this.amount.toFixed()
      val = val.substring(0, val.length-1)
      this.amount = this.parseToFloat(val)
    } else {
      //拼接用户输入
      let val = this.amount.toFixed()
      let tempValue = val + num

      //正向获取小数点
      let firstIdx = tempValue.indexOf('.')
      //反向获取小数点
      let lastIdx = tempValue.lastIndexOf('.')
      //判断是否为非法输入
      if(firstIdx != lastIdx || (lastIdx != -1 && lastIdx < tempValue.length - 2)) {
        return
      }

      this.amount = this.parseToFloat(tempValue)
      if(this.amount >= 999.9) {
        this.amount = 999.0
      }
    }
  }

  //将字符串转为浮点数
  parseToFloat(num:string) {
    if(!num) { return 0 }

    if(num.endsWith('.')) {
      num = num.substring(0, num.length-1)
    }

    return parseFloat(num)
  }
}

@Extend(Button) function btnStyle(color:ResourceStr) {
  .width(120)
  .height(44)
  .borderRadius(8)
  .fontColor(Color.White)
  .type(ButtonType.Normal)
  .backgroundColor(color)
  .margin({top: 15})
}