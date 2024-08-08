import { ColumnInfo, ColumnType } from '../common/bean/ColumnInfo'
import { CategoryType, RecordModel, CategoryId, RecordGroupModel, TabModel } from '../models/RecordModel'

const COLUMNS: ColumnInfo[] = [
  {name: 'id', columnName: 'id', type: ColumnType.LONG},
  {name: 'typeId', columnName: 'type_id', type: ColumnType.LONG},
  {name: 'itemId', columnName: 'item_id', type: ColumnType.LONG},
  {name: 'amount', columnName: 'amount', type: ColumnType.DOUBLE},
  {name: 'createTime', columnName: 'create_time', type: ColumnType.LONG}
]

// const TABLE_NAME = 'record'
// const ID_COLUMN = 'id'
// const DATE_COLUMN = 'create_time'


class RecordViewModel {
   //食物数组
   foodList: RecordModel[] = [
     new RecordModel({id:0, name:'米饭', image:$r('app.media.rice'), type:CategoryType.FOOD, categoryId:CategoryId.STAPLE, unit:'碗', calorie:209, carbon:46.6, protein:4.7, fat:0.5, count:0}),
     new RecordModel({id:1, name:'馒头', image:$r('app.media.steamed_bun'), type:CategoryType.FOOD, categoryId:CategoryId.STAPLE, unit:'个', calorie: 188, carbon:35.2, protein:5.0, fat:3.1, count:0}),
     new RecordModel({id:2, name:'面包', image:$r('app.media.bun'), type:CategoryType.FOOD, categoryId:CategoryId.STAPLE, unit: '个', calorie: 188, carbon:35.2, protein:5.0, fat:3.1, count:0}),
     new RecordModel({id:3, name:'全麦吐司', image:$r('app.media.toast'), type:CategoryType.FOOD, categoryId:CategoryId.STAPLE, unit: '片', calorie: 91, carbon:15.5, protein:4.4, fat:1.3, count:0}),
     new RecordModel({id:4, name:'紫薯', image:$r('app.media.purple_potato'), type:CategoryType.FOOD, categoryId:CategoryId.STAPLE, unit: '个', calorie: 163, carbon:42.0, protein:1.6, fat:0.4, count:0}),
     new RecordModel({id:5, name:'煮玉米', image:$r('app.media.corn'), type:CategoryType.FOOD, categoryId:CategoryId.STAPLE, unit: '根', calorie: 111, carbon:22.6, protein:4.0, fat:1.2, count:0}),
     new RecordModel({id:6, name:'黄瓜', image:$r('app.media.cucumber'), type:CategoryType.FOOD, categoryId:CategoryId.FRUIT, unit: '根', calorie: 29, carbon:5.3, protein:1.5, fat:0.4, count:0}),
     new RecordModel({id:7, name:'蓝莓', image:$r('app.media.blueberry'), type:CategoryType.FOOD, categoryId:CategoryId.FRUIT, unit: '盒', calorie: 71, carbon:18.1, protein:0.9, fat:0.4, count:0}),
     new RecordModel({id:8, name:'草莓', image:$r('app.media.strawberry'), type:CategoryType.FOOD, categoryId:CategoryId.FRUIT, unit: '颗', calorie: 14, carbon:3.1, protein:0.4, fat:0.1, count:0}),
     new RecordModel({id:9, name:'火龙果', image:$r('app.media.pitaya'), type:CategoryType.FOOD, categoryId:CategoryId.FRUIT, unit: '个', calorie: 100, carbon:24.6, protein:2.2, fat:0.5, count:0}),
     new RecordModel({id:10, name:'奇异果', image:$r('app.media.kiwi'), type:CategoryType.FOOD, categoryId:CategoryId.FRUIT, unit: '个', calorie: 25, carbon:8.4, protein:0.5, fat:0.3, count:0}),
     new RecordModel({id:11, name:'煮鸡蛋', image:$r('app.media.egg'), type:CategoryType.FOOD, categoryId:CategoryId.MEAT, unit: '个', calorie: 74, carbon:0.1, protein:6.2, fat:5.4, count:0}),
     new RecordModel({id:12, name:'煮鸡胸肉', image:$r('app.media.chicken_breast'), type: CategoryType.FOOD, categoryId: CategoryId.MEAT, unit:'克', calorie:1.15, carbon:0.011, protein:0.236, fat:0.018, count:0}),
     new RecordModel({id:13, name:'煮鸡腿肉', image:$r('app.media.chicken_leg'), type: CategoryType.FOOD, categoryId: CategoryId.MEAT, unit:'克', calorie:1.87, carbon:0.0, protein:0.243, fat:0.092, count:0}),
     new RecordModel({id:14, name:'牛肉', image:$r('app.media.beef'), type: CategoryType.FOOD, categoryId: CategoryId.MEAT, unit:'克', calorie:1.22, carbon:0.0, protein:0.23, fat:0.033, count:0}),
     new RecordModel({id:15, name:'鱼肉', image:$r("app.media.fish"), type: CategoryType.FOOD, categoryId: CategoryId.MEAT, unit:'克', calorie:1.04, carbon:0.0, protein:0.206, fat:0.024, count:0}),
     new RecordModel({id:16, name:'牛奶', image:$r("app.media.milk"), type: CategoryType.FOOD, categoryId: CategoryId.MEAT, unit:'毫升', calorie:0.66, carbon:0.05, protein:0.03, fat:0.038, count:0}),
     new RecordModel({id:17, name:'酸奶', image:$r("app.media.yogurt"), type: CategoryType.FOOD, categoryId: CategoryId.MEAT, unit:'毫升', calorie:0.7, carbon:0.10, protein:0.032, fat:0.019, count:0}),
     new RecordModel({id:18, name:'核桃', image:$r("app.media.walnut"), type: CategoryType.FOOD, categoryId: CategoryId.NUT, unit:'颗', calorie:42, carbon:1.2, protein:1.0, fat:3.8, count:0}),
     new RecordModel({id:19, name:'花生', image:$r("app.media.peanut"), type: CategoryType.FOOD, categoryId: CategoryId.NUT, unit:'克', calorie:3.13, carbon:0.13, protein:0.12, fat:0.254, count:0}),
     new RecordModel({id:20, name:'腰果', image:$r("app.media.cashew"), type: CategoryType.FOOD, categoryId: CategoryId.NUT, unit:'克', calorie:5.59, carbon:0.416, protein:0.173, fat:0.367, count:0}),
     new RecordModel({id:21, name:'无糖拿铁', image:$r("app.media.coffee"), type: CategoryType.FOOD, categoryId: CategoryId.OTHER, unit:'毫升', calorie:0.43, carbon:0.044, protein:0.028, fat:0.016, count:0}),
     new RecordModel({id:22, name:'豆浆', image:$r("app.media.soybean_milk"), type: CategoryType.FOOD, categoryId: CategoryId.OTHER, unit:'毫升', calorie:0.31, carbon:0.012, protein:0.030, fat:0.016, count:0})
   ]

