import React, { Component } from 'react';
import { connect } from 'react-redux';
import ScrollArea from 'react-scrollbar';

import ChatPreview from '../../components/ChatPreview';
import { getDialogs } from '../../actions/dialogs';

class ChatPreviewList extends Component {
  componentWillMount() {
    this.props.getDialogs();
  }

  render() {
    const dialogs = this.props.dialogs || [];

    return (
      <div className="chat-preview-list">
        <ScrollArea
          speed={0.8}
          className="area"
          contentClassName="content"
          horizontal={false}
          >
          { dialogs.map((dialog) =>
            <ChatPreview key={dialog.id} data={dialog} />
          )}
        </ScrollArea>
      </div>
    );
  }
}

export default connect(
  (state) => ({
    dialogs: state.dialogs,
  }),{getDialogs})(ChatPreviewList);
