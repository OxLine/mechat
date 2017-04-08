var initialState = [];

export default function(state = initialState, action) {
  switch(action.type){
    case 'SET_MESSAGES':
      return action.data;
    case 'ADD_MESSAGE':
      return [...state, ...action.response];
    default:
      return state;
  }
}
