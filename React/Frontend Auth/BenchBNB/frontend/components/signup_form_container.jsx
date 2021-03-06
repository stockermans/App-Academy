import React from 'react';
import { connect } from 'react-redux';
import { signup } from '../actions/session_actions';
import SessionForm from './session_form';

const mapStateToProps = (state, ownProps) => {
  return {
    errors: state.errors,
    formType: 'signup'
  };
};

const mapDispatchToProps = (dispatch) => ({
  processForm: (formData) => dispatch(signup(formData))
});

export default connect(mapStateToProps, mapDispatchToProps)(SessionForm);