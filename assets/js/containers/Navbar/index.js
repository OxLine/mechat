// @flow
import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router';
import { logout } from '../../actions/session';

type Props = {
  logout: () => void,
  currentUser: Object,
  isAuthenticated: boolean,
}

class Navbar extends Component {
  static contextTypes = {
    router: PropTypes.object,
  }

  props: Props

  handleLogout = () => this.props.logout(this.context.router);

  render() {
    const { currentUser, isAuthenticated } = this.props;
    return(
      <div className="row">
        <nav className="col s12 l10 offset-l1 m10 offset-m1">
          <div className="nav-wrapper col s12">
            <Link className="left" to="/">Home </Link>
            
            { !isAuthenticated &&
              <span className="right">
                <Link to="/login">Login </Link>
                <Link to="/signup">Signup </Link>
              </span>
            }
            
            {isAuthenticated &&
              <span className="right">
                <span className="grey-text text-darken-2 username">{currentUser.username} </span>
                <a href="#" onClick={this.handleLogout}>Logout</a>
              </span>
            }
          </div>
        </nav>
      </div>
    );
  }
}


export default connect(
  state => ({
    isAuthenticated: state.session.isAuthenticated,
    currentUser: state.session.currentUser,
  }),
  { logout }
)(Navbar);
