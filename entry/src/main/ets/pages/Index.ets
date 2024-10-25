import { button } from './button'
import { button1 } from './button1'
// import { button2 } from './button2'
import { calculate } from'./calculate'
import { promptAction, router } from '@kit.ArkUI'
import Preference from './Preference'
@Entry
@Component
struct Index {
  @State cul:number = 0
  @State input:string = ''
  @State cullist:number[]=[]
  @State inputlist:string[]=[]
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;




  async aboutToAppear() {

    if(await Preference.getPreference('MyPreference','IndexInput',[])) {
      this.inputlist = await Preference.getPreference('MyPreference', 'IndexInput', []) as string[]
      console.log('读取11'+ this.inputlist);
    }
    if(await Preference.getPreference('MyPreferences','Cul',[])) {
      this.cullist= await Preference.getPreference('MyPreferences','Cul', []) as number[]
      console.log('读取10 '+this.cullist);
    }
  }

  build() {
    Column(){
      Row(){
        Image($r('app.media.history'))
          .height(36)
          .width(36)
          .onClick(()=>{
            router.replaceUrl({
              url:'pages/history',

              params: {
                CULLIST:this.cullist,
                INPUTLIST: this.inputlist,

              }

            })
          })
      }
      Blank()
      Row(){
        Text(`${ this.input }`)
          .fontColor(Color.White)
          .fontSize(70)
      }
      .justifyContent(FlexAlign.End)
      .width('90%')
      .margin({right:50})
      Row(){
        Text(`${ this.cul }`)
          .fontColor(Color.White)
          .fontSize(50)
      }
      .justifyContent(FlexAlign.End)
      .width('90%')
      .margin({right:50})
      Grid() {
        GridItem(){button1({str:'AC'})}
        .onClick(() => {
          this.input=''
          this.cul=0
        })
        GridItem(){button1({str:'Del'})}
        .onClick(() => {
          if (this.input .length>1) {
            this.input = this.input.substr(0,this.input .length-1);
          } else {
            this.input  = '';
          }

        })
        GridItem(){button1({str:'X'})}
        .onClick(() => {
          this.input += '*'
        })
        GridItem(){button1({str:'/'})}
        .onClick(() => {
          this.input += '/'
        })
        GridItem(){button({number:1})}
        .onClick(() => {
          this.input += '1'
        })
        GridItem(){button({number:2})}
        .onClick(() => {
          this.input += '2'
        })
        GridItem(){button({number:3})}
        .onClick(() => {
          this.input += '3'
        })
        GridItem(){button1({str:'-'})}
        .onClick(() => {
          this.input += '-'
        })
        GridItem(){button({number:4})}
        .onClick(() => {
          this.input += '4'
        })
        GridItem(){button({number:5})}
        .onClick(() => {
          this.input += '5'
        })
        GridItem(){button({number:6})}
        .onClick(() => {
          this.input += '6'
        })
        GridItem(){button1({str:'+'})}
        .onClick(() => {
          this.input += '+'
        })
        GridItem(){button({number:7})}
        .onClick(() => {
          this.input += '7'
        })
        GridItem(){button({number:8})}
        .onClick(() => {
          this.input += '8'
        })
        GridItem(){button({number:9})}
        .onClick(() => {
          this.input += '9'
        })
        GridItem(){button1({str:'('})}
        .onClick(() => {
          this.input += '('
        })
        GridItem(){button({number:0})}
        .onClick(() => {
          this.input += '0'
        })
        GridItem(){button1({str:'.'})}
        .onClick(() => {
          this.input += '.'
        })
        GridItem(){button1({str:'='})}
        .onClick(() => {
          let calHelper = new calculate()
          let tempResult = calHelper.evalExpression(this.input)

          this.cul = tempResult
          this.cullist.push(this.cul)
          this.inputlist.push(this.input)
          console.log('读取6  '+this.cullist)
          Preference.putPreference('MyPreferences','Cul',this.cullist)
          console.log('读取16  '+this.cullist)
          Preference.putPreference('MyPreference','IndexInput',this.inputlist)
        })
        GridItem(){button1({str:')'})}
        .onClick(() => {
          this.input += ')'
        })

    }
      .width('100%').height('50%')
      .rowsTemplate('1fr 1fr 1fr 1fr 1fr')
      .columnsTemplate('1fr 1fr 1fr 1fr ')
      .rowsGap(10).columnsGap(10)

      .layoutDirection(GridDirection.Row)

    }
    //.justifyContent(FlexAlign.End)
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Black )
    // this.bottomRectHeight = newHeight; // 根据需要计算或设置高度
    //
    // .padding({ top: this.topRectHeight, bottom: this.bottomRectHeight })
  }
}
