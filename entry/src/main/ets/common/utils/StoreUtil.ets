import relationalStore from '@ohos.data.relationalStore';
import { Context } from '@kit.AbilityKit';
import { JSON } from '@kit.ArkTS';

//数据库存储
class StoreUtil {
  private dbStore?:relationalStore.RdbStore

  /*
   * 初始化数据库
   */
  async initStore(context:Context, tableName:string, sql:string) {
    //数据库配置
    const config:relationalStore.StoreConfig = {
      name:`application_${tableName}.db`,
      securityLevel:relationalStore.SecurityLevel.S1
    }

    try {
      //获取数据库
      let db = await relationalStore.getRdbStore(context,config)
      //执行sql语句
      db.execute(sql)
      //保存变量
      this.dbStore = db
      console.log('testTag', `创建${tableName}表成功`)
    } catch (e) {
      console.log('testTag', `创建${tableName}表失败`, JSON.stringify(e))
    }
  }

  /**
   * 添加一个新的任务
   * @param tableName 数据库表名
   * @param value 任务数据
   * @returns 任务id
   */
  async add(tableName:string, value: relationalStore.ValuesBucket) {
    try {
      let res = await this.dbStore?.insert(tableName,value)
      console.log('testTag','添加任务成功', JSON.stringify(value))
      return res
    } catch (e) {
      console.log('testTag',`添加任务失败`, JSON.stringify(e), JSON.stringify(value), tableName)
      return
    }
  }

  /**
   * 删除一个新的任务
   * @param tableName 数据库表名
   * @param id 任务id
   * @returns Promise<void>
   */
  async delete(tableName:string, id:number) {
    try {
      const predicates = new relationalStore.RdbPredicates(tableName)
      predicates.equalTo('ID', id)
      console.log('testTag',`删除任务:id = ${id}成功`)
      await this.dbStore?.delete(predicates)
    } catch (e) {
      console.log('testTag',`删除任务:id = ${id}失败`, JSON.stringify(e))
    }
  }

  /**
   * 更新一个新的任务
   * @param tableName 数据库表名
   * @param id 任务id
   * @param value 任务数据
   * @returns Promise<void>
   */
  async update(tableName:string, id:number, value:relationalStore.ValuesBucket) {
    try {
      const predicates = new relationalStore.RdbPredicates(tableName)
      predicates.equalTo('ID',id)
      await this.dbStore?.update(value, predicates)
      console.log('testTag',`更新任务成功`, JSON.stringify(value))
    } catch (e) {
      console.log('testTag',`更新任务失败`, JSON.stringify(e))
    }
  }

  /**
   * 查询任务数据
   * @param tableName 数据库表名
   * @param columns 需要查询的数据,如['ID', 'NAME', 'FINISHED']只查询任务中的id, name和finished数据
   * @returns Promise<T[]>
   */
  async query(tableName:string, columns:string[]) {
    //构建查询条件
    let predicates = new relationalStore.RdbPredicates(tableName)
    //开始查询
    let result = await this.dbStore?.query(predicates,columns)
    //初始化数组
    let tasks:relationalStore.ValuesBucket[] = []
    //解析数据
    while (!result?.isAtLastRow) {
      //指针移到下一行, 默认是在-1
      result?.goToNextRow()
      //获取数据
      let id = result?.getLong(result.getColumnIndex('ID')) ?? 0
      let name = result?.getString(result.getColumnIndex('NAME')) ?? ''
      let finished = result?.getLong(result.getColumnIndex('FINISHED')) ?? false
      tasks.push({id, name, finished})
    }
    console.log('testTag', '查询到数据', JSON.stringify(tasks))
    return tasks
  }
}

const storeUtil = new StoreUtil()
export default storeUtil as StoreUtil