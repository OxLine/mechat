import React, { Component } from 'react';

import MembersNumber from '../MembersNumber';
import MessageList from '../MessageList';
import MessageInput from '../../components/MessageInput';

class Chat extends Component {
  render() {
    const { chatname } = this.props.params;

    return (
      <div className="chat">
        <MembersNumber chatname={chatname}/>
        <MessageList chatname={chatname}/>
        <MessageInput chatname={chatname}/>
      </div>
    );
  }
}

export default Chat;
