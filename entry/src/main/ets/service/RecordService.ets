import { CommonConstants } from '../common/constants/CommonConstants'
import { CategoryType, RecordGroupModel, RecordModel, StatisticsModel } from '../models/RecordModel'
import RecordViewModel from '../viewmodels/RecordViewModel'



//记录服务类
export default class RecordService {
  //统计数据模型
  public statisticModel:StatisticsModel = new StatisticsModel({intake:0, consumption:0, carbon:0, protein:0, fat:0, delCalorie:0})

  //推荐
  private recommend:number = CommonConstants.RECOMMEND_CALORIE
  //获取分组数据
  private list = RecordViewModel.recordGroupList


  //计算记录统计数据
  public calculatorRecordData() {
    let totalIntake = 0
    let totalConsumption = 0
    let totalCalorie = 0

    this.list.forEach((group:RecordGroupModel) => {
      if(group.info.type == CategoryType.FOOD) {
        totalIntake += group.info.calorie ?? 0

        if(group.info.items.length > 0) {
          this.calculatorNutrition(group.info.items)
        }
      } else {
        totalConsumption += group.info.calorie ?? 0
      }
    })

    totalCalorie = this.recommend -totalIntake + totalConsumption
    totalCalorie = totalCalorie > this.recommend ? this.recommend : totalCalorie

    this.statisticModel.info.intake = totalIntake
    this.statisticModel.info.consumption = totalConsumption
    this.statisticModel.info.delCalorie = totalCalorie

    console.log('statistic === ', JSON.stringify(this.statisticModel))
  }

  //计算碳水含量,蛋白质含量,脂肪含量
  private calculatorNutrition(list:RecordModel[]) {
    list.forEach((record:RecordModel) => {
      if(record.info.type == CategoryType.FOOD) {
        this.statisticModel.info.carbon += record.info.carbon ?? 0
        this.statisticModel.info.protein += record.info.protein ?? 0
        this.statisticModel.info.fat += record.info.fat ?? 0
      }
    })
  }
}