  //运动数组
   sportList: RecordModel[] = [
     new RecordModel({id:1, name:'散步', image:$r('app.media.ic_walk'), type:CategoryType.SPORT, categoryId:CategoryId.WALKING, unit:'小时', calorie:111, count:0}),
     new RecordModel({id:2, name:'快走', image:$r('app.media.ic_walk'), type:CategoryType.SPORT, categoryId:CategoryId.WALKING, unit:'小时',  calorie:343, count:0}),
     new RecordModel({id:3, name:'慢跑', image:$r('app.media.ic_running'), type:CategoryType.SPORT, categoryId:CategoryId.RUNNING, unit:'小时',  calorie:472, count:0}),
     new RecordModel({id:4, name:'快跑', image:$r('app.media.ic_running'), type:CategoryType.SPORT, categoryId:CategoryId.RUNNING, unit:'小时',  calorie:652, count:0}),
     new RecordModel({id:5, name:'自行车', image:$r('app.media.ic_ridding'), type:CategoryType.SPORT, categoryId:CategoryId.RIDING, unit:'小时',  calorie:497, count:0}),
     new RecordModel({id:6, name:'动感单车', image:$r('app.media.ic_ridding'), type:CategoryType.SPORT, categoryId:CategoryId.RIDING, unit:'小时',  calorie:587, count:0}),
     new RecordModel({id:7, name:'瑜伽', image:$r('app.media.ic_aerobics'), type:CategoryType.SPORT, categoryId:CategoryId.AEROBICS, unit:'小时',  calorie:172, count:0}),
     new RecordModel({id:8, name:'健身操', image:$r('app.media.ic_aerobics'), type:CategoryType.SPORT, categoryId:CategoryId.AEROBICS, unit:'小时',  calorie:429, count:0}),
     new RecordModel({id:9, name:'游泳', image:$r('app.media.ic_swimming'), type:CategoryType.SPORT, categoryId:CategoryId.SWIMMING, unit:'小时',  calorie:472, count:0}),
     new RecordModel({id:10, name:'冲浪', image:$r('app.media.ic_swimming'), type:CategoryType.SPORT, categoryId:CategoryId.SWIMMING, unit:'小时',  calorie:429, count:0}),
     new RecordModel({id:11, name:'篮球', image:$r('app.media.ic_basketball'), type:CategoryType.SPORT, categoryId:CategoryId.BALLGAME, unit:'小时',  calorie:472, count:0}),
     new RecordModel({id:12, name:'足球', image:$r('app.media.ic_football'), type:CategoryType.SPORT, categoryId:CategoryId.BALLGAME, unit:'小时',  calorie:515, count:0}),
     new RecordModel({id:13, name:'排球', image:$r("app.media.ic_volleyball"), type:CategoryType.SPORT, categoryId:CategoryId.BALLGAME, unit:'小时',  calorie:403, count:0}),
     new RecordModel({id:14, name:'羽毛球', image:$r("app.media.ic_badminton"), type:CategoryType.SPORT, categoryId:CategoryId.BALLGAME, unit:'小时',  calorie:386, count:0}),
     new RecordModel({id:15, name:'乒乓球', image:$r("app.media.ic_table_tennis"), type:CategoryType.SPORT, categoryId:CategoryId.BALLGAME, unit:'小时',  calorie:257, count:0}),
     new RecordModel({id:16, name:'哑铃飞鸟', image:$r("app.media.ic_dumbbell"), type:CategoryType.SPORT, categoryId:CategoryId.STRENGTH, unit:'小时',  calorie:343, count:0}),
     new RecordModel({id:17, name:'哑铃卧推', image:$r("app.media.ic_dumbbell"), type:CategoryType.SPORT, categoryId:CategoryId.STRENGTH, unit:'小时',  calorie:429, count:0}),
     new RecordModel({id:28, name:'仰卧起坐', image:$r("app.media.ic_sit_up"), type:CategoryType.SPORT, categoryId:CategoryId.STRENGTH, unit:'小时',  calorie:515, count:0})
   ]

