import StatisticsCard from './StatisticsCard';
import FoodListItem from './FoodListItem'
import { router } from '@kit.ArkUI';
import { RecordGroupModel, RecordModel } from '../../models/RecordModel';
import RecordViewModel from '../../viewmodels/RecordViewModel';
import RecordService from '../../pages/service/RecordService';

@Extend(Text) function greyTextStyle(color:ResourceStr = $r('app.color.light_gray')) {
  .fontSize(14)
  .fontColor(color)
}

//记录
@Component
export default struct RecordIndex {
  @Prop @Watch('handlerPageShow') isPageShow:boolean
  @State groupList:RecordGroupModel[] = RecordViewModel.recordGroupList
  @Provide recordService: RecordService = new RecordService()

  handlerPageShow() {
    if(this.isPageShow) {
      this.aboutToAppear()
    }
  }

  aboutToAppear(): void {
    this.groupList = RecordViewModel.recordGroupList

    let tempService = new RecordService()
    tempService.calculatorRecordData()

    this.recordService = tempService
  }

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
      ForEach(this.groupList, (groupItem:RecordGroupModel) => {
        //组头
        ListItemGroup ({header:this.foodItemHeader(groupItem), footer: this.foodItemFooter()}) {
          //内容
          ForEach(groupItem.info.items,(recordItem:RecordModel) => {
            ListItem() {
              FoodListItem({recordModel: recordItem})
            }
            .onClick(() => {
              console.log(recordItem.info.name.toString())
              router.pushUrl({url: 'pages/detail/RecordIndexDetail', params:recordItem})
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
  @Builder
  foodItemHeader(groupModel:RecordGroupModel) {
    Row({space: 4}) {
      //图标
      Image(groupModel.info.icon).width(24)
      //标题
      Text(groupModel.info.name).fontSize(18).fontWeight(FontWeight.Bold)
      //建议
      Text(`建议${groupModel.info.min}~${groupModel.info.max}千卡`).greyTextStyle()
      Blank()
      //热量
      Text(groupModel.info.calorie?.toFixed(0)).greyTextStyle($r('app.color.primary_color'))
      //单位
      Text('千卡').greyTextStyle()
      //添加按钮
      Image($r('app.media.ic_public_add_norm_filled')).width(20).fillColor($r('app.color.primary_color'))
    }
    .width('100%')
    .padding(15)
    .borderRadius({topLeft: 8, topRight: 8})
    .backgroundColor($r('app.color.stats_title_bgc'))
    .onClick(() => {
      router.pushUrl({
        url:"pages/detail/RecordIndexDetail",
        params:groupModel
      })
    })
  }

  //列表分组组尾
  @Builder
  foodItemFooter() {
    Divider()
      .color('#F1F2F3')
      .strokeWidth(10)
  }

}