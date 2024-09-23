export class QQIconModel {
  code?: number
  data?: QQIconData
  err_msg?: string
  msg?: string
  result?: number
  ret_code?: number
}

export class QQIconData {
  result?: number
  next?: string
  feedsInfo?: Array<QQIconFeedsInfo>
  scope?: string
}

export class QQIconFeedsInfo {
  feedNews?: QQIconFeedNews
}

export class QQIconFeedNews {
  isGameEntrance?: boolean
  body?: Array<QQIconBody>
  footer?: QQIconFooter
}

export class QQIconFooter {
  zoneName?: string
  source?: string
  commentCount?: number
}

export class QQIconBody {
  id?: number
  iconUrl?: string
  darkModeIconUrl?: string
  intent?: string
  name?: string
  iconKey?: string
  algorithmInfo?: QQIconAlgorithmInfo
  key?: string
}

export class QQIconAlgorithmInfo {
  clickEventId?: string
  clickModuleId?: string
  expoEventId?: string
  expoModuleId?: string
  tabname?: string
}
