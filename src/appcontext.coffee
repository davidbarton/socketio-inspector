###*
@jsx React.DOM
###

AppContext = React.createClass
  getInitialState: () ->
    items: []
    selected: 0
    expanded: yes

  handleClick: (e) ->
    this.setState {selected: e.selectedIndex, expanded: yes} if e.selectedIndex?
    this.setState {expanded: e.expanded} if e.expanded?

  render: () ->
    itemsData = this.state.items
    detailData = if (index = this.state.selected)? and this.state.items[index] then this.state.items[index].rawData else ''
    friends = if (index = this.state.selected)? and this.state.items[index] then this.state.items[index].friends else []
    `<div id="appContext" onClick={this.handleClick} className="">
      <div className="header">
        <div className="col name">Time <div className="under">Session id, type</div></div>
        <div className="col data">Data</div>
      </div>
      <div className="content">
        <div id="leftPanel" className="col name"><ItemsList data={itemsData} selected={this.state.selected} /></div>
        <div id="rightPanel" className="col data"><Detail selected={this.state.selected} data={detailData} friends={friends} expanded={this.state.expanded}/></div>
      </div>
    </div>`


ItemsList = React.createClass
  render: () ->
    currSelected = this.props.selected
    items = this.props.data.map (item, index) ->
      selected = currSelected is index
      `<MenuItem data={item.rawData} index={index} selected={selected} />`
    return `<ul>{items}</ul>`


MenuItem = React.createClass
  handleClick: (e) ->
    e.selectedIndex = this.props.index
    return

  twoDigit: (n) ->
    if n < 10 then '0'+n else n

  render: () ->
    reqDate = new Date this.props.data.time
    className = if this.props.selected then 'selected' else 'not-selected'
    typeNames =
      '$emit': 'incoming'
      'emit': 'outgoing'
    type = typeNames[this.props.data.name]
    className += " #{type}" if type
    

    `<li onClick={this.handleClick} className={className}>
      <strong>{reqDate.getHours()}:{this.twoDigit(reqDate.getMinutes())}:{this.twoDigit(reqDate.getSeconds())}</strong>:<small>{this.twoDigit(reqDate.getMilliseconds())}</small><br/>
      <small>{this.props.data.socket.sessionid}</small><br />
      <small>{this.props.data.args[0]}</small>
    </li>`


Detail = React.createClass

  handleClickEE: (e) ->
    e.expanded = yes
    e.selectedIndex = null
    return

  handleClickNE: (e) ->
    e.expanded = no
    e.selectedIndex = null
    return

  render: () ->
    return `<div id="itemDetail"> -- </div>` unless this.props.data
    if this.props.expanded
      `<div id="itemDetail">
        <ul className="tabs">
          <li onClick={this.handleClickEE} className="active">Table</li>
          <li onClick={this.handleClickNE}>Plain</li>
        </ul>
        <ExpandedDataDetail data={this.props.data} />
      </div>`
    else
      `<div id="itemDetail">
        <ul className="tabs">
          <li onClick={this.handleClickEE}>Table</li>
          <li onClick={this.handleClickNE} className="active">Plain</li>
        </ul>
        <PlainDataDetail data={this.props.data} />
      </div>`


Friends = React.createClass
  render: () ->
    currSelected = this.props.selected
    items = this.props.data.map (item, index) ->
      selected = currSelected is index
      `<Friend data={item.rawData} index={index} selected={selected} />`
    return `<ul>{items}</ul>`


Friend = React.createClass
  handleClick: (e) ->
    e.selectedIndex = this.props.index
    return

  render: () ->
    className = if this.props.selected then 'selected' else 'not-selected'
    `<li onClick={this.handleClick} className={className}>{this.props.index}</li>`



PlainDataDetail = React.createClass
  render: () ->
    return `<span></span>` unless this.props.data
    data = JSON.stringify this.props.data, null, 4
    return `<div className="plainDetailBlock"><pre>{data}</pre></div>`


ExpandedDataDetail = React.createClass
  formatObjectAsHtml: (obj) ->
    el = prettyPrint obj
    el.outerHTML

  render: () ->
    return `<span></span>` unless this.props.data
    html = this.formatObjectAsHtml this.props.data
    return `<div className="expanedDetailBlock"><div className="htmlData" dangerouslySetInnerHTML={{__html: html}} /></div>`

appContext = React.renderComponent `<AppContext />`, document.getElementById 'content'

