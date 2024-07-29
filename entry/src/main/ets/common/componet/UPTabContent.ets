
@Component
export default struct TabItem {
  icon:ResourceStr = ''
  title:ResourceStr = ''
  color:ResourceStr = ''

  build() {
    Column({space: 8}){
      Image(this.icon)
        .width(20)
        .fillColor(this.color)

      Text(this.title)
        .width(20)
        .fontColor(this.color)
    }
  }
}