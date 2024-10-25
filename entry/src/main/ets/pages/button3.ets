@Preview
@Component
export struct button3{
  num:string=''
  build(){
    Column(){
      Text(`${this.num}`)
        .fontSize(50)
        .fontColor(Color.Orange)
    }
    .width(78)
    .height(160)
    .backgroundColor(0x333333)
    .justifyContent(FlexAlign.Center)
    .borderRadius(50)
  }
}