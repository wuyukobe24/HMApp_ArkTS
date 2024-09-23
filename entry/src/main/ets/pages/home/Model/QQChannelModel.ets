
export class QQChannelDataModel {
  code?: number
  data?: Array<QQChannelModel>
}

export class QQChannelModel {
  id?: number
  name?: string
  channelType?: string
  zone?: string
  url?: string
  isHot?: boolean
  isNew?: boolean
  IsWhite?: boolean
  WhiteId?: number
  badgeUrl?: string
  cover?: string
  cacheNum?: number
  cacheTime?: number
  sub_ch?: string
  isFixed?: boolean
  commonIndex?: number
  default_tab_index?: number
  icon?: string
  key?: string
}
