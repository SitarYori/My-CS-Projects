// utils/StorageUtil.ets
import common from '@ohos.app.ability.common';
import preferences from '@ohos.data.preferences';
import hilog from '@ohos.hilog';

const DOMAIN = 0x0001;
const STORE_NAME = "keep_user";
let prefs: preferences.Preferences | null = null;



// 1. 定义用户信息接口
export interface UserInfo {
  nickname: string;
  email: string;
  password: string;
  _id?: string;
  avatar: string;
  gender: string;
  registerDate: string;
  weight: number;
  totalMinutes: number;
}

// 2. 初始化存储
export async function initStorage(context: common.UIAbilityContext): Promise<void> {
  try {
    prefs = await preferences.getPreferences(context, STORE_NAME);
    hilog.info(DOMAIN, 'Storage', 'Preferences 初始化成功');
  } catch (err) {
    hilog.error(DOMAIN, 'Storage', 'Preferences 初始化失败: %{public}s', JSON.stringify(err));
  }
}

// 3. 保存用户信息
export async function saveUser(user: UserInfo): Promise<void> {
  if (!prefs) {
    hilog.error(DOMAIN, 'Storage', 'Preferences 未初始化，无法保存用户信息');
    return;
  }
  try {
    prefs.putSync("nickname", user.nickname);
    prefs.putSync("email", user.email);
    prefs.putSync("password", user.password);
    await prefs.flush();
    hilog.info(DOMAIN, 'Storage', '用户信息保存成功');
  } catch (err) {
    hilog.error(DOMAIN, 'Storage', '保存用户信息失败: %{public}s', JSON.stringify(err));
  }
}

// 4. 获取本地用户信息
export async function getUser(): Promise<UserInfo> {
  if (!prefs) {
    hilog.error(DOMAIN, 'Storage', 'Preferences 未初始化，无法读取用户信息');
    const emptyUser: UserInfo = {
      _id: "",
      nickname: "",
      email: "",
      password: "",
      avatar: "",
      gender: "",
      registerDate: "",
      weight: 0,
      totalMinutes: 0
    };
    return emptyUser;
  }
  try {
    const nickname = prefs.getSync("nickname", "") as string;
    const email = prefs.getSync("email", "") as string;
    const password = prefs.getSync("password", "") as string;
    const avatar = prefs.getSync("avatar", "") as string;
    const gender = prefs.getSync("gender", "") as string;
    const registerDate = prefs.getSync("registerDate", "") as string;
    const weight = prefs.getSync("weight", 0) as number;
    const totalMinutes = prefs.getSync("totalMinutes", 0) as number;
    const _id = prefs.getSync("_id", "") as string;

    const user: UserInfo = {
      _id,
      nickname,
      email,
      password,
      avatar,
      gender,
      registerDate,
      weight,
      totalMinutes
    };
    return user;
  } catch (err) {
    hilog.error(DOMAIN, 'Storage', `读取用户信息失败：${JSON.stringify(err)}`);
    const emptyUser: UserInfo = {
      _id: "",
      nickname: "",
      email: "",
      password: "",
      avatar: "",
      gender: "",
      registerDate: "",
      weight: 0,
      totalMinutes: 0
    };
    return emptyUser;
  }
}

// 5. 检查用户是否已登录
export async function isLoggedIn(): Promise<boolean> {
  if (!prefs) {
    return false;
  }
  try {
    const email = prefs.getSync("email", "") as string;
    return email !== "";
  } catch (err) {
    hilog.error(DOMAIN, 'Storage', '检查登录状态失败: %{public}s', JSON.stringify(err));
    return false;
  }
}

// 6. 退出登录（清除用户信息）
export async function logout(): Promise<void> {
  if (!prefs) {
    hilog.error(DOMAIN, 'Storage', 'Preferences 未初始化，无法退出登录');
    return;
  }
  try {
    prefs.putSync("nickname", "");
    prefs.putSync("email", "");
    prefs.putSync("password", "");
    await prefs.flush();
    hilog.info(DOMAIN, 'Storage', '用户已退出登录');
  } catch (err) {
    hilog.error(DOMAIN, 'Storage', '退出登录失败: %{public}s', JSON.stringify(err));
  }
}

// 清空本地存储用户信息
export async function clearUser(): Promise<void> {
  if (!prefs) return
  prefs.deleteSync('_id')
  prefs.deleteSync('nickname')
  prefs.deleteSync('email')
  prefs.deleteSync('password')
  prefs.deleteSync('avatar')
  prefs.deleteSync('gender')
  prefs.deleteSync('registerDate')
  prefs.deleteSync('weight')
  prefs.deleteSync('totalMinutes')
}