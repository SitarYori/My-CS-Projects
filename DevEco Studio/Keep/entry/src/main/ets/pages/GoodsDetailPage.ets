// pages/GoodsDetailPage.ets
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { CartUtil, CartItem } from '../utils/CartUtil';
import { getGoodsSpecs, SpecOption } from '../utils/GoodsConfig';

interface GoodsInfo {
  goodsId: string;
  title: string;
  price: string;
  originPrice: string;
  imgName: string;
}

@Entry
@Component
struct GoodsDetailPage {
  @State goods: GoodsInfo = {
    goodsId: '',
    title: '',
    price: '',
    originPrice: '',
    imgName: ''
  };
  @State selectSpec: number = 0;
  @State quantity: number = 1;
  @State showCartSpecDialog: boolean = false;
  @State showBuyDialog: boolean = false;
  @State specList: SpecOption[] = [];  // 动态规格列表

  private cartUtil: CartUtil = CartUtil.getInstance();

  // 在 aboutToAppear 中
  aboutToAppear() {
    const params = router.getParams() as Record<string, string>;
    if (params) {
      console.log('接收到的参数：', JSON.stringify(params));  // 添加日志打印
      this.goods = {
        goodsId: params.goodsId || 'default',  // ← 确保接收到正确的ID
        title: params.title || '商品',
        price: params.price || '¥0',
        originPrice: params.originPrice || '¥0',
        imgName: params.imgName || 'default'
      };
    }
    // 根据商品ID获取对应的规格列表
    this.specList = getGoodsSpecs(this.goods.goodsId);
    console.log('当前商品ID：', this.goods.goodsId);  // 添加日志打印
    this.cartUtil.init(getContext(this));
  }

  // 获取当前选中的规格标签
  getCurrentSpecLabel(): string {
    if (this.specList.length > 0 && this.selectSpec < this.specList.length) {
      return this.specList[this.selectSpec].label;
    }
    return '默认规格';
  }

  // 显示加入购物车规格对话框
  handleAddToCart() {
    this.quantity = 1;
    this.selectSpec = 0;
    this.showCartSpecDialog = true;
  }

  // 确认加入购物车
  async confirmAddToCart() {
    const specLabel = this.getCurrentSpecLabel();

    // 打印调试信息
    console.log('加入购物车 - goodsId:', this.goods.goodsId);
    console.log('加入购物车 - title:', this.goods.title);
    console.log('加入购物车 - spec:', specLabel);

    const result = await this.cartUtil.addToCart({
      goodsId: this.goods.goodsId,
      title: this.goods.title,
      price: this.goods.price,
      originPrice: this.goods.originPrice,
      imgName: this.goods.imgName,
      spec: specLabel,
      quantity: this.quantity,
      selected: true
    });

    this.showCartSpecDialog = false;

    if (result) {
      promptAction.showToast({
        message: `已添加 ${this.quantity} 件「${specLabel}」到购物车`,
        duration: 1500
      });
    } else {
      promptAction.showToast({
        message: '添加失败，请重试',
        duration: 1000
      });
    }
  }

  // 立即购买
  handleBuyNow() {
    this.quantity = 1;
    this.selectSpec = 0;
    this.showBuyDialog = true;
  }

  // 确认立即购买
  confirmBuy() {
    const specLabel = this.getCurrentSpecLabel();
    promptAction.showToast({
      message: `已选择 ${specLabel}，${this.quantity}件，${this.goods.price}`,
      duration: 1500
    });
    this.showBuyDialog = false;
  }

