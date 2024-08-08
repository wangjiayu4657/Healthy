import { relationalStore } from '@kit.ArkData'
import { ColumnInfo, ColumnType } from '../bean/ColumnInfo'

class DbUtil {
  private dbUtil?:relationalStore.RdbStore

  /*
   * 初始化数据库
   */
  async initDbUtil(context:Context, tableName:string, sql:string) {
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
      this.dbUtil = db
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
  async insert(tableName:string, value: relationalStore.ValuesBucket, columns: ColumnInfo[]) {
    try {
      let tempValue = this.handlerValueBucket(value, columns)
      let res = await this.dbUtil?.insert(tableName,tempValue)
      console.log('testTag','添加任务成功', JSON.stringify(value))
      return res
    } catch (e) {
      console.log('testTag',`添加任务失败`, JSON.stringify(e), JSON.stringify(value), tableName)
      return
    }
  }

  /**
   * 通用删除
   * @param predicates 删除条件
   */
  async deleteByPredicates(predicates:relationalStore.RdbPredicates) {
    try {
      console.log('testTag','删除任务成功')
      await this.dbUtil?.delete(predicates)
    } catch (e) {
      console.log('testTag','删除任务失败', JSON.stringify(e))
    }
  }

  /**
   * 根据id删除一个新的任务
   * @param tableName 数据库表名
   * @param id 任务id
   * @returns Promise<void>
   */
  async delete(tableName:string, id:number) {
    try {
      const predicates = new relationalStore.RdbPredicates(tableName)
      predicates.equalTo('ID', id)
      console.log('testTag',`删除任务:id = ${id}成功`)
      await this.dbUtil?.delete(predicates)
    } catch (e) {
      console.log('testTag',`删除任务:id = ${id}失败`, JSON.stringify(e))
    }
  }

  /**
   * 通用更新
   */
  async updateByPredicates(predicates:relationalStore.RdbPredicates, value:relationalStore.ValuesBucket,  columns: ColumnInfo[]) {
    try {
      let tempValue = this.handlerValueBucket(value, columns)
      await this.dbUtil?.update(tempValue, predicates)
      console.log('testTag',`更新任务成功`, JSON.stringify(value))
    } catch (e) {
      console.log('testTag',`更新任务失败`, JSON.stringify(e))
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
      await this.dbUtil?.update(value, predicates)
      console.log('testTag',`更新任务成功`, JSON.stringify(value))
    } catch (e) {
      console.log('testTag',`更新任务失败`, JSON.stringify(e))
    }
  }

  /**
   * 通用查询
   * @param predicates 查询条件
   * @param columns 解析数据数据时对应的字段
   * @returns Promise<T[]>
   */
  async queryByPredicates(predicates:relationalStore.RdbPredicates, columns:ColumnInfo[]) {
    //开始查询
    let result = await this.dbUtil?.query(predicates,columns.map(info => info.columnName))
    //初始化数组
    if (typeof result === 'undefined') {
      console.log('testTag', '未查询到数据')
      return []
    } else {
      let tasks:relationalStore.ValuesBucket[] = this.parseResultSet(result, columns)
      console.log('testTag', '查询到数据', JSON.stringify(tasks))
      return tasks
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
    let result = await this.dbUtil?.query(predicates,columns)
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


  //解析数据
  private parseResultSet(result: relationalStore.ResultSet, columns:ColumnInfo[]) {
    //声明最终返回的结果
    let source:relationalStore.ValuesBucket[] = []
    //判断是否有结果
    if(result.rowCount <= 0) { return [] }
    //处理结果
    while (!result.isAtLastRow) {
      result.goToNextRow() //指针先移动到下一行
      //解析这行数据并转为数据模型
      let obj:relationalStore.ValuesBucket = {}
      columns.forEach(info => {
        let val:Uint8Array | number | string | null = null

        switch (info.type) {
          case ColumnType.LONG:
            val = result.getLong(result.getColumnIndex(info.columnName))
            break;

          case ColumnType.DOUBLE:
            val = result.getDouble(result.getColumnIndex(info.columnName))
            break;

          case ColumnType.STRING:
            val = result.getString(result.getColumnIndex(info.columnName))
            break;

          case ColumnType.BLOB:
            val = result.getBlob(result.getColumnIndex(info.columnName))
            break;

          default:
            break;
        }

        obj[info.name] = val
      })

      source.push(obj)
      console.log('testTag', '查询到数据')
    }

    return source
  }

  /**
   * 数据类型处理
   * @param value 需要处理的数据
   * @param columns 映射成存储数据对应的字段
   */
  private handlerValueBucket(value:relationalStore.ValuesBucket, columns:ColumnInfo[]) {
    let val:relationalStore.ValuesBucket = {}

    columns.forEach(info => {
      let temp = value[info.name]
      if(typeof temp !== 'undefined') {
        val[info.columnName] = temp
      }
    })

    return val
  }
}

const dbUtil:DbUtil = new DbUtil()
export default dbUtil as DbUtil

