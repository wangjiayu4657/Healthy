import mediaquery from '@ohos.mediaquery'
import ScreenConstants from '../constants/ScreenConstants'

//屏幕查询, 判断是否为小/中/大屏
export default class ScreenUtil {
  /**
   * 小屏监听
   */
  private smListener:mediaquery.MediaQueryListener = mediaquery.matchMediaSync(ScreenConstants.RANGE_SM)

  /**
   * 中屏监听
   */
  private mdListener:mediaquery.MediaQueryListener = mediaquery.matchMediaSync(ScreenConstants.RANGE_MD)

  /**
   * 大屏监听
   */
  private lgListener:mediaquery.MediaQueryListener = mediaquery.matchMediaSync(ScreenConstants.RANGE_LG)

  /**
   * 注册监听
   */
  register() {
    this.smListener.on('change', (result:mediaquery.MediaQueryResult) => this.smListenerCallBack(result))
    this.mdListener.on('change', (result:mediaquery.MediaQueryResult) => this.mdListenerCallBack(result))
    this.lgListener.on('change', (result:mediaquery.MediaQueryResult) => this.lgListenerCallBack(result))
  }

  /**
   * 取消注册监听
   */
  unregister() {
    this.smListener.off('change', (result:mediaquery.MediaQueryResult) => this.smListenerCallBack(result))
    this.mdListener.off('change', (result:mediaquery.MediaQueryResult) => this.mdListenerCallBack(result))
    this.lgListener.off('change', (result:mediaquery.MediaQueryResult) => this.lgListenerCallBack(result))
  }

  /**
   * 小屏监听回调
   */
  smListenerCallBack(result:mediaquery.MediaQueryResult) {
    if(result.matches) {
      this.updateCurrentScreen(ScreenConstants.SCREEN_SM)
    }
  }

  /**
   * 中屏监听回调
   */
  mdListenerCallBack(result:mediaquery.MediaQueryResult) {
    if(result.matches) {
      this.updateCurrentScreen(ScreenConstants.SCREEN_MD)
    }
  }

  /**
   * 大屏监听回调
   */
  lgListenerCallBack(result:mediaquery.MediaQueryResult) {
    if(result.matches) {
      this.updateCurrentScreen(ScreenConstants.SCREEN_LG)
    }
  }

  /**
   * 更新并保存屏幕类型(小/中/大)
   */
  updateCurrentScreen(screen:string) {
    AppStorage.setOrCreate(ScreenConstants.CURRENT_SCREEN, screen)
  }
}