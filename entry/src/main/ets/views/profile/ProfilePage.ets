import { CardModel } from '../../models/CardModel'
import LuckyCard from './LuckyCard'
import { JSON } from '@kit.ArkTS'

//我的
@Component
export default struct ProfilePage {
  //奖品
  prizes?:ResourceStr = undefined
  //抽卡
  @State cards:CardModel[] = [
    new CardModel('app.media.bg_00', 0),
    new CardModel('app.media.bg_01', 0),
    new CardModel('app.media.bg_02', 0),
    new CardModel('app.media.bg_03', 0),
    new CardModel('app.media.bg_04', 0),
    new CardModel('app.media.bg_05', 0),
  ]

  //弹窗
  maskDialog:CustomDialogController = new CustomDialogController({
    builder: MaskDialog({
      prizes:this.prizes,
      confirm: (count:number, isAgain:boolean) => {
        this.maskDialog.close()
        if(isAgain) {  //再来一次
          this.handlerAgain()
        } else {
          this.startDrawing(count)
        }
      }
    }),
    maskColor: '#bf000000',
    openAnimation:{ duration: 300, curve:Curve.EaseInOut },
    closeAnimation:{ duration: 300, curve:Curve.EaseInOut }
  })

  build() {
    Column() {
      //抽奖卡片
      Grid() {
        ForEach(this.cards, (card:CardModel) => {
          GridItem() {
            LuckyCard({card: card})
          }
        })
      }
      .width('100%')
      .height(310)
      .padding(20)
      .margin({top: 120, bottom: 45})
      .columnsTemplate('1fr 1fr 1fr')
      .columnsGap(40)
      .rowsGap(40)

      //抽奖按钮
      Button('立即抽奖')
        .width(180)
        .backgroundColor('#F14E8D')
        .onClick(() => {
          console.log('开始抽奖')
          this.maskDialog.open()
        })
    }
    .width('100%')
    .height('100%')
  }

  //开始抽奖
  startDrawing(count:number) {
    let card = this.cards[count]
    card.count += 1
    card.url = `app.media.img_0${count}`

    //判断是否获取大奖
    this.handlerPrizes()
  }

  //获取大奖
  handlerPrizes() {
    let filterList = this.cards.filter((card:CardModel) => card.count == 0)

    if(filterList.length == 0) {
      //奖池
      let prizesList = [$r('app.media.pg'), $r('app.media.hw'), $r('app.media.xm')]
      //随机数
      let count = Math.floor(Math.random() * 3)
      //获取奖品
      this.prizes = prizesList[count]

      //展示中奖奖品
      this.maskDialog.open()
    }
  }

  //再来一次
  handlerAgain() {
    this.prizes = undefined

    for (let index = 0; index < this.cards.length; index++) {
      let card = this.cards[index];
      card.count = 0
      card.url = `app.media.bg_0${index}`
    }
  }
}


@CustomDialog
struct MaskDialog {
  //随机数, 用于生成抽将的卡片
  count:number = -1
  //奖品图片地址
  prizes?: ResourceStr
  //回调
  confirm?:(count:number, isAgain:boolean) => void
  //弹窗控制器
  controller?: CustomDialogController


  build() {
    Column({space: 30}) {
      Text(this.prizes ? '恭喜获得手机一部' : '获得生肖卡')
        .fontSize(18)
        .fontColor('#BFBAAC')
        .fontWeight(FontWeight.Bold)

      Image(this.prizes ?? this.handlerImage())
        .width(260)

      Button(this.prizes ? '再来一次' : '开心收下')
        .width(140)
        .height(40)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .borderRadius(20)
        .border({width:1, color:'#BFBAAC'})
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.count = this.prizes ? -1 : this.count
          this.confirm ? this.confirm(this.count, this.prizes != undefined) : null;
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#bf000000')
    .justifyContent(FlexAlign.Center)
  }

  handlerImage():ResourceStr {
    let count = Math.floor(Math.random() * 6)
    let imgPath = `app.media.img_0${count}`
    this.count = count
    return $r(imgPath)
  }
}
