import NavHeader from '../../common/componet/NavHeader'
import { DietSubModel } from '../../models/DietModel'
import FoodListItem from '../record/FoodListItem'

//发现
@Component
export default struct DiscoverPage {
  //饮食列表, 早餐餐/中餐/晚餐/加餐
  private foods:DietSubModel[] = [
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
    },
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
    },
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
    },
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

  build() {
    Column() {
      //头部组件
      NavHeader({title: '发现',color: $r('app.color.primary_color'), tailBuilder: this.tailBuilder})
      //内容组件
      this.ContentBuilder()
    }
    .width('100%')
    .height('100%')
  }


  //头部组件-尾部组件
  @Builder
  tailBuilder() {
    Text('早餐').fontColor(Color.White)
  }

  //内容组件
  @Builder
  ContentBuilder() {
    Tabs() {
      ForEach(['全部','主食','果蔬','肉蛋奶','坚果','其他'], (title:string ,idx:number) => {
        TabContent() {
          this.FoodListBuilder()
        }.tabBar(this.tabBarItem(title))
      })
    }
    .width('100%')
    .layoutWeight(1)
    // .barMode(BarMode.Fixed)
    .onChange((idx:number) => {
      console.log(idx.toString())
    })
  }

  @Builder
  FoodListBuilder() {
    List() {
      ForEach(this.foods, (food:DietSubModel, idx:number) => {
        ListItem() {
          FoodListItem({recordModel: undefined, tailBuilder: this.addBtnBuilder})
        }
        .swipeAction({end:{builder:this.delBtnBuilder, onAction: () => {
            console.log('滑动删除')
        }}})
      })
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }

  //tabBar item
  @Builder
  tabBarItem(title:string) {
    Column({space: 4}) {
      Text(title).fontColor($r('app.color.primary_color'))
      Divider().color($r('app.color.primary_color'))
    }
    .width(50)
  }

  //添加按钮
  @Builder
  addBtnBuilder() {
    Image($r('app.media.ic_public_add_norm_filled'))
      .size({width:24, height: 24})
      .fillColor($r('app.color.primary_color'))
      .objectFit(ImageFit.Contain)
      .onClick(() => {
        console.log('点击添加')
      })
  }

  //删除按钮
  @Builder
  delBtnBuilder() {
   Image($r('app.media.ic_public_delete_filled'))
     .width(90)
     .aspectRatio(2)
     .fillColor(Color.White)
     .backgroundColor(Color.Red)
     .objectFit(ImageFit.Contain)
     .padding(10)
     .margin(5)
     .borderRadius(6)
     .onClick(() => {
       console.log('点击删除')
     })
  }
}