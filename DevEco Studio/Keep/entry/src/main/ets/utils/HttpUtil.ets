// utils/HttpUtil.ets
import http from '@ohos.net.http';
import { UserInfo } from './StorageUtil';

export interface ResBody<T> {
  code: number;
  msg: string;
  data?: T;
}

// 关注/粉丝接口入参
export interface FollowQueryParam {
  userId: string
}

// 关注统计返回结构
export interface FollowTotalRes {
  followers: number
  following: number
}

// ✅ 导出 RequestParams
export type RequestParams = Record<string, string | number>;


// ✅ 使用具体类型参数类
export class PostParams {
  email: string = '';
  pass: string = '';
  name: string = '';
}

export class GetParams {
  userId: string = '';
  page: number = 1;
}

export class HttpUtil {
  private static readonly BASE_URL: string = "http://127.0.0.1:3001/api";

  // POST 请求 - data 改为 object 类型
  static async post<T>(url: string, data: object): Promise<ResBody<T>> {
    return new Promise((resolve, reject) => {
      const req = http.createHttp();
      const fullUrl = HttpUtil.BASE_URL + url;

      console.log('📤 发送请求：', fullUrl);
      console.log('📦 请求数据：', JSON.stringify(data));

      req.request(fullUrl, {
        method: http.RequestMethod.POST,
        header: { "Content-Type": "application/json" },
        extraData: JSON.stringify(data),
        readTimeout: 10000
      }, (err, res) => {
        req.destroy();
        if (err) {
          console.error('❌ 请求错误：', err);
          reject(err);
        } else {
          try {
            console.log('📥 响应状态码：', res.responseCode);
            console.log('📥 响应数据：', res.result);
            let obj = JSON.parse(res.result as string) as ResBody<T>;
            resolve(obj);
          } catch (parseErr) {
            console.error('❌ 解析响应失败：', parseErr);
            reject(parseErr);
          }
        }
      });
    });
  }

  // GET 请求
  static async get<T>(url: string, params?: object): Promise<ResBody<T>> {
    return new Promise((resolve, reject) => {
      const req = http.createHttp();
      let fullUrl = HttpUtil.BASE_URL + url;

      if (params) {
        const keys: string[] = Object.keys(params);
        if (keys.length > 0) {
          const queryParts: string[] = [];
          for (let i = 0; i < keys.length; i++) {
            const key: string = keys[i];
            const value: string | number = (params as Record<string, string | number>)[key];
            queryParts.push(key + '=' + encodeURIComponent(String(value)));
          }
          fullUrl += '?' + queryParts.join('&');
        }
      }

      console.log('📤 发送GET请求：', fullUrl);

      req.request(fullUrl, {
        method: http.RequestMethod.GET,
        readTimeout: 10000
      }, (err, res) => {
        req.destroy();
        if (err) {
          console.error('❌ 请求错误：', err);
          reject(err);
        } else {
          try {
            console.log('📥 响应状态码：', res.responseCode);
            let obj = JSON.parse(res.result as string) as ResBody<T>;
            resolve(obj);
          } catch (parseErr) {
            console.error('❌ 解析响应失败：', parseErr);
            reject(parseErr);
          }
        }
      });
    });
  }
}

// 获取我的关注列表
export async function getMyFollowList(userId: string): Promise<ResBody<UserInfo[]>> {
  const param: FollowQueryParam = { userId: userId }
  return await HttpUtil.get<UserInfo[]>('/follow/myFollow', param)
}

// 获取我的粉丝列表
export async function getMyFansList(userId: string): Promise<ResBody<UserInfo[]>> {
  const param: FollowQueryParam = { userId: userId }
  return await HttpUtil.get<UserInfo[]>('/follow/myFans', param)
}

export async function getFollowTotal(userId: string): Promise<ResBody<FollowTotalRes>> {
  const param: FollowQueryParam = { userId: userId }
  return await HttpUtil.get<FollowTotalRes>('/follow/total', param)
}