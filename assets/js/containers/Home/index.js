import React, { Component } from 'react';
import DocumentTitle from 'react-document-title';

import Search from '../Search';
import ChatPreviewList from '../ChatPreviewList';
import Chat from '../Chat';

class Home extends Component {
  constructor (props) {
    super(props);
    this.renderChat = this.renderChat.bind(this);
  }

  renderChat() {
    const { username } = this.props.params;
    if (username) {
      return <Chat username={username}/>;
    }
    return(
      <div className="empty-chat">
        <h2>No chat selected.</h2>
      </div>
    );
  }

  render() {
    return (
      <DocumentTitle title="Home">
        <div>
          <div className="container container_width">
            <Search />
            <ChatPreviewList />
            {this.renderChat()}
          </div>
        </div>
      </DocumentTitle>
    );
  }
}

export default Home;
