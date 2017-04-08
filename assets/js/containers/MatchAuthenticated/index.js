// @flow
import React, { Component } from 'react';
import { connect } from 'react-redux';
import { push } from 'react-router-redux';

type Props = {
  isAuthenticated: boolean,
  willAuthenticate: boolean,
}

class MatchAuthenticated extends Component {
  props: Props

  componentDidMount() {
    const { dispatch, isAuthenticated, willAuthenticate } = this.props;

    if ( !isAuthenticated && !willAuthenticate ) {
      dispatch(push('/login'));
    }
  }

  componentDidUpdate(prevProps, prevState) {
    const { dispatch, isAuthenticated, willAuthenticate } = this.props;

    if ( !isAuthenticated && !willAuthenticate ) {
      dispatch(push('/login'));
    }
  }

  render_or_redirect = () => {
    const { dispatch, isAuthenticated, willAuthenticate } = this.props;

    if (isAuthenticated) {
      return ( <div>{ this.props.children }</div>);
    } else {
      return null
    }
  }

  render() {
    return (
      <div>
        { this.render_or_redirect() }
      </div>
    );
  }
}

export default connect(
  state => ({
    isAuthenticated: state.session.isAuthenticated,
    willAuthenticate: state.session.willAuthenticate,
  })
)(MatchAuthenticated);
