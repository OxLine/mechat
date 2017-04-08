import React, { Component } from 'react';
import { connect } from 'react-redux';
import ScrollArea from 'react-scrollbar';

import Message from '../../components/Message';
import { getMessages } from '../../actions/messages';

class MessageList extends Component {
  componentWillMount() {
    this.props.getMessages();
  }

  render() {
    const messages = this.props.messages || [];

    return (
      <div className="message-list">
        <ScrollArea
          speed={0.8}
          className="area"
          contentClassName="content"
          horizontal={false}
          >
          { messages.map((message) =>
            <Message data={message} key={message.id}/>
          )}
        </ScrollArea>
      </div>
    );
  }
}

export default connect(
  (state) => ({
    messages: state.messages,
  }), null)(MessageList);
