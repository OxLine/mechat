// @flow
import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import DocumentTitle from 'react-document-title';
import { signup } from '../../actions/session';
import SignupForm from '../../components/SignupForm';
import Navbar from '../Navbar';

type Props = {
  signup: () => void,
}

class Signup extends Component {
  static contextTypes = {
    router: PropTypes.object,
  }

  props: Props

  handleSignup = data => this.props.signup(data, this.context.router);

  render() {
    return (
      <DocumentTitle title="Signup">
        <div>
          <div className="container"><Navbar /></div>
          <div className="SignupForm">
            <SignupForm onSubmit={this.handleSignup} />
          </div>
        </div>
      </DocumentTitle>
    );
  }
}

export default connect(null, { signup })(Signup);
