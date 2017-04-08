import React, { Component } from 'react';
import { Field, reduxForm } from 'redux-form';
import { Link } from 'react-router';
import Input from '../Input';

type Props = {
  onSubmit: () => void,
  handleSubmit: () => void,
  submitting: boolean,
}

class LoginForm extends Component {
  props: Props

  handleSubmit = data => this.props.onSubmit(data);

  render() {
    const { handleSubmit, submitting } = this.props;

    return (
      <form
        onSubmit={handleSubmit(this.handleSubmit)}
      >
        <h3>Login to Mechat</h3>
        <Field name="email" type="text" component={Input} placeholder="Email" />
        <Field name="password" type="password" component={Input} placeholder="Password" />
        <div className="buttons">
      <button
          type="submit"
          disabled={submitting}
          className="btn"
        >
          {submitting ? 'Logging in...' : 'Login'}
        </button>
        <Link to="/signup" className="btn new-account">
          Create a new account
        </Link>
      </div>
      </form>
    );
  }
}

const validate = (values) => {
  const errors = {};
  if (!values.email) {
    errors.email = 'Required';
  }
  if (!values.password) {
    errors.password = 'Required';
  }
  return errors;
};

export default reduxForm({
  form: 'login',
  validate,
})(LoginForm);
