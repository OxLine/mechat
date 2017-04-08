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
    const { chatname } = this.props.params;
    if (chatname) {
      return <Chat chatname={chatname}/>;
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
          <div className="container">
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
