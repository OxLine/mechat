import React, { Component } from 'react';

class ChatPreview extends Component {
  render() {
    var { username, last_message, unreaded_messages_number } = this.props.data;

    return (
      <div className="container">
        <div className="card">
          <div className="card-content">
            <p>{ username }</p>
            <p>{ unreaded_messages_number }</p>
            <p>{last_message}</p>
          </div>
        </div>
      </div>
    );
  }
}

export default ChatPreview;
