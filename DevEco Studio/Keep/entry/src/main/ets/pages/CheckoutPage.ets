// pages/CheckoutPage.ets
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

interface CartItem {
  goodsId: string;
  title: string;
  price: string;
  originPrice: string;
  imgName: string;
  spec: string;
  quantity: number;
  selected: boolean;
}

interface AddressInfo {
  name: string;
  phone: string;
  province: string;
  city: string;
  district: string;
  detail: string;
  isDefault: boolean;
}

@Entry
@Component
struct CheckoutPage {
  @State selectedPayment: number = 0;
  @State showAddressForm: boolean = false;

  @State address: AddressInfo = {
    name: '',
    phone: '',
    province: '',
    city: '',
    district: '',
    detail: '',
    isDefault: true
  };

  @State cartList: CartItem[] = [];
  @State totalPrice: number = 0;
  @State originTotalPrice: number = 0;
  @State discountAmount: number = 0;
  @State shippingFee: number = 0;
  @State finalPrice: number = 0;

  private paymentMethods: string[] = ['支付宝支付', '微信支付', '云闪付'];

  aboutToAppear() {
    const params = router.getParams() as Record<string, object>;
    if (params) {
      // ✅ 正确的类型转换方式
      const cartListParam = params.cartList;
      if (Array.isArray(cartListParam)) {
        this.cartList = cartListParam as CartItem[];
      }

      const totalPriceParam = params.totalPrice;
      if (typeof totalPriceParam === 'number') {
        this.totalPrice = totalPriceParam;
      } else if (typeof totalPriceParam === 'string') {
        this.totalPrice = parseFloat(totalPriceParam) || 0;
      }

      const originTotalPriceParam = params.originTotalPrice;
      if (typeof originTotalPriceParam === 'number') {
        this.originTotalPrice = originTotalPriceParam;
      } else if (typeof originTotalPriceParam === 'string') {
        this.originTotalPrice = parseFloat(originTotalPriceParam) || 0;
      }

      const discountAmountParam = params.discountAmount;
      if (typeof discountAmountParam === 'number') {
        this.discountAmount = discountAmountParam;
      } else if (typeof discountAmountParam === 'string') {
        this.discountAmount = parseFloat(discountAmountParam) || 0;
      }

      const shippingFeeParam = params.shippingFee;
      if (typeof shippingFeeParam === 'number') {
        this.shippingFee = shippingFeeParam;
      } else if (typeof shippingFeeParam === 'string') {
        this.shippingFee = parseFloat(shippingFeeParam) || 0;
      }

      this.finalPrice = this.totalPrice + this.shippingFee;
    } else {
      this.cartList = [
        {
          goodsId: '1',
          title: '浸塑哑铃女生居家健身套装',
          price: '¥39.00',
          originPrice: '¥55.00',
          imgName: 'yaling',
          spec: '1kg*2【瘦手臂】(樱粉)',
          quantity: 1,
          selected: true
        }
      ];
      this.totalPrice = 39;
      this.originTotalPrice = 55;
      this.discountAmount = 16;
      this.shippingFee = 0;
      this.finalPrice = 39;
    }
  }

