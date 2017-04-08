import { createStore, applyMiddleware, combineReducers, compose } from 'redux';
import createLogger from 'redux-logger';
import thunk from 'redux-thunk';
import reducers from '../reducers';
import { routerMiddleware } from 'react-router-redux';

const loggerMiddleware = createLogger({
  level: 'info',
  collapsed: true,
});

export default function configureStore(browserHistory) {
  const router = routerMiddleware(browserHistory);
  const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
  // const reduxRouterMiddleware = syncHistoryWithStore(browserHistory);
  const createStoreWithMiddleware = composeEnhancers(applyMiddleware(thunk, router))(createStore);
  
  return createStoreWithMiddleware(reducers);
}
