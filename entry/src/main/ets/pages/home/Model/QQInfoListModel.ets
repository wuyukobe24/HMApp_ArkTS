export class QQInfoListModel {
  code?: number
  result?: number
  msg?: string
  data?: QQInfoListData
}

export class QQInfoListData {
  result?: number
  next?: string
  feedsInfo?: Array<QQInfoListFeedsInfo>
}

export class QQInfoListFeedsInfo {
  feedNews?: QQInfoListFeedNews
  feedBase?: QQInfoListFeedBase
}

export class QQInfoListFeedBase {
  contentId?: string
  contentType?: string
  intent?: string
  self_intent?: string
  layoutType?: string
  distance?: number
  distanceMinPosition?: number
  position?: number
  iTopPos?: number
  algorithmInfo?: QQInfoListAlgorithmInfo
  hideNotInterest?: boolean
  updateKey?: string
}

export class QQInfoListAlgorithmInfo {
  clickEventId?: string
  clickModuleId?: string
  layoutType?: string
  expoEventId?: string
  expoModuleId?: string
  algo_type?: string
  doc_id?: string
  serial_id?: string
  session_id?: string
  gameid?: string
  pictype?: string
  recall?: string
  recreasonid?: string
  sub_ch?: string
  vid?: string
  recommend_id?: string
  source?: string
  sTagids?: string
  type?: string
  iStatus?: string
  sCreated?: string
  data_source?: string
  extents?: string
  style?: string
  channel?: string
  collectionid?: string
  from_sub_ch?: string
  com_chann_id?: string
  itype?: string
  top_reco_id?: string
  topic_id?: string
  auth_uuid?: string
  template_id?: string
  iFlowPoolLevel?: number
  iFlowPoolScore?: number
  iFlowPoolStatus?: number
  iFlowPoolUplimit?: number
  url?: string
  id?: string
  is_guest?: string
}

export class QQInfoListFeedNews {
  footer?: QQInfoListFooter
  header?: QQInfoListHeader
  body?: QQInfoListBody
}

export class QQInfoListBody {
  rawTitle?: string
  title?: string
  preTitle?: string
  imgUrl?: string
  isVideo?: boolean
  commentID?: string
  vlen?: string
  vid?: string
  icon?: string
  nickName?: string
  headBoxSmallUrl?: string
  iconIntent?: string
  authorUuid?: string
  desc?: string
  portrait?: boolean
  isOnline?: boolean
  comCreateDate?: string
  comIdxTime?: string
  barrage_switch?: number
  topics?: object
  showCreative?: boolean
  creativeScheme?: string
  operationKey?: string
  ip_location?: string
  review_status?: number
  voteDetail?: object
  ext_info?: string
  isGrant?: string
  grantDescText?: string
  recommendReason?: string
  isFriend?: boolean
  reviewStatus?: number
  docid?: string
  showAttentionTag?: boolean
}

export class QQInfoListHeader {
  createDate?: string
  prefixText?: string
  prefixSubText?: string
  prefixSubText2?: string
  prefixIcon?: string
  suffixImage?: string
  suffixText?: string
  accessoryIcon?: string
  authorUuid?: string
  vipIcon?: string
  isAttention?: boolean
  test?: string
  intent?: string
  algorithmInfo?: QQInfoListAlgorithmInfo2
}

export class QQInfoListAlgorithmInfo2 {
  algo_type?: string
  doc_id?: string
  serial_id?: string
  session_id?: string
  gameid?: string
  pictype?: string
  recall?: string
  recreasonid?: string
  sub_ch?: string
  recommend_id?: string
  source?: string
  sTagids?: string
  type?: string
  iStatus?: string
  sCreated?: string
  data_source?: string
  extents?: string
  style?: string
  channel?: string
  collectionid?: string
  from_sub_ch?: string
  com_chann_id?: string
  itype?: string
  top_reco_id?: string
  topic_id?: string
  auth_uuid?: string
  template_id?: string
  iFlowPoolLevel?: object
  iFlowPoolScore?: object
  iFlowPoolStatus?: object
  iFlowPoolUplimit?: object
  url?: string
  id?: string
  is_guest?: string
}

export class QQInfoListFooter {
  zoneIntent?: string
  readCount?: number
  zoneName?: string
  zoneCNName?: string
  zoneId?: string
  zoneGameId?: string
  source?: string
  sourceIntent?: string
  commentCount?: number
  zoneIcon?: string
  zoneColor?: string
  commentIntent?: string
  tags?: Array<QQInfoListTags>
  isPraised?: boolean
  topicId?: string
  topicType?: number
  shareInfo?: QQInfoListShareInfo
}

export class QQInfoListShareInfo {
  title?: string
  content?: string
  summary?: string
  url?: string
  thumbUrl?: string
  imgurl?: string
}

export class QQInfoListTags {
  iTag?: string
  sTag?: string
}