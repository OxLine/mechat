import React, { Component } from 'react';

import Message from '../../components/Message';

class MessageList extends Component {
  render() {
    return (
      <div className="message-list">
        <h2>Message List</h2>
        <Message />
      </div>
    );
  }
}

export default MessageList;
