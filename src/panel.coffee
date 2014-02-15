###*
@jsx React.DOM
###

port = chrome.extension.connect { name: "socketio-inspector" }
port.onMessage.addListener (msg) ->
  console.log 'new message: ', msg

AppContext = React.createClass
  getInitialState: () ->
    data: [ {reqId: 'init0', reqData: {data: 'abcd0'}}]

  handleClick: (e) ->
    this.setState selected: e.selectedIndex

  render: () ->
    itemsData = this.state.data
    detailData = if (index = this.state.selected)? then this.state.data[index] else null
    `<div id="appContext" onClick={this.handleClick} className="">
      <div className="header">
        <div className="col name">Name <div className="under">Path</div></div>
        <div className="col data">Data</div>
      </div>
      <div className="content">
        <div id="leftPanel" className="col name"><ItemsList data={itemsData} /></div>
        <div id="rightPanel" className="col data"><Detail data={detailData} /></div>
      </div>
    </div>`

ItemsList = React.createClass
  render: () ->
    items = this.props.data.map (item, index) ->
      `<Item data={item} index={index} />`
    return `<ul>{items}</ul>`

Item = React.createClass
  handleClick: (e) ->
    e.selectedIndex = this.props.index

  render: () ->
    `<li onClick={this.handleClick}>{this.props.data}</li>`

Detail = React.createClass
  render: () ->
    `<div id="itemDetail">
      {this.props.data}
    </div>`


mock = [
  reqId: '1'
  reqData:
    data: 'abcd1'
,
  reqId: '2'
  reqData:
    data: 'abcd2'
,
  reqId: '3'
  reqData:
    data: 'abcd3'
]

appContext = React.renderComponent `<AppContext />`, document.getElementById 'content'
setTimeout (-> appContext.setState data: mock), 500



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
