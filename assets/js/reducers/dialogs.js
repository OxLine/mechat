var initialState = [];

export default function(state = initialState, action) {
  switch(action.type){
    case 'SET_DIALOGS':
      return action.data;
    default:
      return state;
  }
}
