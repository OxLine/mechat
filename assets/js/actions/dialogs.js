import { reset } from 'redux-form';
import api from '../api';

export function getDialogs() {
  return dispatch => api.fetch('/dialogs/')
    .then((response) => {
      dispatch({type: 'SET_DIALOGS', response: response.data});
    });
}
