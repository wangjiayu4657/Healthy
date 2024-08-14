
//类型
export enum CategoryType {
  FOOD,    //食物
  SPORT    //运动
}

//食物类型枚举
export enum CategoryId {
  STAPLE = 0,  //主食
  FRUIT,       //蔬果
  MEAT,        //肉蛋奶
  NUT,         //坚果
  WALKING,     //走路
  RUNNING,     //跑步
  RIDING,      //骑行
  AEROBICS,    //跳操
  SWIMMING,    //游泳
  BALLGAME,    //打球
  STRENGTH,    //力量训练
  OTHER,       //其它
}


//声明记录数据模型的属性接口
declare interface RecordInfo {
  id: number             //id
  name: ResourceStr      //名称
  image: ResourceStr     //图片
  type: CategoryType     //类型
  categoryId: number     //分类id
  calorie: number        //卡路里
  unit: ResourceStr      //单位
  count: number          //数量
  carbon?: number        //碳水含量，单位（克)
  protein?: number       //蛋白质含量，单位（克）
  fat?: number           //脂肪含量，单位（克）
}

//记录数据模型
export class RecordModel  {
  id: number             //id
  name: ResourceStr      //名称
  image: ResourceStr     //图片
  type: CategoryType     //类型
  categoryId: number     //分类id
  calorie: number        //卡路里
  unit: ResourceStr      //单位
  count: number          //数量
  carbon?: number        //碳水含量，单位（克)
  protein?: number       //蛋白质含量，单位（克）
  fat?: number           //脂肪含量，单位（克）

  constructor(recordInfo:RecordInfo) {
    this.id = recordInfo.id
    this.name = recordInfo.name
    this.image = recordInfo.image
    this.type = recordInfo.type
    this.categoryId = recordInfo.categoryId
    this.calorie = recordInfo.calorie
    this.unit = recordInfo.unit
    this.count = recordInfo.count
    this.carbon = recordInfo.carbon
    this.protein = recordInfo.protein
    this.fat = recordInfo.fat
  }
}


//声明分组信息的属性接口
declare interface RecordGroupInfo {
  id: number                //id
  type: CategoryType        //类型
  name: ResourceStr         //名称
  icon: ResourceStr         //图标
  min: number               //推荐最小卡路里
  max: number               //推荐最大卡路里
  items: RecordModel[]      //分组下的数据
  calorie?: number          //组内记录的总热量
}

//分组信息数据模型
export class RecordGroupModel {
  id: number                //id
  type: CategoryType        //类型
  name: ResourceStr         //名称
  icon: ResourceStr         //图标
  min: number               //推荐最小卡路里
  max: number               //推荐最大卡路里
  items: RecordModel[]      //分组下的数据
  calorie?: number          //组内记录的总热量

  constructor(recordGroupInfo: RecordGroupInfo) {
    this.id = recordGroupInfo.id
    this.type = recordGroupInfo.type
    this.name = recordGroupInfo.name
    this.icon = recordGroupInfo.icon
    this.min = recordGroupInfo.min
    this.max = recordGroupInfo.max
    this.items = recordGroupInfo.items
    this.calorie = recordGroupInfo.calorie
  }
}

//声明tab接口字段
declare interface TabInfo {
  id:CategoryId
  name:ResourceStr
}

//tab数据模型
export class TabModel {
  id:CategoryId
  name:ResourceStr

  constructor(tabInfo:TabInfo) {
    this.id = tabInfo.id
    this.name = tabInfo.name
  }
}


//声明统计数据接口字段
declare interface StatisticsInfo {
  intake:number          //摄入量
  consumption:number     //消耗量
  carbon: number        //碳水含量，单位（克)
  protein: number       //蛋白质含量，单位（克）
  fat: number           //脂肪含量，单位（克）
  delCalorie:number      //剩余摄入量
}

//统计数据模型
export class StatisticsModel {
  intake:number          //摄入量
  consumption:number     //消耗量
  carbon: number        //碳水含量，单位（克)
  protein: number       //蛋白质含量，单位（克）
  fat: number           //脂肪含量，单位（克）
  delCalorie:number      //剩余摄入量

  constructor(statisticsInfo:StatisticsInfo) {
    this.intake = statisticsInfo.intake
    this.consumption = statisticsInfo.consumption
    this.carbon = statisticsInfo.carbon
    this.protein = statisticsInfo.protein
    this.fat = statisticsInfo.fat
    this.delCalorie = statisticsInfo.delCalorie
  }
}

// declare interface MyOptions {
//   name:string
//   age:number
// }
//
// declare class MyAttribute extends CommonMethod<MyAttribute> {
//   space(value:number): MyAttribute;
// }
//
// declare interface MyInterface {
//   (value?: MyOptions): MyAttribute;
// }
//
// declare const MyComp:MyInterface;