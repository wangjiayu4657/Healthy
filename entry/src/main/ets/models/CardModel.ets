
declare interface CardInfo {
  url:string
  count: number
}

@Observed
export class CardModel implements CardInfo {
  url:string
  count: number

  constructor(url:string, count:number) {
    this.url = url
    this.count = count
  }
}

// export interface DietModel {
//   //图标
//   icon:ResourceStr
//   //标题
//   title:ResourceStr
//   //建议
//   suggest: string
//   //热量
//   calory:number
//   //食物列表
//   foodList?: DietSubModel[]
// }

// export interface DietSubModel {
//   //图片地址
//   image:ResourceStr
//   //食物名称
//   foodName:string
//   //食物数量
//   foodCount:string
//   //热量
//   calory:number
// }