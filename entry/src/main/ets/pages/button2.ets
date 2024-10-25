@Preview
@Component
export struct button2{
  string:string=''
  build(){
    Column(){
      Text(`${this.string}`)
        .fontSize(50)
        .fontColor(Color.White)

    }
    .width(160)
    .height(78)
    .backgroundColor(0x333333)
    .justifyContent(FlexAlign.Center)
    .borderRadius(50)
  }
}