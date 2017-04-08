var initialState = [];

export default function(state = initialState, action) {
  switch(action.type){
    case 'SET_MESSAGES':
      return action.data;
    default:
      return state;
  }
}
