import type { FC } from 'react'
import type { IconType } from 'react-icons'
import { MdOutlineCategory, MdInventory } from 'react-icons/md'
import { BsCart4, BsClipboardDataFill } from 'react-icons/bs'
import { TbReportAnalytics } from 'react-icons/tb'
import { MenuListItem, ButtonLogout } from './'
import { BiCartAdd } from 'react-icons/bi'
import { IoAddOutline } from 'react-icons/io5'
import { AiOutlineFileAdd, AiOutlineHome } from 'react-icons/ai'
import { LinkSidebar } from './LinkSidebar'

export interface Route {
  name: string
  path: string
  Icon: IconType
}
interface MenuListType {
  name: string
  Icon: IconType
  path: string
  routes: Route[]
}

const MENU_LIST: MenuListType[] = [
  {
    name: 'Areas',
    Icon: MdOutlineCategory,
    path: '/areas',
    routes: [
      {
        name: 'Nueva Area',
        Icon: IoAddOutline,
        path: '/areas/nueva-area'
      },
      {
        name: 'Ver Areas',
        Icon: BsClipboardDataFill,
        path: '/areas/mostrar'
      }
    ]
  },
  {
    name: 'Productos',
    Icon: MdInventory,
    path: '/productos',
    routes: [
      {
        name: 'Nuevo Producto',
        Icon: IoAddOutline,
        path: '/productos/nuevo-producto'
      },
      {
        name: 'Ver Productos',
        Icon: BsClipboardDataFill,
        path: '/productos/mostrar'
      }
    ]
  },
  {
    name: 'Ventas',
    Icon: BsCart4,
    path: '/ventas',
    routes: [
      {
        name: 'Generar Venta',
        Icon: BiCartAdd,
        path: '/ventas/nueva-venta'
      },
      {
        name: 'Ver Ventas',
        Icon: BsClipboardDataFill,
        path: '/ventas/mostrar'
      }
    ]
  },
  {
    name: 'Reportes',
    Icon: TbReportAnalytics,
    path: '/reportes',
    routes: [
      {
        name: 'Generar Reporte',
        Icon: AiOutlineFileAdd,
        path: '/reportes/nuevo-reporte'
      }
    ]
  }
]

export const MenuList: FC = () => {
  return (
    <div className="grow">
      <ul className="flex flex-col gap-y-2">
        <li>
         <LinkSidebar path='/' Icon={AiOutlineHome} name='Inicio'/>
        </li>
        {MENU_LIST.map(({ name: title, Icon, path: href, routes }, i) => (
          <MenuListItem
            key={title}
            title={title}
            Icon={Icon}
            href={href}
            routes={routes}
          />
        ))}
      </ul>
      <ButtonLogout />
    </div>
  )
}