  build() {
    Stack() {
      // 主页面内容
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

          Text('确认订单')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text('')
            .width(40)
        }
        .width('100%')
        .padding({ left: 12, right: 12, top: 12, bottom: 12 })
        .backgroundColor('#FFFFFF')

        Scroll() {
          Column() {
            this.AddressCard()
            this.ProductList()
            this.PriceDetail()
            this.PaymentSection()
          }
          .width('100%')
          .padding({ bottom: 80 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .backgroundColor('#F5F5F5')

        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')

      // ✅ 地址表单弹窗（使用 if 控制显示）
      if (this.showAddressForm) {
        // 遮罩层
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('rgba(0,0,0,0.5)')
          .onClick(() => {
            this.showAddressForm = false;
          })

        // 表单内容
        Column() {
          Row() {
            Text('收货地址')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
            Blank()
            Text('✕')
              .fontSize(24)
              .fontColor('#999')
              .onClick(() => {
                this.showAddressForm = false;
              })
          }
          .width('100%')
          .margin({ bottom: 16 })

          TextInput({ placeholder: '请输入收货人姓名', text: this.address.name })
            .width('100%')
            .height(44)
            .backgroundColor('#F5F5F5')
            .borderRadius(22)
            .padding({ left: 16 })
            .margin({ bottom: 12 })
            .onChange((value: string) => {
              this.address.name = value;
            })

          TextInput({ placeholder: '请输入手机号码', text: this.address.phone })
            .width('100%')
            .height(44)
            .backgroundColor('#F5F5F5')
            .borderRadius(22)
            .padding({ left: 16 })
            .type(InputType.PhoneNumber)
            .margin({ bottom: 12 })
            .onChange((value: string) => {
              this.address.phone = value;
            })

          TextInput({ placeholder: '请输入省份', text: this.address.province })
            .width('100%')
            .height(44)
            .backgroundColor('#F5F5F5')
            .borderRadius(22)
            .padding({ left: 16 })
            .margin({ bottom: 12 })
            .onChange((value: string) => {
              this.address.province = value;
            })

          TextInput({ placeholder: '请输入城市', text: this.address.city })
            .width('100%')
            .height(44)
            .backgroundColor('#F5F5F5')
            .borderRadius(22)
            .padding({ left: 16 })
            .margin({ bottom: 12 })
            .onChange((value: string) => {
              this.address.city = value;
            })

          TextInput({ placeholder: '请输入区/县', text: this.address.district })
            .width('100%')
            .height(44)
            .backgroundColor('#F5F5F5')
            .borderRadius(22)
            .padding({ left: 16 })
            .margin({ bottom: 12 })
            .onChange((value: string) => {
              this.address.district = value;
            })

          TextInput({ placeholder: '请输入详细地址', text: this.address.detail })
            .width('100%')
            .height(44)
            .backgroundColor('#F5F5F5')
            .borderRadius(22)
            .padding({ left: 16 })
            .margin({ bottom: 16 })
            .onChange((value: string) => {
              this.address.detail = value;
            })

          Button('保存地址')
            .width('100%')
            .height(44)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .backgroundColor('#FF6B4A')
            .fontColor(Color.White)
            .borderRadius(22)
            .onClick(() => {
              if (!this.address.name || !this.address.phone || !this.address.detail) {
                promptAction.showToast({
                  message: '请填写完整信息（姓名、手机号、详细地址）',
                  duration: 1500
                });
                return;
              }
              this.showAddressForm = false;
              promptAction.showToast({
                message: '✅ 地址保存成功',
                duration: 1000
              });
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
  }

  // ========== 收货地址卡片 ==========
  @Builder
  AddressCard() {
    Column() {
      Row() {
        Column() {
          if (this.address.name && this.address.phone) {
            Row() {
              Text(this.address.name)
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
              Text(this.address.phone)
                .fontSize(14)
                .fontColor('#666')
                .margin({ left: 12 })
            }
            .width('100%')
            .margin({ bottom: 4 })

            Text(`${this.address.province} ${this.address.city} ${this.address.district} ${this.address.detail}`)
              .fontSize(14)
              .fontColor('#333')
              .width('100%')
          } else {
            Text('请填写收货地址')
              .fontSize(15)
              .fontColor('#999')
              .width('100%')
          }
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Row() {
          Text(this.address.name ? '✏️' : '➕')
            .fontSize(18)
          Text(this.address.name ? '修改' : '添加')
            .fontSize(14)
            .fontColor('#FF6B4A')
            .margin({ left: 4 })
        }
      }
      .width('100%')
      .padding(12)
    }
    .width('94%')
    .margin({ left: '3%', top: 12 })
    .backgroundColor(Color.White)
    .borderRadius(12)
    .onClick(() => {
      this.showAddressForm = true;
    })
  }

  // ========== 商品列表 ==========
  @Builder
  ProductList() {
    Column() {
      Row() {
        Text('📦')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
        Blank()
        Text('7天无理由退货')
          .fontSize(11)
          .fontColor('#999')
      }
      .width('100%')
      .margin({ bottom: 12 })

      ForEach(this.cartList, (item: CartItem, index: number) => {
        this.ProductItem(item)
      }, (item: CartItem, index: number) => {
        return item.goodsId + '_' + index;
      })
    }
    .width('94%')
    .margin({ left: '3%', top: 12 })
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(12)
  }

  @Builder
  ProductItem(item: CartItem) {
    Row() {
      if (item.imgName) {
        Image($r(`app.media.${item.imgName}`))
          .width(80)
          .height(80)
          .borderRadius(8)
          .objectFit(ImageFit.Cover)
          .margin({ right: 12 })
      } else {
        Column()
          .width(80)
          .height(80)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .margin({ right: 12 })
      }

      Column({ space: 4 }) {
        Text(item.title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')

        Text(`规格: ${item.spec}`)
          .fontSize(11)
          .fontColor('#999')
          .width('100%')

        Row() {
          Text(item.price)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF6B4A')
          Text(item.originPrice)
            .fontSize(12)
            .fontColor('#999')
            .decoration({ type: TextDecorationType.LineThrough })
            .margin({ left: 6 })
          Blank()
          Text(`× ${item.quantity}`)
            .fontSize(13)
            .fontColor('#666')
        }
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
    .border({
      width: { bottom: 0.5 },
      color: '#EEEEEE'
    })
  }

  // ========== 价格明细 ==========
  @Builder
  PriceDetail() {
    Column() {
      Row() {
        Text(`共${this.cartList.length}件 小计`)
          .fontSize(13)
          .fontColor('#666')
        Blank()
        Text(`¥${this.totalPrice.toFixed(2)}`)
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF6B4A')
      }
      .width('100%')
      .padding({ top: 8, bottom: 8 })
    }
    .width('94%')
    .margin({ left: '3%', top: 12 })
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(12)
  }

  // ========== 支付方式 ==========
  @Builder
  PaymentSection() {
    Column() {
      Text('支付方式')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 12 })

      ForEach(this.paymentMethods, (method: string, index: number) => {
        this.PaymentItem(method, index)
      }, (method: string, index: number) => {
        return method + '_' + index;
      })
    }
    .width('94%')
    .margin({ left: '3%', top: 12 })
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(12)
  }

  @Builder
  PaymentItem(method: string, index: number) {
    Row() {
      Text(this.getPaymentIcon(index))
        .fontSize(24)
        .margin({ right: 12 })

      Text(method)
        .fontSize(14)
        .fontColor('#333')
        .layoutWeight(1)

      if (index === 0) {
        Text('推荐')
          .fontSize(10)
          .fontColor('#FF6B4A')
          .backgroundColor('#FFF0ED')
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .borderRadius(8)
          .margin({ right: 8 })
      }

      Radio({ value: method, group: 'payment' })
        .checked(this.selectedPayment === index)
        .onChange(() => {
          this.selectedPayment = index;
        })
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
    .border({
      width: { bottom: index < this.paymentMethods.length - 1 ? 0.5 : 0 },
      color: '#EEEEEE'
    })
  }

  getPaymentIcon(index: number): string {
    const icons: string[] = ['💰', '💬', '☁️'];
    return icons[index] || '💰';
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: 4 }) {
        Row() {
          Text(`实际支付 ¥${this.finalPrice.toFixed(2)}`)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF6B4A')
        }
        Row() {
          Text(`已优惠 ¥${this.discountAmount.toFixed(2)}`)
            .fontSize(11)
            .fontColor('#999')
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('结算')
        .fontSize(16)
        .height(44)
        .backgroundColor('#FF6B4A')
        .fontColor(Color.White)
        .borderRadius(22)
        .padding({ left: 32, right: 32 })
        .onClick(() => {
          if (!this.address.name || !this.address.phone || !this.address.detail) {
            promptAction.showToast({
              message: '请先填写收货地址！',
              duration: 1500
            });
            return;
          }
          promptAction.showToast({
            message: '✅ 结算成功！',
            duration: 1500
          });
          setTimeout(() => {
            router.back();
          }, 1500);
        })
    }
    .width('100%')
    .height(64)
    .backgroundColor(Color.White)
    .padding({ left: 16, right: 16 })
    .shadow({ radius: 5, color: '#00000010', offsetY: -2 })
  }
}

export default CheckoutPage;