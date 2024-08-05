import DateUtil from '../../common/utils/DateUtil'

//日期选择组件
@Component
export default struct UPDatePicker {
  @StorageProp('selDateKey') selDate:number = DateUtil.beginTimeOfDay(new Date())

  datePickerDialog:CustomDialogController = new CustomDialogController({
    builder: UPDatePickerDialog({selDate: new Date(this.selDate)})
  })


  build() {
    Row() {
      Text(DateUtil.formatDate(this.selDate))
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.primary_color'))

      Image($r('app.media.ic_public_spinner'))
        .width(20)
        .fillColor($r('app.color.primary_color'))
    }
    .width('100%')
    .padding({top: 10, left: 15, bottom: 15, right: 15})
    .borderRadius({topLeft: 12, topRight: 12})
    .backgroundColor($r('app.color.lightest_primary_color'))
    .onClick(() => {
       this.datePickerDialog.open()
    })
  }
}


//日期选择弹窗
@CustomDialog
export struct UPDatePickerDialog {
  selDate?:Date = new Date()
  controller?: CustomDialogController

  build() {
    Column({space: 15}) {
      //时间选择器
      this.DatePickerBuilder()
      //操作
      this.OperationBuilder()
    }
    .width('100%')
    .height(300)
    .padding(15)
    .backgroundColor(Color.White)
  }

  @Builder
  DatePickerBuilder() {
    DatePicker({
      start: new Date('2020-01-01'),
      end: new Date(),
      selected: this.selDate
    })
      .onDateChange((date:Date) => {
        console.log('date === ', date)
        this.selDate = date
      })
  }

  @Builder
  OperationBuilder() {
    Row() {
      Button('取消')
        .width(120)
        .backgroundColor($r('app.color.light_gray'))
        .onClick(() => this.controller?.close())

      Button('确定')
        .width(120)
        .backgroundColor($r('app.color.primary_color'))
        .onClick(() => {
          AppStorage.setOrCreate('selDateKey', this.selDate?.getTime())
          this.controller?.close()
        })
    }
    .width('100%')
    .padding({top: 10, bottom: 10})
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}