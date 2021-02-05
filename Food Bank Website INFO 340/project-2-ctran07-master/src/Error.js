import React, { Component } from 'react'; //import React Component
import Alert from 'react-bootstrap/Alert';


export class MyError extends Component {
    render() {
        let errorType = this.props.errorType;
        let input = this.props.input;
        let message;
        if (errorType === "data"){
            message =   "Failed to load data";
        }
        else {
            message = "Your search: " + input + " did not yield results. Try another zipcode or expand your distance.";
        }
        return (
            <Alert key={'danger'} variant={'danger'}>
            {message}
          </Alert>
        );
    }
}

export default MyError;