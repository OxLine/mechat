import React from 'react';
import ReactDOM from 'react-dom';
import { browserHistory } from 'react-router';
import { Provider } from 'react-redux';
import { syncHistoryWithStore } from 'react-router-redux';
import configureStore from './store';
import App from './containers/App';

import 'materialize-css';

const store = configureStore(browserHistory);
const routerHistory = syncHistoryWithStore(browserHistory, store);

ReactDOM.render(
  <Provider store={store}>
    <App routerHistory={routerHistory} />
  </Provider>
  , document.getElementById('root')
);
