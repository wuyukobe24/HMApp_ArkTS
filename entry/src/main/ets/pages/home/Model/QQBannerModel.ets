
export class QQBannerModel {
  code?: number
  data?: QQBannerData
  msg?: string
  result?: number
}

export class QQBannerData {
  result?: number
  next?: string
  feedsInfo?: Array<QQBannerFeedsInfo>
  attach?: object
  scope?: string
  distance?: number
}

export class QQBannerFeedsInfo {
  feedBase?: QQBannerFeedBase
  feedNews?: QQBannerFeedNews
}

export class QQBannerFeedNews {
  body?: Array<QQBannerBody>
}

export class QQBannerBody {
  enableWholeBannerClick?: boolean
  isAmsAd?: boolean
  imgUrl?: string
  bigImgUrl?: string
  intent?: string
  title?: string
  taskName?: string
  contentId?: string
  isVideo?: boolean
  vid?: string
  reservedDesc?: string
  packageName?: string
  universalLink?: string
  algorithmInfo?: QQBannerAlgorithmInfo
  extend?: QQBannerExtend
  commonInfo?: QQBannerCommonInfo
}

export class QQBannerCommonInfo {
  cover?: string
  type?: string
}

export class QQBannerExtend {
  roomid?: string
}

export class QQBannerAlgorithmInfo {
  adid?: string
  actionID?: string
  fname?: string
  bannerId?: string
  ecode?: string
  from?: string
  clickEventId?: string
  expoEventId?: string
  gamecode?: string
  url?: string
}

export class QQBannerFeedBase {
  layoutType?: string
  contentType?: string
  contentId?: string
  intent?: string
  position?: number
  priority?: number
}

