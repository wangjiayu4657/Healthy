import StatisticsCard from './StatisticsCard';
import { DietModel, DietSubModel } from '../../models/DietModel'
import FoodListItem from './FoodListItem'
import { router } from '@kit.ArkUI';

@Extend(Text) function greyTextStyle(color:ResourceStr = $r('app.color.light_gray')) {
  .fontSize(14)
  .fontColor(color)
}

//记录
@Component
export default struct RecordPage {
  static routeUrl: string = 'pages/record/RecordPage'

  //饮食列表, 早餐餐/中餐/晚餐/加餐
  private dietList:DietModel[] = [
    {
      icon: $r('app.media.ic_breakfast'),
      title: '早餐',
      suggest: '建议423~529千卡',
      calory: 190,
      foodList: [
        {
          image: $r('app.media.toast'),
          foodName: '全麦吐司',
          foodCount: '1片',
          calory: 91
        },
        {
          image: $r('app.media.milk'),
          foodName: '牛奶',
          foodCount: "150毫升",
          calory: 99
        }
      ]
    },
    {
      icon: $r('app.media.ic_lunch'),
      title: '午餐',
      suggest: '建议529~761千卡',
      calory: 318,
      foodList: [
        {
          image: $r('app.media.rice'),
          foodName: '米饭',
          foodCount: "1碗",
          calory: 182
        },
        {
          image: $r('app.media.fish'),
          foodName: '鱼肉',
          foodCount: '1条',
          calory: 139
        }
      ]
    },
    {
      icon: $r('app.media.ic_dinner'),
      title: '晚餐',
      suggest: '建议423~529千卡',
      calory: 328,
      foodList: [
        {
          image: $r('app.media.soybean_milk'),
          foodName: '豆浆',
          foodCount: "1碗",
          calory: 98
        },
        {
          image: $r('app.media.pitaya'),
          foodName: '火龙果',
          foodCount: '1个',
          calory: 109
        }
      ]
    },
    {
      icon: $r('app.media.ic_extra_m'),
      title: '加餐',
      suggest: '建议0~169千卡',
      calory: 261,
      foodList: [
        {
          image: $r('app.media.yogurt'),
          foodName: '酸奶',
          foodCount: "1瓶",
          calory: 182
        },
        {
          image: $r('app.media.strawberry'),
          foodName: '草莓',
          foodCount: '10个',
          calory: 127
        }
      ]
    }
  ]

  build() {
    Column({space: 10}) {
      //搜索
      this.SearchHeaderBuilder()
      //统计卡片
      StatisticsCard().width('94%')
      //列表
      this.ListView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F2F3')
  }

  //头部搜索
  @Builder
  SearchHeaderBuilder() {
    Row({space: 10}){
      Search({placeholder:'请输入搜索内容'})
        .layoutWeight(1)

      Badge({count: 10, style: {
        badgeSize: 16
      }}){
        Image($r('app.media.bz_msg'))
          .width(30)
          .objectFit(ImageFit.Contain)
      }
    }
    .width('100%')
    .padding({top: 15, left: 15, right: 15})
  }

  //内容列表
  @Builder
  ListView() {
    List() {
      ForEach(this.dietList, (item:DietModel) => {
        //组头
        ListItemGroup ({header:this.foodItemHeader(item), footer: this.foodItemFooter()}) {
          //内容
          ForEach(item.foodList,(food:DietSubModel) => {
            ListItem() {
              FoodListItem({food: food})
            }
            .onClick(() => {
              console.log(food.foodName)
              router.pushUrl({url: 'pages/detail/RecordIndexDetail', params:food})
            })
          })
        }
      })
    }
    .width('94%')
    .height('100%')
    .layoutWeight(1)
    .sticky(StickyStyle.Header|StickyStyle.Footer)
    .scrollBar(BarState.Off)
  }

  //列表分组组头
  @Builder foodItemHeader(dietModel:DietModel) {
    Row({space: 4}) {
      //图标
      Image(dietModel.icon).width(24)
      //标题
      Text(dietModel.title).fontSize(18).fontWeight(FontWeight.Bold)
      //建议
      Text(dietModel.suggest).greyTextStyle()
      Blank()
      //热量
      Text(dietModel.calory.toFixed(0)).greyTextStyle($r('app.color.primary_color'))
      //单位
      Text('千卡').greyTextStyle()
      //添加按钮
      Image($r('app.media.ic_public_add_norm_filled')).width(20).fillColor($r('app.color.primary_color'))
    }
    .width('100%')
    .padding(15)
    .borderRadius({topLeft: 8, topRight: 8})
    .backgroundColor($r('app.color.stats_title_bgc'))
  }

  //列表分组组尾
  @Builder foodItemFooter() {
    Divider()
      .color('#F1F2F3')
      .strokeWidth(10)
  }

}