import React, { Component } from 'react'; //import React Component
import Modal from 'react-bootstrap/Modal';
import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';
import firebase from 'firebase/app';
import 'firebase/database';



export default class LogInModal extends Component {
    constructor(props) {
        super(props);

        this.handleShow = this.handleShow.bind(this);
        this.handleClose = this.handleClose.bind(this);
        this.state = {
            show: false,
            email: '',
            password: '',
            username: '',
            user: this.props.user,
        };
    }


    handleSignUp = () => {
        this.setState({errorMessage:null});
        console.log("Creating user", this.state.email);
    
        firebase.auth().createUserWithEmailAndPassword(this.state.email, this.state.password)
          .then((userCredential) => {
            let user = userCredential.user;
    
            let updatePromise = user.updateProfile({displayName: this.state.username})
            return updatePromise;
          })
          .then(() => {
            this.setState((prevState) => {
              let updatedUser = {...prevState.user, displayName: this.state.username}
              return {user: updatedUser}; //updating the state
            });
          })
          .catch((err) => {
            this.setState({errorMessage: err.message});
          })
          this.props.emailCallback(this.state.email);
          this.handleClose();
      }

      handleLogin = () => {
        this.setState({errorMessage:null}); //clear old error
    
        firebase.auth().signInWithEmailAndPassword(this.state.email, this.state.password)
          .catch((err) => {
            this.setState({errorMessage: err.message});
          })
          console.log(this.state.email);
          this.props.emailCallback(this.state.email);
          this.handleClose();
      }

      handleSignOut = () => {
        this.setState({errorMessage:null}); //clear old error
    
        firebase.auth().signOut()
        this.props.emailCallback(null);
        this.handleClose();
      }

      handleChange = (event) => {
        let field = event.target.name; //which input
        let value = event.target.value; //what value

        let changes = {}; //object to hold changes
        changes[field] = value; //change this field
        this.setState(changes); //update state
    }

    handleClose() {
        this.setState({ show: false });
    }

    handleShow() {
        this.setState({ show: true });
    }

    render() {
        return (
            <>
                <Button className='mx-3' variant="primary" onClick={this.handleShow}>Account</Button>

                <Modal show={this.state.show} onHide={this.handleClose}>
                    <Modal.Header closeButton>
                        <Modal.Title>Welcome!</Modal.Title>
                    </Modal.Header>

                    <Modal.Body>
                        <p>Enter your credentials to save and view your favorites.</p>
                        <Form>
                            <Form.Group controlId="formBasicEmail">
                                <Form.Label>Email address</Form.Label>
                                <Form.Control type="email" placeholder="Enter email" name="email" value={this.state.email} onChange={this.handleChange}/>
                                <Form.Text className="text-muted">
                                    We'll never share your email with anyone else.</Form.Text>
                            </Form.Group>

                            <Form.Group controlId="formBasicPassword">
                                <Form.Label>Password</Form.Label>
                                <Form.Control type="password" placeholder="Password" name="password" value={this.state.password} onChange={this.handleChange}/>
                            </Form.Group>
                        </Form>
                    </Modal.Body>
                    
                    <Modal.Footer>
                        <Button variant="link" onClick={this.handleSignOut}>Sign out</Button>
                        <Button variant="link" onClick={this.handleLogin}>Login</Button>
                        <Button variant="primary" onClick={this.handleSignUp}>Sign Up</Button>
                    </Modal.Footer>
                </Modal>
            </>
        );
    }
}