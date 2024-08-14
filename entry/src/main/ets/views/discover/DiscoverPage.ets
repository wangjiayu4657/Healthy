import NavHeader from '../../common/componet/NavHeader'

//发现
@Component
export default struct DiscoverPage {

  build() {
    Column() {
      //头部组件
      NavHeader({title: '发现',color: $r('app.color.primary_color'), tailBuilder: this.tailBuilder})

    }
    .width('100%')
    .height('100%')
  }

  //头部组件-尾部组件
  @Builder
  tailBuilder() {
    Text('早餐').fontColor(Color.White)
  }
}