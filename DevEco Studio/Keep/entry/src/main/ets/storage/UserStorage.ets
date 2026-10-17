import { preferences } from '@kit.ArkData'
import { User } from '../model/User'

export class UserStorage {

  static async saveUser(user: User) {

    let pref = await preferences.getPreferences(
      getContext(),
      'userInfo'
    )

    await pref.put(
      user.email,
      JSON.stringify(user)
    )

    await pref.flush()
  }

  static async getUser(email: string): Promise<User | null> {

    let pref = await preferences.getPreferences(
      getContext(),
      'userInfo'
    )

    let data = await pref.get(email, '')

    if (data === '') {
      return null
    }

    return JSON.parse(data as string)
  }
}