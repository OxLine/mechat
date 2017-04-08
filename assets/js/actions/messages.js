import { reset } from 'redux-form';
import api from '../api';

export function getMessages(username) {
  return dispatch => api.fetch('/messages/'+username)
    .then((response) => {
      dispatch({type: 'SET_MESSAGES', response: response.data});
    });
}

export function submitMessage(data) {
  return dispatch => api.post('/messages/'+data.username, {message: data.message})
    .then((response) => {
      dispatch(reset('submitMessage'));
      dispatch({type: 'ADD_MESSAGE', response: response.data});
    });
}
