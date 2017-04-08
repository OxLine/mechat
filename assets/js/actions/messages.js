import { reset } from 'redux-form';
import api from '../api';

export function getMessages(username) {
  return dispatch => api.fetch('/messages/'+{username})
    .then((response) => {
      dispatch({type: 'SET_MESSAGES', response: response.data});
    });
}
