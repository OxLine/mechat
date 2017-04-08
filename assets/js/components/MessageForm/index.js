import React, { Component } from 'react';
import { Field, reduxForm } from 'redux-form';
import Input from '../Input';

type Props = {
  onSubmit: () => void,
  submitting: boolean,
  handleSubmit: () => void,
}

class MessageForm extends Component {
  props: Props

  handleSubmit = data => this.props.onSubmit(data);

  render() {
    const { handleSubmit, submitting } = this.props;

    return (
      <form onSubmit={handleSubmit(this.handleSubmit)}>
          <Field
            name="message"
            type="textarea"
            component="textarea"
            placeholder="Message text"
            ref="text"
            className="form-control input-field materialize-textarea"
          />
          <button
            type="submit"
            disabled={submitting}
            className="btn"
          >
            {submitting ? 'Submitting...' : 'Submit'}
          </button>
      </form>
    );
  }
}

const validate = (values) => {
  const errors = {};
  if (!values.message) {
    errors.message = 'Required';
  }
  return errors;
};

export default reduxForm({
  form: 'submitMessage',
  validate,
})(MessageForm);
