###*
@jsx React.DOM
###

Tweet = React.createClass
  render: () ->
    return `<li>{this.props.text}</li>`

TweetList = React.createClass
  render: () ->
    tweets = this.props.data.map (tweet) ->
      return `<Tweet text={tweet.text} />`
    return `<div><ul>{tweets}</ul></div>`

TweetBox = React.createClass
  addTweet: (tweet) ->
    tweets = this.state.data
    newTweets = tweets.concat [tweet]
    newTweets.splice(0, 1) if newTweets.length > 15
    this.setState { data: newTweets }
  getInitialState: () ->
    return { data: [] }
  componentWillMount: () ->
    self = this
    chrome.devtools.network.onRequestFinished.addListener (request) ->
      if request?
        request.getContent (data, encoding) ->
          self.addTweet data
  render: () ->
    return `<div><h1>Hello</h1><TweetList data={this.state.data} /></div>`

React.renderComponent(
  `<TweetBox />`,
  document.getElementById('content')
)