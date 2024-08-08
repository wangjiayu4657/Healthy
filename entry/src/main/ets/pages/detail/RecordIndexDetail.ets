import NavHeader from '../../common/componet/NavHeader'
import FoodListItem from '../../views/record/FoodListItem'
import OperationPanel from '../../views/record/OperationPanel'
import RecordViewModel  from '../../viewmodels/RecordViewModel'
import { CategoryType, RecordGroupModel, RecordModel, TabModel } from '../../models/RecordModel'
import { router } from '@kit.ArkUI'

//发现
@Entry
@Component
struct RecordIndexDetail {
  @State selIdx:number = 0
  @State isShow:boolean = false
  @State item:RecordModel = RecordViewModel.recordList[0]

  //饮食列表, 早餐餐/中餐/晚餐/加餐
  @State source:RecordModel[] = RecordViewModel.recordList

  private tabs:TabModel[] = RecordViewModel.foodTabList
  private type:CategoryType = CategoryType.FOOD
  private groupItem:RecordGroupModel = router.getParams() as RecordGroupModel

  aboutToAppear(): void {
    this.type = this.groupItem.info.type
    this.source = (this.type === CategoryType.FOOD) ? RecordViewModel.foodList : RecordViewModel.sportList
    this.tabs = (this.type === CategoryType.FOOD) ? RecordViewModel.foodTabList : RecordViewModel.sportTabList
  }


  build() {
    Column() {
      //头部组件
      NavHeader({
        title: '详情',
        color: $r('app.color.primary_color'),
        tailBuilder:() => { this.tailBuilder() }
      })

      //内容组件
      this.contentBuilder()
    }
    .width('100%')
    .height('100%')
    .bindSheet($$this.isShow, this.operationPanelBuilder(),{
      detents:[SheetSize.LARGE],
      backgroundColor:Color.Gray,
      blurStyle:BlurStyle.Thick,
      showClose:false,
      preferType: SheetType.CENTER,
      shouldDismiss:((sheetDismiss: SheetDismiss)=> {
        console.log("bind sheet shouldDismiss")
        sheetDismiss.dismiss()
      }),
    })
  }

  //头部组件-尾部组件
  @Builder
  tailBuilder() {
    Text(this.groupItem.info.name).fontColor(Color.White)
  }

  //内容组件
  @Builder
  contentBuilder() {
    Tabs() {
      ForEach(this.tabs, (tab:TabModel ,idx:number) => {
        TabContent() {
          this.foodListBuilder()
        }.tabBar(this.tabBarItem(tab.info.name, idx))
      })
    }
    .width('100%')
    .layoutWeight(1)
    .barMode(this.tabs.length > 6 ? BarMode.Scrollable : BarMode.Fixed)
    .onChange((idx:number) => {
      this.selIdx = idx
      let tab:TabModel = this.tabs[idx]
      this.source = RecordViewModel.filterRecordListBy(this.type, tab.info.id)
    })
  }

  //列表组件
  @Builder
  foodListBuilder() {
    List() {
      ForEach(this.source, (recordModel:RecordModel) => {
        ListItem() {
          FoodListItem({recordModel: recordModel, tailBuilder: () => { this.addBtnBuilder(recordModel) }})
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
  tabBarItem(title:ResourceStr, idx:number) {
    Column({space: 4}) {
      Text(title).fontColor(this.selIdx == idx ? $r('app.color.primary_color') : $r('app.color.light_gray'))
      Divider().color(this.selIdx == idx ? $r('app.color.primary_color') : Color.Transparent)
    }
    .width(80)
  }

  //添加按钮
  @Builder
  addBtnBuilder(record:RecordModel) {
    Image($r('app.media.ic_public_add_norm_filled'))
      .size({width:24, height: 24})
      .fillColor($r('app.color.primary_color'))
      .objectFit(ImageFit.Contain)
      .onClick(() => {
        this.isShow = true
        console.log('点击添加', this.isShow)
        this.item = record
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

  //操作面板
  @Builder operationPanelBuilder() {
    Column() {
      OperationPanel({
        recordModel: this.item,
        cancel:() => {
          this.isShow = false
        },
        submit:(amount:number) => {
          console.log('amount == ', amount)
          this.isShow = false
        }
      })
    }
    .width('100%')
  }
}