import { LengthUnit } from '@ohos.arkui.node'

//用户隐私协议
@CustomDialog
export default struct PrivateProtocolDialog {
  controller?:CustomDialogController
  //不同意回调
  disAgree?:() => void
  //同意回调
  agree?:() => void

  build() {
    Column({space: 15}) {
      Text($r('app.string.user_privacy_title'))
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      Text($r('app.string.user_privacy_content'))
        .fontSize(16)
        .lineSpacing({value:6, unit:LengthUnit.VP})

      Row(){
        Button('不同意')
          .btnStyle($r('app.color.lightest_primary_color'))
          .fontColor($r('app.color.light_gray'))
          .onClick(() => {
            this.disAgree ? this.disAgree() : null
            this.controller?.close()
          })

        Button('同意')
          .btnStyle($r('app.color.primary_color'))
          .onClick(() => {
            this.agree ? this.agree() : null
            this.controller?.close()
          })

      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .padding(15)
    .borderRadius(8)
    .backgroundColor(Color.White)
  }
}

//按钮样式
@Extend(Button) function btnStyle(color:ResourceStr) {
  .width(100)
  .fontSize(16)
  .fontWeight(FontWeight.Bold)
  .backgroundColor(color)
}