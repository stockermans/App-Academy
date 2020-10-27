import React from 'react';
import { receiveTodo } from '../../actions/todo_actions';
import { uniqueId } from '../../util';

class TodoForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      title: '',
      body: '',
      showingForm: false
    };

    this.handleTitleChange = this.handleTitleChange.bind(this);
    this.handleBodyChange = this.handleBodyChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.showTodoForm = this.showTodoForm.bind(this);
    this.handleSuccess = this.handleSuccess.bind(this);
  }

  handleTitleChange(event) {
    this.setState({
      title: event.target.value
    })
  }

  handleBodyChange(event) {
    this.setState({
      body: event.target.value
    });
  }

  handleSubmit(event) {
    const self = this;
    event.preventDefault();

    this.props.createTodo({
      todo: {
        title: this.state.title,
        body: this.state.body,
        done: false
      }
    }).then(() => {
      this.handleSuccess();
    });
  }

  showTodoForm() {
    this.props.clearErrors()
    this.setState({
      showingForm: !this.state.showingForm
    });
  }

  handleSuccess() {
    this.props.clearErrors()
    this.setState({
      title: '',
      body: '',
      showingForm: false
    });
  }

  static getDerivedStateFromProps(props, state) {
    let isTrue = props.errors.length > 0 ? true : state.showingForm;
    return {
      showingForm: isTrue
    }
  }

  render() {
    let resultingErrors = [];
    resultingErrors = this.props.errors.map((data, idx) => {
      return <li key={idx}>{data}</li>
    });

    let form = '';
    if (this.state.showingForm) {
      form =
        <div className='todo-form-inside'>
          <h3>Add New Todo</h3>
          <form className='clear-fix'>
            <div className='input-group'>
              <label htmlFor='todo-title'>Title</label>
              <input onChange={this.handleTitleChange} id='todo-title' type='text' value={this.state.title} placeholder='Enter your title...'></input>
            </div>
            <div className='input-group'>
              <label htmlFor='todo-body'>Body</label>
              <input onChange={this.handleBodyChange} id='todo-body' type='text' value={this.state.body} placeholder='Enter the body of your todo...'></input>
            </div>
            <div className='button-group'>
              <button onClick={this.handleSubmit} type='submit'>Submit</button>
            </div>
            <div><ul className='errors'>{resultingErrors}</ul></div>
          </form>
        </div>
      ;
    }

    return (
      <div className='todo-form'>
        <div className='showingForm' onClick={this.showTodoForm}>{this.state.showingForm ? 'Hide' : 'Add new todo'}</div>
        {form}
      </div>
    )
  }
}

export default TodoForm;