// utils/CartUtil.ets
import preferences from '@ohos.data.preferences';

// ✅ 定义购物车商品接口
export interface CartItem {
  goodsId: string;
  title: string;
  price: string;
  originPrice: string;
  imgName: string;
  spec: string;
  quantity: number;
  selected: boolean;
}

// ✅ 定义总价结果接口
export interface CartTotalResult {
  totalPrice: number;
  totalCount: number;
}

export class CartUtil {
  private static instance: CartUtil;
  private preferences: preferences.Preferences | null = null;

  static getInstance(): CartUtil {
    if (!CartUtil.instance) {
      CartUtil.instance = new CartUtil();
    }
    return CartUtil.instance;
  }

  async init(context: Context) {
    this.preferences = await preferences.getPreferences(context, 'cart_data');
  }

  async getCartList(): Promise<CartItem[]> {
    try {
      let cartStr = await this.preferences?.get('cart_list', '[]') as string;
      if (cartStr) {
        return JSON.parse(cartStr);
      }
      return [];
    } catch (error) {
      console.error('获取购物车失败：' + error);
      return [];
    }
  }

  async addToCart(item: CartItem): Promise<boolean> {
    try {
      let cartList: CartItem[] = await this.getCartList();
      let existIndex: number = -1;

      for (let i: number = 0; i < cartList.length; i++) {
        if (cartList[i].goodsId === item.goodsId && cartList[i].spec === item.spec) {
          existIndex = i;
          break;
        }
      }

      if (existIndex >= 0) {
        cartList[existIndex].quantity = cartList[existIndex].quantity + (item.quantity || 1);
      } else {
        // ✅ 明确声明 newItem 为 CartItem 类型
        const newItem: CartItem = {
          goodsId: item.goodsId,
          title: item.title,
          price: item.price,
          originPrice: item.originPrice || item.price,
          imgName: item.imgName,
          spec: item.spec,
          quantity: item.quantity || 1,
          selected: true
        };
        cartList.push(newItem);
      }

      await this.preferences?.put('cart_list', JSON.stringify(cartList));
      await this.preferences?.flush();
      return true;
    } catch (error) {
      console.error('添加购物车失败：' + error);
      return false;
    }
  }

  async removeFromCart(goodsId: string, spec: string): Promise<boolean> {
    try {
      let cartList: CartItem[] = await this.getCartList();
      let newList: CartItem[] = [];

      for (let i: number = 0; i < cartList.length; i++) {
        if (!(cartList[i].goodsId === goodsId && cartList[i].spec === spec)) {
          newList.push(cartList[i]);
        }
      }

      await this.preferences?.put('cart_list', JSON.stringify(newList));
      await this.preferences?.flush();
      return true;
    } catch (error) {
      console.error('删除购物车失败：' + error);
      return false;
    }
  }

  async updateQuantity(goodsId: string, spec: string, quantity: number): Promise<boolean> {
    try {
      let cartList: CartItem[] = await this.getCartList();

      for (let i: number = 0; i < cartList.length; i++) {
        if (cartList[i].goodsId === goodsId && cartList[i].spec === spec) {
          if (quantity <= 0) {
            cartList.splice(i, 1);
          } else {
            cartList[i].quantity = quantity;
          }
          break;
        }
      }

      await this.preferences?.put('cart_list', JSON.stringify(cartList));
      await this.preferences?.flush();
      return true;
    } catch (error) {
      console.error('更新数量失败：' + error);
      return false;
    }
  }

  async toggleSelected(goodsId: string, spec: string): Promise<boolean> {
    try {
      let cartList: CartItem[] = await this.getCartList();

      for (let i: number = 0; i < cartList.length; i++) {
        if (cartList[i].goodsId === goodsId && cartList[i].spec === spec) {
          cartList[i].selected = !cartList[i].selected;
          break;
        }
      }

      await this.preferences?.put('cart_list', JSON.stringify(cartList));
      await this.preferences?.flush();
      return true;
    } catch (error) {
      console.error('切换选中失败：' + error);
      return false;
    }
  }

  async selectAll(selected: boolean): Promise<boolean> {
    try {
      let cartList: CartItem[] = await this.getCartList();

      for (let i: number = 0; i < cartList.length; i++) {
        cartList[i].selected = selected;
      }

      await this.preferences?.put('cart_list', JSON.stringify(cartList));
      await this.preferences?.flush();
      return true;
    } catch (error) {
      console.error('全选失败：' + error);
      return false;
    }
  }

  async clearCart(): Promise<boolean> {
    try {
      await this.preferences?.put('cart_list', JSON.stringify([]));
      await this.preferences?.flush();
      return true;
    } catch (error) {
      console.error('清空购物车失败：' + error);
      return false;
    }
  }

  async getTotalCount(): Promise<number> {
    try {
      let cartList: CartItem[] = await this.getCartList();
      let total: number = 0;

      for (let i: number = 0; i < cartList.length; i++) {
        total = total + cartList[i].quantity;
      }
      return total;
    } catch (error) {
      console.error('获取总数失败：' + error);
      return 0;
    }
  }

  async getSelectedTotal(): Promise<CartTotalResult> {
    try {
      let cartList: CartItem[] = await this.getCartList();
      let totalPrice: number = 0;
      let totalCount: number = 0;

      for (let i: number = 0; i < cartList.length; i++) {
        if (cartList[i].selected) {
          let priceStr: string = cartList[i].price.replace('¥', '').replace('起', '').trim();
          let priceNum: number = parseFloat(priceStr);
          if (!isNaN(priceNum)) {
            totalPrice = totalPrice + priceNum * cartList[i].quantity;
          }
          totalCount = totalCount + cartList[i].quantity;
        }
      }

      const result: CartTotalResult = {
        totalPrice: Math.round(totalPrice * 100) / 100,
        totalCount: totalCount
      };
      return result;
    } catch (error) {
      console.error('获取选中总价失败：' + error);
      const emptyResult: CartTotalResult = { totalPrice: 0, totalCount: 0 };
      return emptyResult;
    }
  }
}