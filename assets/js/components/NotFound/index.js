// @flow
import React from 'react';
import { Link } from 'react-router';

const NotFound = () =>
  <div>
    <p>Page not found</p>
    <p><Link to="/">Got to the home page →</Link></p>
  </div>;

export default NotFound;
