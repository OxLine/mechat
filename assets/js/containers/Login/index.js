// @flow
import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import DocumentTitle from 'react-document-title';
import { login } from '../../actions/session';
import LoginForm from '../../components/LoginForm';
import Navbar from '../Navbar';

type Props = {
  login: () => void,
}

class Login extends Component {
  static contextTypes = {
    router: PropTypes.object,
  }

  props: Props

  handleLogin = data => this.props.login(data, this.context.router);

  render() {
    return (
      <DocumentTitle title="Login">
        <div className="container">
          <Navbar />
          <div className="LoginForm">
          <LoginForm onSubmit={this.handleLogin} />
          </div>
      </div>
      </DocumentTitle>
    );
  }
}

export default connect(null, { login })(Login);
