import preferences from '@ohos.data.preferences'
import { JSON } from '@kit.ArkTS'

//用户首选项(preferences)存储
class PreferencesUtil {
  private prefMap:Map<string,preferences.Preferences> = new Map()

  /**
   * 初始化用户首选项 preferences
   * @param context 上下文
   * @param name 用户首选项preferences实例名称
   * @return Promise<void>
   */
  async initPreferences(context:Context, name:string) {
    try {
      let pref = await preferences.getPreferences(context,name)
      this.prefMap.set(name, pref)
      console.log('testTag', `加载preferences[${name}]成功`)
    } catch (e) {
      console.log('testTag', `加载preferences[${name}]失败`, JSON.stringify(e))
    }
  }

  /**
   * 保存数据
   * @param name 用户首选项preferences实例名称
   * @param key 保存数据对应的key
   * @param value 需要保存的数据
   * @return Promise<void>
   */
  async save(name:string, key:string, value:preferences.ValueType) {
    if(!this.isInitPreferences(name)) return

    try {
      let pref = this.prefMap.get(name)
      //保存数据
      await pref?.put(key,value)
      //刷新到磁盘
      await pref?.flush()
      console.log('testTag', `保存preferences[${name}.${key} = ${value}]成功`)
    } catch (e) {
      console.log('testTag', `保存preferences[${name}.${key} = ${value}]失败`, JSON.stringify(e))
    }
  }

  /**
   * 读取数据
   * @param name 用户首选项preferences实例名称
   * @param key 读取数据对应的key
   * @param defaultValue 读取失败时默认返回的数据
   * @return Promise<void>
   */
  async fetch(name:string, key:string, defaultValue:preferences.ValueType) {
    if(!this.isInitPreferences(name)) return defaultValue

    try {
      let pref = this.prefMap.get(name)
      let result = await pref?.get(key,defaultValue)
      console.log('testTag', `获取preferences[${name}.${key} = ${result}]成功`)
      return result
    } catch (e) {
      console.log('testTag', `获取preferences[${name}.${key}]失败`, JSON.stringify(e))
      return defaultValue
    }
  }

  /**
   * 删除数据
   * @param name 用户首选项preferences实例名称
   * @param key 删除数据对应的key
   * @return Promise<void>
   */
  async delete(name:string, key:string) {
    if(!this.isInitPreferences(name)) return

    try {
      let pref = this.prefMap.get(name)
      await pref?.delete(key)
      console.log('testTag', `删除preferences[${name}.${key}]成功`)
    } catch (e) {
      console.log('testTag', `删除preferences[${name}.${key}]失败`, JSON.stringify(e))
    }
  }

  /**
   * 判断用户首选项实例是否已初始化
   * @param name 用户首选项preferences实例名称
   * @return boolean  true: 已初始化   false: 未初始化
   */
  isInitPreferences(name:string):boolean {
    if(this.prefMap.has(name)) {
      console.log('testTag', `preferences[${name}]已初始化`)
      return true
    } else {
      console.log('testTag', `preferences[${name}]尚未初始化`)
      return false
    }
  }
}

const preferencesUtil = new PreferencesUtil()
export default preferencesUtil as PreferencesUtil