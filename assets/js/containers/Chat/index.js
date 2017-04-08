import React, { Component } from 'react';
import { connect } from 'react-redux';

import MembersNumber from '../MembersNumber';
import MessageList from '../MessageList';
import MessageForm from '../../components/MessageForm';
import { submitMessage } from '../../actions/messages';

class Chat extends Component {
  constructor(props) {
    super(props);
    this.handleSubmitMessage = this.handleSubmitMessage.bind(this);
  }

  handleSubmitMessage (data) {
    return this.props.submitMessage({...data, username: this.props.username},
                                this.context.router);
  }

  render() {
    const { username } = this.props;

    return (
      <div className="chat">
        <MembersNumber username={username}/>
        <MessageList username={username}/>
        <MessageForm onSubmit={this.handleSubmitMessage}/>
      </div>
    );
  }
}

export default connect(null, { submitMessage })(Chat);
