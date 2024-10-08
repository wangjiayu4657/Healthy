import { router } from '@kit.ArkUI'

@Component
export default struct NavHeader {
  title?: ResourceStr
  btnTitle?: ResourceStr
  bgColor?:ResourceStr = '#36D'

  @BuilderParam headBuilder: () => void = this.backBtn
  @BuilderParam tailBuilder: () => void = this.moreBtn

  callBack?: () => void

  build() {
    Row() {
      //左边组件
      this.headBuilder()
      Blank()
      //标题组件
      this.navTitle()
      Blank()
      //右边组件
      this.tailBuilder()
    }
    .width('100%')
    .height(80)
    .padding({left: 5, right: 15})
    .backgroundColor(this.bgColor)
    .justifyContent(FlexAlign.SpaceAround)
  }

  //返回按钮
  @Builder backBtn() {
    Button() {
      Image($r("app.media.ic_public_back"))
        .width(30)
        .height(30)
        .fillColor(Color.White)
        .objectFit(ImageFit.Contain)
    }
    .backgroundColor(Color.Transparent)
    .onClick(() => router.back())
  }

  //导航标题
  @Builder navTitle() {
    Text(this.title)
      .fontSize(30)
      .fontWeight(FontWeight.Bold)
      .fontColor(Color.White)
  }

  //更多按钮
  @Builder moreBtn() {
    Button(this.btnTitle ?? '更多',{type: ButtonType.Normal})
      .width(80)
      .fontSize(16)
      .fontColor(Color.White)
      .fontWeight(FontWeight.Medium)
      .backgroundColor(Color.Transparent)
      .borderRadius(5)
      .onClick(() => {
        console.log('点击更多')
        this.callBack ? this.callBack() : null;
      })
  }
}