  build() {
    Stack() {
      // 正常页面内容
      Column() {
        // 顶部导航栏
        Row() {
          Button('<')
            .fontSize(24)
            .backgroundColor(Color.Transparent)
            .fontColor('#333333')
            .onClick(() => {
              router.back();
            })

          Text('商品详情')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Row() {
            Text('🛒')
              .fontSize(22)
              .margin({ right: 12 })
              .onClick(() => {
                router.pushUrl({ url: 'pages/CartPage' });
              })
            Text('···')
              .fontSize(20)
              .fontColor('#333333')
          }
        }
        .width('100%')
        .padding({ left: 12, right: 12, top: 0, bottom: 12 })
        .backgroundColor('#FFFFFF')

        Scroll() {
          Column() {
            // 商品图片
            if (this.goods.imgName) {
              Image($r(`app.media.${this.goods.imgName}`))
                .width('100%')
                .height(300)
                .objectFit(ImageFit.Cover)
                .backgroundColor('#F5F5F5')
            } else {
              Column()
                .width('100%')
                .height(300)
                .backgroundColor('#F5F5F5')
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
            }

            // 价格信息
            Column() {
              Row() {
                Text('预估到手 ')
                  .fontSize(12)
                  .fontColor('#999999')
                Text(this.goods.price)
                  .fontSize(28)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FF6B4A')
                Text(this.goods.originPrice)
                  .fontSize(14)
                  .fontColor('#999999')
                  .decoration({ type: TextDecorationType.LineThrough })
                  .margin({ left: 8 })
              }
              .width('100%')
              .margin({ bottom: 4 })
            }
            .width('94%')
            .margin({ left: '3%', top: 16, bottom: 8 })

            // 商品标题
            Text(this.goods.title)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .width('94%')
              .margin({ left: '3%', bottom: 8 })

            // 商品描述
            Text('配合不同动作，可以锻炼到身体各部位的肌肉。')
              .fontSize(14)
              .fontColor('#666')
              .width('94%')
              .margin({ left: '3%', bottom: 16 })

            // 品牌信息
            Column() {
              Row() {
                Text('品牌')
                  .fontSize(14)
                  .fontColor('#999')
                Text('Srick')
                  .fontSize(14)
                  .fontColor('#333')
                  .margin({ left: 20 })
              }
              .width('100%')
              .padding({ top: 6, bottom: 6 })

              Divider()
                .color('#F0F0F0')
                .height(0.5)

              Row() {
                Text('重量')
                  .fontSize(14)
                  .fontColor('#999')
                Text('1kg-10kg')
                  .fontSize(14)
                  .fontColor('#333')
                  .margin({ left: 20 })
              }
              .width('100%')
              .padding({ top: 6, bottom: 6 })

              Divider()
                .color('#F0F0F0')
                .height(0.5)

              Row() {
                Text('健身目标')
                  .fontSize(14)
                  .fontColor('#999')
                Text('健身、塑形')
                  .fontSize(14)
                  .fontColor('#333')
                  .margin({ left: 20 })
              }
              .width('100%')
              .padding({ top: 6, bottom: 6 })
            }
            .width('94%')
            .margin({ left: '3%', top: 16, bottom: 16 })
            .padding(12)
            .backgroundColor(Color.White)
            .borderRadius(12)

            // Keepers说
            Column() {
              Row() {
                Text('Stickers说')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                Blank()
                Text('1782条评价 >')
                  .fontSize(12)
                  .fontColor('#999')
              }
              .width('100%')
              .margin({ bottom: 8 })

              Row() {
                Column() {
                  Text('云_遥')
                    .fontSize(13)
                    .fontWeight(FontWeight.Medium)
                  Text('规格：1kg*2（樱粉）')
                    .fontSize(11)
                    .fontColor('#999')
                    .margin({ top: 2 })
                  Text('外观包装：快递包装扔了，是挺厚的纸盒，商品是独立塑...')
                    .fontSize(12)
                    .fontColor('#666')
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)
              }
              .width('100%')
            }
            .width('94%')
            .margin({ left: '3%', top: 16, bottom: 30 })
            .padding(12)
            .backgroundColor(Color.White)
            .borderRadius(12)
          }
          .width('100%')
          .padding({ bottom: 80 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .backgroundColor('#F8F8F8')

        // 底部操作栏
        Row() {
          Row() {
            Text('💬')
              .fontSize(20)
            Text('客服')
              .fontSize(12)
              .margin({ left: 2 })
          }
          .padding({ left: 8, right: 8 })
          .onClick(() => {
            promptAction.showToast({ message: '客服功能开发中', duration: 1000 });
          })


          Blank()

          Button('加入购物车')
            .fontSize(14)
            .height(40)
            .backgroundColor('#FF6B4A')
            .fontColor(Color.White)
            .borderRadius(20)
            .padding({ left: 20, right: 20 })
            .onClick(() => {
              this.handleAddToCart();
            })

          Button('立即购买')
            .fontSize(14)
            .height(40)
            .backgroundColor('#FF6B4A')
            .fontColor(Color.White)
            .borderRadius(20)
            .padding({ left: 20, right: 20 })
            .margin({ left: 8 })
            .onClick(() => {
              this.handleBuyNow();
            })
        }
        .width('100%')
        .height(60)
        .backgroundColor(Color.White)
        .padding({ left: 12, right: 12 })
        .shadow({ radius: 5, color: '#00000010', offsetY: -2 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8F8F8')

      // ==================== 加入购物车规格选择对话框 ====================
      if (this.showCartSpecDialog) {
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('rgba(0,0,0,0.5)')
          .onClick(() => {
            this.showCartSpecDialog = false;
          })

        Column() {
          Row() {
            Text('选择规格')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
            Blank()
            Text('✕')
              .fontSize(24)
              .fontColor('#999999')
              .onClick(() => {
                this.showCartSpecDialog = false;
              })
          }
          .width('100%')
          .padding({ top: 8, bottom: 12 })

          Text(this.goods.title)
            .fontSize(14)
            .fontColor('#333')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')
            .margin({ bottom: 12 })

          Row() {
            Text('已选：')
              .fontSize(14)
              .fontColor('#666')
            Text(this.getCurrentSpecLabel())
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333')
          }
          .width('100%')
          .margin({ bottom: 12 })

          // 动态规格列表
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
            ForEach(this.specList, (spec: SpecOption, index: number) => {
              Button(spec.label)
                .fontSize(13)
                .backgroundColor(this.selectSpec === index ? '#FF6B4A' : '#F5F5F5')
                .fontColor(this.selectSpec === index ? Color.White : '#333333')
                .borderRadius(16)
                .padding({ left: 14, right: 14, top: 8, bottom: 8 })
                .margin({ right: 8, bottom: 8 })
                .onClick(() => {
                  this.selectSpec = index;
                })
            }, (spec: SpecOption, index: number) => {
              return spec.value + '_' + index;
            })
          }
          .width('100%')
          .margin({ bottom: 16 })

          // 数量选择
          Row() {
            Text('数量')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)

            Blank()

            Row() {
              Button('-')
                .fontSize(16)
                .width(32)
                .height(32)
                .backgroundColor('#F0F0F0')
                .fontColor('#333333')
                .borderRadius(16)
                .onClick(() => {
                  if (this.quantity > 1) this.quantity--;
                })

              Text(this.quantity.toString())
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .width(40)
                .textAlign(TextAlign.Center)

              Button('+')
                .fontSize(16)
                .width(32)
                .height(32)
                .backgroundColor('#FF6B4A')
                .fontColor(Color.White)
                .borderRadius(16)
                .onClick(() => {
                  this.quantity++;
                })
            }
          }
          .width('100%')
          .margin({ bottom: 16 })

          Row() {
            Text('预估到手价：')
              .fontSize(14)
              .fontColor('#666')
            Text(this.goods.price)
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FF6B4A')
          }
          .width('100%')
          .margin({ bottom: 16 })

          Button('加入购物车')
            .width('100%')
            .height(44)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .backgroundColor('#FF6B4A')
            .fontColor(Color.White)
            .borderRadius(22)
            .onClick(() => {
              this.confirmAddToCart();
            })
        }
        .width('85%')
        .padding(20)
        .backgroundColor(Color.White)
        .borderRadius(16)
        .position({ x: '50%', y: '50%' })
        .translate({ x: '-50%', y: '-50%' })
      }

      // ==================== 立即购买确认对话框 ====================
      if (this.showBuyDialog) {
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('rgba(0,0,0,0.5)')
          .onClick(() => {
            this.showBuyDialog = false;
          })

        Column() {
          Row() {
            Text('确认购买')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
            Blank()
            Text('✕')
              .fontSize(24)
              .fontColor('#999999')
              .onClick(() => {
                this.showBuyDialog = false;
              })
          }
          .width('100%')
          .padding({ top: 8, bottom: 12 })

          Text(this.goods.title)
            .fontSize(14)
            .fontColor('#333')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')
            .margin({ bottom: 12 })

          Row() {
            Text('已选：')
              .fontSize(14)
              .fontColor('#666')
            Text(this.getCurrentSpecLabel())
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333')
          }
          .width('100%')
          .margin({ bottom: 12 })

          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
            ForEach(this.specList, (spec: SpecOption, index: number) => {
              Button(spec.label)
                .fontSize(13)
                .backgroundColor(this.selectSpec === index ? '#FF6B4A' : '#F5F5F5')
                .fontColor(this.selectSpec === index ? Color.White : '#333333')
                .borderRadius(16)
                .padding({ left: 14, right: 14, top: 8, bottom: 8 })
                .margin({ right: 8, bottom: 8 })
                .onClick(() => {
                  this.selectSpec = index;
                })
            }, (spec: SpecOption, index: number) => {
              return spec.value + '_buy_' + index;
            })
          }
          .width('100%')
          .margin({ bottom: 16 })

          Row() {
            Text('数量')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)

            Blank()

            Row() {
              Button('-')
                .fontSize(16)
                .width(32)
                .height(32)
                .backgroundColor('#F0F0F0')
                .fontColor('#333333')
                .borderRadius(16)
                .onClick(() => {
                  if (this.quantity > 1) this.quantity--;
                })

              Text(this.quantity.toString())
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .width(40)
                .textAlign(TextAlign.Center)

              Button('+')
                .fontSize(16)
                .width(32)
                .height(32)
                .backgroundColor('#FF6B4A')
                .fontColor(Color.White)
                .borderRadius(16)
                .onClick(() => {
                  this.quantity++;
                })
            }
          }
          .width('100%')
          .margin({ bottom: 16 })

          Row() {
            Text('预估到手价：')
              .fontSize(14)
              .fontColor('#666')
            Text(this.goods.price)
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FF6B4A')
          }
          .width('100%')
          .margin({ bottom: 16 })

          Button('确认购买')
            .width('100%')
            .height(44)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .backgroundColor('#FF6B4A')
            .fontColor(Color.White)
            .borderRadius(22)
            .onClick(() => {
              this.confirmBuy();
            })
        }
        .width('85%')
        .padding(20)
        .backgroundColor(Color.White)
        .borderRadius(16)
        .position({ x: '50%', y: '50%' })
        .translate({ x: '-50%', y: '-50%' })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }
}

export default GoodsDetailPage;