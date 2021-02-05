import React, { Component } from 'react';
import ListGroup from 'react-bootstrap/ListGroup';
import firebase from 'firebase/app';


export class PantryLI extends Component {
    constructor(props) {
        super(props);
        this.state = {
        }
    }

    handleClick = () => {
        if (this.props.list === "needs") {
            if (this.props.info.checked) {
                this.props.checkCallback(this.props.info[this.props.count], false, "needs");

                
            } else {
                this.props.checkCallback(this.props.info[this.props.count], true, "needs");

                
            }
        } else {
            if (this.props.info.checked) {
                this.props.checkCallback(this.props.info[this.props.count], false, "pantry");

                let newPantryItem = {
                    name: this.props.info[this.props.count],
                    checked: false
                }
                let pantryRef = firebase.database().ref(this.props.userkey + '/pantry');
    
                pantryRef.push(newPantryItem);
            } else {
                this.props.checkCallback(this.props.info[this.props.count], true, "pantry");

                let newPantryItem = {
                    name: this.props.info[this.props.count],
                    checked: true
                }
                let pantryRef = firebase.database().ref(this.props.userkey + '/pantry');
    
                pantryRef.push(newPantryItem);
            }
        }
    }

    render() {
        let component;
        if (this.props.info.checked) {
            component = <><ListGroup.Item onClick={this.handleClick}><i className="fa fa-check"></i>{this.props.info[this.props.count]}</ListGroup.Item></>;
        } else {
            component = <ListGroup.Item onClick={this.handleClick}>{this.props.info[this.props.count]}</ListGroup.Item>;
        }

        return (
            < >
            {component}
            </>
        );
    }
}

export default PantryLI;