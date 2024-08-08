
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
  //声明的变量
  info: RecordInfo

  constructor(recordInfo:RecordInfo) {
    this.info = recordInfo
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
  info:RecordGroupInfo

  constructor(recordGroupInfo: RecordGroupInfo) {
    this.info = recordGroupInfo
  }
}

//声明tab接口字段
declare interface TabInfo {
  id:CategoryId
  name:ResourceStr
}

//tab数据模型
export class TabModel {
  info:TabInfo

  constructor(tabInfo:TabInfo) {
    this.info = tabInfo
  }
}