   //记录数组(食物与运动混合的数组)
   recordList:RecordModel[] = this.foodList.concat(this.sportList)

   //分组数据源
   recordGroupList:RecordGroupModel[] = [
     new RecordGroupModel({id:0, type:CategoryType.FOOD, name:$r("app.string.breakfast"), icon:$r("app.media.ic_breakfast"), min:423, max:592, calorie:0, items:[]}),
     new RecordGroupModel({id:1, type:CategoryType.FOOD, name:$r("app.string.lunch"), icon:$r("app.media.ic_lunch"), min:592, max:761, calorie:0, items:[]}),
     new RecordGroupModel({id:2, type:CategoryType.FOOD, name:$r("app.string.dinner"), icon:$r("app.media.ic_dinner"), min:423, max:592, calorie:0, items:[]}),
     new RecordGroupModel({id:3, type:CategoryType.FOOD, name:$r("app.string.extra_meal"), icon:$r("app.media.ic_extra_m"), min:0, max:169, calorie:0, items:[]}),
     new RecordGroupModel({id:4, type:CategoryType.SPORT, name:$r("app.string.workout"), icon:$r("app.media.ic_workout"), min:0, max:0, calorie:0, items:[]})
   ]

   //食物tab数据源
   foodTabList:TabModel[] = [
     new TabModel({id:-1, name:'全部'}),
     new TabModel({id:CategoryId.STAPLE, name:$r('app.string.staple')}),
     new TabModel({id:CategoryId.FRUIT, name:$r('app.string.fruit')}),
     new TabModel({id:CategoryId.MEAT, name:$r('app.string.meat')}),
     new TabModel({id:CategoryId.NUT, name:$r('app.string.nut')}),
     new TabModel({id:CategoryId.OTHER, name:$r('app.string.other_type')})
   ]

  //运动tab数据源
   sportTabList:TabModel[] = [
     new TabModel({id:-1, name:'全部'}),
     new TabModel({id:CategoryId.WALKING, name:$r('app.string.walking_type')}),
     new TabModel({id:CategoryId.RUNNING, name:$r('app.string.running')}),
     new TabModel({id:CategoryId.RIDING, name:$r('app.string.riding')}),
     new TabModel({id:CategoryId.AEROBICS, name:$r('app.string.aerobics')}),
     new TabModel({id:CategoryId.SWIMMING, name:$r('app.string.swimming')}),
     new TabModel({id:CategoryId.BALLGAME, name:$r('app.string.ballgame')}),
     new TabModel({id:CategoryId.STRENGTH, name:$r('app.string.strength')})
   ]

   /**
    * 过滤数据
    * @param type: 分类的类型
    * @param categoryId: 分类id
    */
   filterRecordListBy(type:CategoryType, categoryId:number): RecordModel[] {
     let list = type == CategoryType.FOOD ? this.foodList : this.sportList
     if(categoryId == -1) {
        return list
     } else  {
       let result = list.filter((recordItem:RecordModel) => recordItem.info.categoryId == categoryId)
       console.log(`type == ${type}  categoryId == ${categoryId}  count == ${result.length}`)
       return result
     }
   }

   insertRecord(recordModel:RecordModel, groupId:number) {
     if (typeof recordModel === 'undefined') { return }

     let groupItem = this.recordGroupList.find((groupItem:RecordGroupModel) => groupItem.info.id == groupId)
     if(typeof groupItem === 'undefined') return

     let items = groupItem?.info.items
     if(typeof items === 'undefined') return

     let recordItem = items.find((item:RecordModel) => item.info.id == recordModel.info.id)

     if(typeof recordItem !== 'undefined') {
       let count = recordModel?.info.count ?? 0
       recordItem.info.count += count
     } else {
       items?.push(recordModel)
     }

     groupItem.info.calorie = this.calculatingData(items)
   }

   calculatingData(records:RecordModel[]) {
      let totalCalorie = 0
      records.forEach((record:RecordModel) => {
        totalCalorie = (record.info.count ?? 1) * ((record.info.carbon ?? 0) + (record.info.protein ?? 0) + (record.info.fat ?? 0))
      })
     return totalCalorie
   }
}

const recordViewModel:RecordViewModel = new RecordViewModel()
export default recordViewModel as RecordViewModel