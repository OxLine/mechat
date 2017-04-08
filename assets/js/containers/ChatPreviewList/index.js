import React, { Component } from 'react';

import ChatPreview from '../../components/ChatPreview';

class ChatPreviewList extends Component {
  render() {
    return (
      <div className="chat-preview-list">
        <h2>Chat preview list</h2>
        <ChatPreview />
      </div>
    );
  }
}

export default ChatPreviewList;
