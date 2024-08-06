//屏幕常量
import ScreenInfo from '../bean/ScreenInfo'

export default class ScreenConstants {
  /**
   *  小屏设备的标记.
   */
  static readonly SCREEN_SM:string = 'sm'

  /**
   *  中屏设备的标记.
   */
  static readonly SCREEN_MD:string = 'md'

  /**
   *  大屏设备的标记.
   */
  static readonly SCREEN_LG:string = 'lg'

  /**
   * 当前设备屏幕大小存储的 key
   */
  static readonly CURRENT_SCREEN:string = 'currentScreen'

  /**
   * 小屏幕设备宽度范围.
   */
  static readonly RANGE_SM:string = '(320vp<=width<600vp)'

  /**
   * 中屏幕设备宽度范围.
   */
  static readonly RANGE_MD: string = '(600vp<=width<840vp)';

  /**
   * 大屏幕设备宽度范围.
   */
  static readonly RANGE_LG: string = '(840vp<=width)';

  /**
   * tab 导航的位置
   */
  static readonly BAR_POSITION:ScreenInfo<BarPosition> = new ScreenInfo({
    sm: BarPosition.End,
    md: BarPosition.Start,
    lg: BarPosition.Start
  })
}