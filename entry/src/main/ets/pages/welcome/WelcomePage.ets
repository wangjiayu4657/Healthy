import { CommonConstants } from '../../common/constants/CommonConstants'
import PreferencesUtil from '../../common/utils/PreferencesUtil'
import PrivateProtocolDialog from '../../views/welcome/PrivateProtocolDialog'
import { JSON } from '@kit.ArkTS'
import { router } from '@kit.ArkUI'
import IndexPage from '../main/IndexPage'
import { common } from '@kit.AbilityKit'


//用户隐私协议同意状态
const PRIVATE_PROTOCOL_STATE = 'private_protocol_state'

//欢迎页
@Entry
@Component
struct WelcomePage {
  //隐私弹窗
  private dialogCtrl:CustomDialogController = new CustomDialogController({
    builder:PrivateProtocolDialog({
      agree: this.agree,
      disAgree: this.disAgree
    })
  })

  async aboutToAppear() {
    let state = await PreferencesUtil.fetch(CommonConstants.PREFERENCE_NAME,PRIVATE_PROTOCOL_STATE,false)
    console.log('testTag', state)
    if(state) {
      router.replaceUrl({url: IndexPage.routeName})
    } else {
      this.dialogCtrl.open()
    }
  }

  agree() {
    PreferencesUtil.save(CommonConstants.PREFERENCE_NAME,PRIVATE_PROTOCOL_STATE,true)
      .then(() => console.log('testTag','用户隐私协议同意状态保存成功'))
      .catch((err:object) => console.log('testTag','用户隐私协议同意状态保存失败err:',JSON.stringify(err)))

    //跳转首页
    router.replaceUrl({url: IndexPage.routeName})
  }

  disAgree() {
    let ctx = getContext(this) as common.UIAbilityContext
    ctx.terminateSelf()
  }


  build() {
    Column({space:15}) {
      //slogan
      Image($r('app.media.home_slogan'))
        .width(260)
        .objectFit(ImageFit.Contain)
        .layoutWeight(1)

      //logo
      Image($r('app.media.home_logo')).width(150)

      Row({space: 4}) {
        Text('黑马健康支持').textStyle(14)

        Text('IPv6')
          .textStyle(12)
          .padding({left: 6, right: 6})
          .border({width:1, color:$r('app.color.lightest_primary_color'), style:BorderStyle.Solid, radius: 8})

        Text('网络').textStyle(14)
      }
      .justifyContent(FlexAlign.Center)

      //描述
      Text($r('app.string.EntryAbility_desc')).textStyle(12, 0.6)

      //备案号
      Text('浙ICP备000000号-36D')
        .textStyle(10, 0.4)
        .padding({bottom: 15})
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.primary_color'))
  }
}

@Extend (Text) function textStyle(fontSize:number = 14, opacity:number = 0.8) {
  .fontSize(fontSize)
  .fontColor($r('app.color.lightest_primary_color'))
  .opacity(opacity)
}