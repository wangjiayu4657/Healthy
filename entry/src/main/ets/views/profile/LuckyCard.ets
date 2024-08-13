import { CardModel } from '../../models/CardModel'

//抽卡
@Component
export default struct LuckyCard {
  @ObjectLink card:CardModel

  build() {
    Badge({
      count: this.card.count,
      position:BadgePosition.RightTop,
      style: {fontSize: 14}
    }) {
      Image($r(this.card.url)).objectFit(ImageFit.Cover)
    }
  }
}