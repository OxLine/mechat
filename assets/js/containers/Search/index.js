import React, { Component } from 'react';
import { connect } from 'react-redux';

import { setSearchText } from '../../actions/search';

class Search extends Component {
  constructor (props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange() {
    const { dispatch } = this.props;
    const searchText = this.refs.searchText.value;
    dispatch(setSearchText(searchText));
  }

  render () {
    const {searchText} = this.props;

    return (
      <div className="container__header">
        <div>
          <input type="search" ref="searchText" placeholder="Search chat" value={searchText} onChange={this.handleChange}/>
        </div>
      </div>
    );
  }
}

export default connect(
  state => {
    return {
      searchText: state.searchText
    };
  }
)(Search);
