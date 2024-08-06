import ScreenConstants from '../../common/constants/ScreenConstants'
import CalorieCard from './CalorieCard'
import NutritionCard from './NutritionCard'
import UPDatePicker from './UPDatePicker'


@Component
export default struct StatisticsCard {
  private swiperController: SwiperController = new SwiperController()
  @StorageProp(ScreenConstants.CURRENT_SCREEN) screenType:string = ScreenConstants.SCREEN_SM

  build() {
    RelativeContainer() {
      //日期选择
      UPDatePicker()
        .alignRules({
          top: {anchor: '__container__', align: VerticalAlign.Top},
          left: {anchor: '__container__', align: HorizontalAlign.Start},
          right: {anchor: '__container__', align: HorizontalAlign.End},
        })
        .id('datePickerId')

      //营养统计
      Swiper(this.swiperController) {
        CalorieCard()
        NutritionCard()
      }
      .width('100%')
      .height(180)
      .displayCount(this.screenType === 'lg' ? 2 : 1)
      .indicator(this.screenType === 'lg' ? false : new DotIndicator().selectedItemWidth(16))
      .alignRules({
        top: {anchor: 'datePickerId', align: VerticalAlign.Bottom},
        left: {anchor: '__container__', align: HorizontalAlign.Start},
        right: {anchor: '__container__', align: HorizontalAlign.End},
      })
      .offset({y: -6})
    }
    .width('100%')
    .height(220)
  }
}