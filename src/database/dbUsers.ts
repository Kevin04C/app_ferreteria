import { prisma } from '../../prisma'
import { bcrypt } from '@/utils'
import type { users } from '@prisma/client'

export const checkUserPassword = async (username: string, password: string): Promise<Omit<users, 'password'> | null> => {
  try {
    const user = await prisma.users.findFirst({ where: { username } })
    if (user === null) return null
    const matchPassword = bcrypt.comparePassword(password, user.password)
    if (!matchPassword) return null

    const { id, email } = user
    return { id, username, email }
  } catch (error) {
    return null
  }
}