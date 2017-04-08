import React, { Component } from 'react';

import MembersNumber from '../MembersNumber';
import MessageList from '../MessageList';
import MessageInput from '../../components/MessageInput';

class Chat extends Component {
  render() {
    const { username } = this.props;

    return (
      <div className="chat">
        <MembersNumber username={username}/>
        <MessageList username={username}/>
        <MessageInput username={username}/>
      </div>
    );
  }
}

export default Chat;
