import React, { Component } from 'react'; //import React Component
import Navbar from 'react-bootstrap/Navbar';

export class MyFooter extends Component {
    render() {
        return (
            <Navbar variant='light'>
                <Navbar.Text>
                    © 2020 Potluck, Inc. All rights reserved.
                </Navbar.Text>
            </Navbar>
        );
    }
}

export default MyFooter;