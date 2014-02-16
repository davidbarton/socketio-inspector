###*
@jsx React.DOM
###

AppContext = React.createClass
  getInitialState: () ->
    items: []
    selected: 0

  handleClick: (e) ->
    this.setState selected: e.selectedIndex

  render: () ->
    itemsData = this.state.items
    detailData = if (index = this.state.selected)? and this.state.items[index] then this.state.items[index].rawData else ''
    `<div id="appContext" onClick={this.handleClick} className="">
      <div className="header">
        <div className="col name">Time <div className="under">Session ID</div></div>
        <div className="col data">Data</div>
      </div>
      <div className="content">
        <div id="leftPanel" className="col name"><ItemsList data={itemsData} selected={this.state.selected} /></div>
        <div id="rightPanel" className="col data"><Detail data={detailData} /></div>
      </div>
    </div>`


ItemsList = React.createClass
  render: () ->
    currSelected = this.props.selected
    items = this.props.data.map (item, index) ->
      selected = currSelected is index
      `<Item data={item.rawData} index={index} selected={selected} />`
    return `<ul>{items}</ul>`


Item = React.createClass
  handleClick: (e) ->
    e.selectedIndex = this.props.index
    console.log e.selectedIndex

  twoDigit: (n) ->
    if n < 10 then '0'+n else n

  render: () ->
    reqDate = new Date this.props.data.time
    className = if this.props.selected then 'selected' else 'not-selected'
    `<li onClick={this.handleClick} className={className}>
      <strong>{reqDate.getHours()}:{this.twoDigit(reqDate.getMinutes())}:{this.twoDigit(reqDate.getSeconds())}</strong>:<small>{this.twoDigit(reqDate.getMilliseconds())}</small><br/>
      <small>{this.props.data.socket.sessionid}</small>
    </li>`


Detail = React.createClass

  formatObjectAsHtml: (obj) ->
    el = prettyPrint obj,
      expanded: true
      maxDeph: 10
    el.outerHTML

  render: () ->
    return `<div id="itemDetail"> -- </div>` unless this.props.data
    `<div id="itemDetail">
      <DataDetail data={this.props.data} />
    </div>`


DataDetail = React.createClass
  formatObjectAsHtml: (obj) ->
    el = prettyPrint obj,
      expanded: true
      maxDeph: 10
    el.outerHTML

  render: () ->
    return `<span></span>` unless this.props.data
    html = this.formatObjectAsHtml this.props.data
    if this.props.name
      `<div className="detailBlock">
        <div className="htmlData" dangerouslySetInnerHTML={{__html: html}} />
      </div>`
    else
      `<div className="detailBlock"><h2>{this.props.name}</h2>
        <div className="htmlData" dangerouslySetInnerHTML={{__html: html}} />
      </div>`

appContext = React.renderComponent `<AppContext />`, document.getElementById 'content'





# Tweet = React.createClass
#   render: () ->
#     return `<li>{this.props.text}</li>`

# TweetList = React.createClass
#   render: () ->
#     tweets = this.props.data.map (tweet) ->
#       return `<Tweet text={tweet.text} />`
#     return `<div><ul>{tweets}</ul></div>`

# TweetBox = React.createClass
#   addTweet: (tweet) ->
#     tweets = this.state.data
#     newTweets = tweets.concat [tweet]
#     newTweets.splice(0, 1) if newTweets.length > 15
#     this.setState { data: newTweets }
#   getInitialState: () ->
#     return { data: [] }
#   componentWillMount: () ->
#     self = this
#     chrome.devtools.network.onRequestFinished.addListener (request) ->
#       if request?
#         request.getContent (data, encoding) ->
#           self.addTweet data
#   render: () ->
#     return `<div><h1>Hello</h1><TweetList data={this.state.data} /></div>`
