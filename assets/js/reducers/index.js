import { combineReducers } from 'redux';
import { routerReducer } from 'react-router-redux';
import { reducer as form } from 'redux-form';
import session from './session';

const appReducer = combineReducers({
  form,
  session,
  routing: routerReducer,
});

export default function (state, action) {
  if( action.type === 'LOGOUT') {
    return appReducer(undefined, action);
  }
  return appReducer(state, action);
}
