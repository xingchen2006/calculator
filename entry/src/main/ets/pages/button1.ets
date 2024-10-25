@Preview
@Component
export struct button1{
  str:string=''
  build(){
    Column(){
      Text(`${this.str}`)
        .fontSize(50)
        .fontColor(Color.Orange)
    }
    .width(78)
    .height(78)
    .backgroundColor(0x333333)
    .justifyContent(FlexAlign.Center)
    .borderRadius(50)
  }
}