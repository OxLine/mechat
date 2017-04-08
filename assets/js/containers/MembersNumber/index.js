import React, { Component } from 'react';

class MembersNumber extends Component {
  render() {
    const {username} = this.props;
    return (
      <div className="members-number">
        <h2>Members number</h2>
      </div>
    );
  }
}

export default MembersNumber;
