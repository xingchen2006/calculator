import { promptAction, router } from '@kit.ArkUI'
import { text } from '@kit.ArkGraphics2D';
import Preference from './Preference'
@Entry
@Component
struct History {
  // @State CulList: number[]=[];
  // @State NumberList:string[]=[];
  @State Cul:number[] = [];
  @State Number:string[] =[];
  async aboutToAppear(){

    if(await Preference.getPreference('MyPreference','IndexInput',[])) {
      this.Number = await Preference.getPreference('MyPreference', 'IndexInput', []) as string[]
      console.log('读取3'+ this.Number);
    }
    if(await Preference.getPreference('MyPreferences','Cul',[])) {
      this.Cul= await Preference.getPreference('MyPreferences','Cul', []) as number[]
      console.log('读取7 '+this.Cul);
    }
  }
    build() {
      Column(){
        Row(){
          Text('返回')
            .fontColor(Color.White)
            .fontSize(30)
            .onClick(()=>{
              router.replaceUrl({
                url: 'pages/Index'
              })
            })
          Blank()
          Text('清空')
            .fontColor(Color.White)
            .fontSize(30)
            .onClick(() => {
              this.Cul = []
              this.Number = []
              Preference.putPreference('MyPreferences', 'Cul', this.Cul)
              Preference.putPreference('MyPreference', 'IndexInput', this.Number)
            })
        }
        .width('100%')
        List(){
          ForEach(this.Cul,(cul:number,index)=>{
            ListItem(){
              Column(){
                Text(`${this.Number[index]}`)
                  .fontSize(30)
                  .fontColor(Color.White)
                Text('='+cul)
                  .fontSize(30)
                  .fontColor(Color.White)
              }
              .width('100%')
              .alignItems(HorizontalAlign.End)
            }
          })
        }
      }
      .height('100%')
      .width('100%')
      .backgroundColor(Color.Black )
    }
  }