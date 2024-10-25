@Preview
@Component
export struct button{
  number:number=0
  build(){
    Column(){
      Text(`${this.number}`)
        .fontSize(50)
        .fontColor(Color.White)
    }
    .width(78)
    .height(78)
    .backgroundColor(0x333333)
    .justifyContent(FlexAlign.Center)
    .borderRadius(50)
  }
}