enum ScreenType {
  sm = 'sm',  //小屏
  md = 'md',  //中屏
  lg = 'lg'   //大屏
}

declare interface ScreenInfoOptions<T> {
  sm?:T,
  md?:T,
  lg?:T
}

export default class ScreenInfo<T> {
  options:ScreenInfoOptions<T>

  constructor(options:ScreenInfoOptions<T>) {
    this.options = options
  }

  getValue(type:string): T | undefined {
    if(type == ScreenType.sm) {
      return this.options.sm
    } else if(type == ScreenType.md) {
      return this.options.md
    } else {
      return this.options.lg
    }
  }
}