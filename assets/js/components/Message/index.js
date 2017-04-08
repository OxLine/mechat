import React, { Component } from 'react';

class Message extends Component {
  render() {
    const { user, created_at, is_readed, body } = this.props.data;
    return (
      <div className={is_readed?'message':'message unreaded'}>
        <div className="container">
          <div className="card">
            <div className="card-content">
              <p>{body}</p>
              <p>{created_at}</p>
              <p>{user.name}</p>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default Message;
