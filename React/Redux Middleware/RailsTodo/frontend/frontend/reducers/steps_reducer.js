import { RECEIVE_STEPS, RECEIVE_STEP, REMOVE_STEP } from '../actions/step_actions';

const initialState = {};

const stepsReducer = (state = initialState, action) => {
  Object.freeze(state);

  switch (action.type) {
    case RECEIVE_STEPS:
      let objectCopy = Object.assign({}, state);

      action.steps.forEach((step) => {
        objectCopy[step.id] = step;
      });

      return objectCopy;

    case RECEIVE_STEP:
      let receiveNewState = Object.assign({}, state);
      let wasFound = false;
      let toCheck = action.step instanceof Array ? action.step[0] : action.step;

      Object.keys(receiveNewState).forEach((key) => {
        if (receiveNewState[key].id == toCheck.id) {
          wasFound = true;
          receiveNewState[key] = toCheck;
        }
      });

      if (!wasFound) {
        receiveNewState[toCheck.id] = toCheck;
      }
      return receiveNewState;

    case REMOVE_STEP:
      let newStateRemoved = Object.assign({}, state);
      Object.keys(newStateRemoved).forEach((key) => {
        if (newStateRemoved[key].id == action.id) {
          delete newStateRemoved[key];
        }
      })
      return newStateRemoved;

    default:
      return state;
  }
};

export default stepsReducer;

