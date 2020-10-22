import ReactDOM from 'react-dom';
import React from 'react';
import configureStore from './store/store.js';
import Root from './components/root';

import { receiveTodos, receiveTodo } from './actions/todo_actions';
import { receiveSteps, receiveStep, removeStep } from './actions/step_actions';

import { allTodos, stepsByTodoId } from './reducers/selectors';

const store = configureStore();
window.store = store;
window.receiveTodo = receiveTodo;
window.receiveTodos = receiveTodos;
window.receiveSteps = receiveSteps;
window.receiveStep = receiveStep;
window.removeStep = removeStep;
window.allTodos = allTodos;
window.stepsByTodoId = stepsByTodoId;

function addLoggingToDispatch (inputStore) {
  let storeDispatch = inputStore.dispatch;
  return (action) => {
    console.log(inputStore.getState());
    console.log(action);
    storeDispatch(action);
    console.log(inputStore.getState());
  }
}

document.addEventListener('DOMContentLoaded', () => {
  store.dispatch = addLoggingToDispatch(store);
  const root = document.getElementById('root');
  ReactDOM.render(<Root store={store} />, root);
});
