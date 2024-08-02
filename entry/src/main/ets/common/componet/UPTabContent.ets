
@Component
export default struct UPTabContent {
  title:string = ''
  icon:ResourceStr = ''
  norColor?:ResourceStr = $r('app.color.gray')
  selColor?:ResourceStr = $r('app.color.primary_color')
  index:number = 0
  @Prop selIndex:number = 0

  @Builder cBuilder(){ }
  @BuilderParam contentBuilder:() => void = this.cBuilder

  build() {
    TabContent() {
      this.contentBuilder()
    }.tabBar(this.TabBarBuilder())
  }

  //自定义底部tab组件
  @Builder
  TabBarBuilder() {
    Column({space: 8}) {
      Image(this.icon).width(24).fillColor(this.selIndex == this.index ? this.selColor : this.norColor)
      Text(this.title).fontSize(14).fontColor(this.selIndex == this.index ? this.selColor : this.norColor)
    }
  }
}