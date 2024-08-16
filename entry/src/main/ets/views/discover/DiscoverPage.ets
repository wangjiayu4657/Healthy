import NavHeader from '../../common/componet/NavHeader'



// @Preview
//发现
@Component
export default struct DiscoverPage {
  @State name:string = '早餐'


  list:string[] = ['', 'CE', 'C', '÷', '×', '7','8','9','-','4','5','6','+','1','2','3','=','0','.']

  build() {
    Column() {
      //头部组件
      NavHeader({title: '计算器',bgColor: $r('app.color.primary_color')})

      //计算器
      this.calculatorBuilder()

      //计数器
      Counter() {
        Text('1')
      }
      .onInc(() => {})
      .onDec(() => {})
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  calculatorBuilder() {
    Grid(){
      ForEach(this.list, (symbol:string, idx:number) => {
        if(idx == 0) {
          GridItem() {
            TextInput({text: '0'})
              .width('100%')
              .height('100%')
              .type(InputType.Number)
              .textAlign(TextAlign.End)
              .fontSize(34)
              .fontWeight(FontWeight.Bolder)
              .borderRadius(8)
              .border({width: 1, color:Color.Green})
          }
          .columnStart(0)
          .columnEnd(3)
        } else if(idx == 16) {
          GridItem() {
            Text(symbol).textStyle()
          }
          .rowStart(4)
          .rowEnd(5)
        } else if(idx == 17) {
          GridItem() {
            Text(symbol).textStyle()
          }
          .columnStart(0)
          .columnEnd(1)
        } else {
          GridItem() {
            Text(symbol).textStyle()
          }
        }
      })
    }
    .width('94%')
    .layoutWeight(1)
    .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr')
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsGap(8)
    .columnsGap(8)
    .padding(15)
    .margin(20)
    .border({width:2, color: Color.Green})

  }
}

@Extend(Text)
function textStyle() {
  .width('100%')
  .height('100%')
  .fontSize(18)
  .fontWeight(FontWeight.Bold)
  .textAlign(TextAlign.Center)
  .border({width: 1, color: Color.Green})
  .borderRadius(8)
}

